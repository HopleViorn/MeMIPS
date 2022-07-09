`include "defines.svh"
interface sram_interface();
    logic req;
    REG_WIDTH addr,dout,din;
    logic  ok,we;
    logic[3:0] be_n;
    MEM_TYPE mem_type;

    modport master_rw(
        input din,ok,
        output req,we,addr,mem_type,dout
    );
    modport slave_rw(
        output din,ok,
        input req,we,addr,mem_type,dout
    );

    modport master_r (
        input din,ok,
        output req,addr
    );
    modport slave_r (
        output din,ok,
        input req,addr
    );
endinterface 

module mem_post(
    input REG_WIDTH raw,
    input logic[1:0] addr,
    input MEM_TYPE mem_type,
    output REG_WIDTH data,
    output logic[3:0] be_n
);

always_comb begin
    if(mem_type==wrd)begin
        data=raw;
        be_n=4'b0;
    end else begin
        case(addr)
            2'b00: begin
                data={{24{raw[7]}},raw[7:0]};
                be_n=4'b1110;
            end
            2'b01: begin
                data={{24{raw[15]}},raw[15:8]};
                be_n=4'b1101;
            end
            2'b10: begin
                data={{24{raw[23]}},raw[23:16]};
                be_n=4'b1011;
            end
            2'b11: begin
                data={{24{raw[31]}},raw[31:24]};
                be_n=4'b0111;
            end
        endcase
    end
end

endmodule

module crossbar(
    input wire clk,rst,

    sram_interface.slave_r icache,
    sram_interface.slave_rw dcache,

    input REG_WIDTH base_ram_data_in,
    output REG_WIDTH base_ram_addr,
    output logic[3:0] base_ram_be_n,
    output logic base_ram_we,

    input REG_WIDTH ext_ram_data_in,
    output REG_WIDTH ext_ram_data_out,
    output REG_WIDTH ext_ram_addr,
    output logic[3:0] ext_ram_be_n,
    output logic ext_ram_we,

    input logic rxd,
    output logic txd,
    output logic[7:0] number

);
//0x80000000~0x803fffff
//1000 0000 0000
//1000 0000 0011

//1000 0000 0100
//1000 0000 0111
//0x80400000~0x807fffff

wire[1:0] is_base_ram,is_ext_ram;
assign is_base_ram[0]=(dcache.addr[31:22]==10'b1000_0000_00);
assign is_base_ram[1]=(icache.addr[31:22]==10'b1000_0000_00);
assign is_ext_ram[0]=(dcache.addr[31:22]==10'b1000_0000_01);
assign is_ext_ram[1]=(icache.addr[31:22]==10'b1000_0000_01);

wire is_uart_data,is_uart_state;
assign is_uart_data =(dcache.addr==32'hBFD003F8);
assign is_uart_state=(dcache.addr==32'hBFD003FC);

REG_WIDTH tmp_din,tmp_dout;
assign tmp_dout=(dcache.mem_type==byt)?{4{dcache.dout[7:0]}}:dcache.dout;
logic[3:0] dcache_be_n;
mem_post dcache_post(
    .addr(dcache.addr[1:0]),
    .raw(tmp_din),
    .data(dcache.din),
    .mem_type(dcache.mem_type),
    .be_n(dcache_be_n)
);

wire [7:0] ext_uart_rx;
reg  [7:0] ext_uart_buffer, ext_uart_tx;
logic ext_uart_ready, ext_uart_clear, ext_uart_busy;
reg ext_uart_start, ext_uart_avai;

assign number={3'b0,ext_uart_clear,ext_uart_avai,ext_uart_ready,ext_uart_busy,ext_uart_start};

async_receiver #(.ClkFrequency(50000000),.Baud(9600)) //接收模块，9600无检验位
    ext_uart_r(
        .clk(clk),                       //外部时钟信号
        .RxD(rxd),                           //外部串行信号输入
        .RxD_data_ready(ext_uart_ready),  //数据接收到标志
        .RxD_clear(ext_uart_clear),       //清除接收标志
        .RxD_data(ext_uart_rx)             //接收到的一字节数据
    );

async_transmitter #(.ClkFrequency(50000000),.Baud(9600)) //发送模块，9600无检验位
    ext_uart_t(
        .clk(clk),                  //外部时钟信号
        .TxD(txd),                      //串行信号输出
        .TxD_busy(ext_uart_busy),       //发送器忙状态指示
        .TxD_start(ext_uart_start),    //开始发送信号
        .TxD_data(ext_uart_tx)        //待发送的数据
    );
// assign ext_uart_clear = rst?1:ext_uart_ready; //收到数据的同时，清除标志，因为数据已取到ext_uart_buffer中

// always @(posedge clk) begin //接收到缓冲区ext_uart_buffer
//     if(rst) begin
//         ext_uart_buffer<=0;
//         ext_uart_avai<=0;
//     end else if(ext_uart_ready)begin
//         ext_uart_buffer <= ext_uart_rx;
//         ext_uart_avai <= 1;
//     end else begin 
//         ext_uart_avai <= 0;
//     end
// end

always@(posedge clk) begin
    if(rst) begin
        ext_uart_clear<=0;
    end else if(dcache.req&~dcache.we&is_uart_data)begin
        ext_uart_clear<=1;
    end else begin
        ext_uart_clear<=0;
    end
end

always @(posedge clk) begin //将缓冲区ext_uart_buffer发送出去 
    if(rst) begin
        ext_uart_start<=0;
        ext_uart_tx<=0;
    end else if(!ext_uart_busy && dcache.req && is_uart_data && dcache.we)begin 
        ext_uart_tx <= tmp_dout[7:0];
        ext_uart_start <= 1;
    end else begin 
        ext_uart_start <= 0;
    end
end

always_comb begin
    icache.din=base_ram_data_in;
end

logic ok1,ok2;
assign ok1=ok2<=~(dcache.req&is_base_ram[0]);
always_ff @(posedge clk) begin
    ok2<=~(dcache.req&is_base_ram[0]);
end
assign icache.ok=ok1&ok2;


always_comb begin
    dcache.ok=1;
    if(is_ext_ram[0])begin
        tmp_din=ext_ram_data_in;
    end else if(is_base_ram[0])begin
        tmp_din=base_ram_data_in;
    end else if(is_uart_data)begin
        tmp_din={4{ext_uart_rx}};
        // tmp_din={4{8'h54}};
    end else if(is_uart_state)begin
         tmp_din={30'b0,ext_uart_ready,~ext_uart_busy};
        //tmp_din={30'b0,1'b1,~ext_uart_busy};
    end else begin
        tmp_din=32'b0;
    end
end

//SRAM//
always_ff @(posedge clk) begin
    if(rst) begin
        base_ram_be_n<=4'b0;
        base_ram_we<=0;
        base_ram_addr<=20'b0;
    end else begin
        if(dcache.req&is_base_ram[0]) begin
            base_ram_be_n<=dcache_be_n;
            base_ram_we<=dcache.we;
            base_ram_addr<=dcache.addr[21:2];
        end else begin
            base_ram_be_n<=4'b0;
            base_ram_we<=0;
            base_ram_addr<=icache.addr[21:2];
        end
    end
end


always_ff @(posedge clk) begin
    if(rst) begin
        ext_ram_be_n<=4'b0;
        ext_ram_we<=0;
        ext_ram_addr<=20'b0;
        ext_ram_data_out<=32'b0;
    end else begin
        if(dcache.req&is_ext_ram[0]) begin
            ext_ram_be_n<=dcache_be_n;
            ext_ram_we<=dcache.we;
            ext_ram_addr<=dcache.addr[21:2];
            ext_ram_data_out<=tmp_dout;
        end else begin
            ext_ram_be_n<=4'b0;
            ext_ram_we<=0;
            ext_ram_addr<=20'b0;
            ext_ram_data_out<=32'b0;
        end
    end
end

endmodule   