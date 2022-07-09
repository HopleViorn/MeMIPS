`include "../defines.svh"
module icache (
    input wire clk,rst,
    input REG_WIDTH pc,
    output bool hit,
    output REG_WIDTH[1:0] inst,

    sram_interface.master_r sram_port
);

typedef logic[147:0] LINE_WIDTH;

LINE_WIDTH line_din,line_dout;
bool we;

wire valid=line_dout[147];
wire[18:0] tag=line_dout[146:128];
assign hit=valid&(tag==pc[31:13]);
REG_WIDTH[3:0] block;
assign block[0]=line_dout[31:0];
assign block[1]=line_dout[63:32];
assign block[2]=line_dout[95:64];
assign block[3]=line_dout[127:96];
assign inst[0]=block[pc[3:2]];
assign inst[1]=(pc[3:2]==2'b11)?32'bz:block[pc[3:2]+1];


dist_mem_gen_0 cahce_ram (
    .a(pc[12:4]),
    .d(line_din),
    .spo(line_dout),
    .we,.clk
);

bool busy;
REG_WIDTH[2:0] buffer;
reg[1:0] burst_cc;

logic lst_ok;

always_ff@(posedge clk) lst_ok<=sram_port.ok;

always_ff @( posedge clk ) begin
    if(rst) begin
        busy<=0;
        burst_cc<=2'b00;
    end else begin
        if(~busy) begin//idle
            if(~hit) begin
                if(sram_port.ok) begin
                    busy<=1;
                    burst_cc<=0;
                end
            end else begin
                busy<=0;
                burst_cc<=0;
            end
        end else begin//busy
            if(lst_ok) begin
                buffer[burst_cc]<=sram_port.din;
            end
             if(sram_port.ok) begin
                burst_cc<=burst_cc+1;
                if(burst_cc==3'b11) begin
                    busy<=0;
                end else begin
                    busy<=1;
                end
             end else begin
                busy<=1;
             end
        end
    end
end

always_comb begin
    if(rst) begin
        we=0;
        line_din=146'd0;
        sram_port.req=0;
        sram_port.addr=32'b0;
    end else begin
        if(hit)begin
            we=0;
            line_din=0;
            sram_port.req=0;
            sram_port.addr=32'b0;
        end else begin
            if(~busy) begin
                sram_port.req=1;
                sram_port.addr={pc[31:4],4'b0};
            end else begin
                if(burst_cc==3'b11) begin
                    sram_port.req=1;
                    sram_port.addr={pc[31:4],2'b11,2'b0};;
                end else begin
                    sram_port.req=1;
                    sram_port.addr={pc[31:4],burst_cc+2'b01,2'b0};
                end

                if(burst_cc==3'b11&&sram_port.ok) begin
                    line_din={1'b1,pc[31:13],sram_port.din,buffer[2],buffer[1],buffer[0]};
                    we=1;
                end else begin
                    line_din=0;
                    we=0;
                end
            end
        end
    end
end


endmodule