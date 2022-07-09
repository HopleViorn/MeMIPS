`include "../defines.svh"
module dcache(
    input logic clk,
    input logic rst_n,
    
    input REG_WIDTH[1:0] addr,
    input bool[1:0] req,
    input bool[1:0] we,

    input MEM_TYPE[1:0] mem_type,
    input REG_WIDTH[1:0] write_data,

    output bool[1:0] ok,
    output REG_WIDTH[1:0] read_data,

    sram_interface.master_rw sram_port
);

bool busy;

always_ff @(posedge clk) begin
    if(~rst_n) begin
        busy<=0;
    end else begin
        if(~busy) begin
            if(req[0]&sram_port.ok) begin
                busy<=1;
            end else begin
                busy<=0;
            end
        end else begin
            busy<=0;
        end
    end
end
assign read_data=sram_port.din;
assign ok[1]=1;
always_comb begin
    if(~rst_n) begin
        ok[0]=0;
        sram_port.req=0;
        sram_port.mem_type=wrd;
        sram_port.dout=32'b0;
        sram_port.we=1'b0;
        sram_port.addr=32'b0;
    end else begin
        if(~busy) begin
            if(req[0]) begin
                ok[0]=0;
                sram_port.req=1;
                sram_port.mem_type=mem_type[0];
                sram_port.dout=write_data;
                sram_port.we=we[0];
                sram_port.addr=addr[0];//
            end else begin
                ok[0]=1;
                sram_port.req=0;
                sram_port.mem_type=wrd;
                sram_port.dout=32'b0;
                sram_port.we=1'b0;
                sram_port.addr=32'b0;
            end
        end else begin
            ok[0]=1;
            sram_port.req=1;
            sram_port.mem_type=mem_type[0];
            sram_port.dout=write_data[0];
            sram_port.we=we[0];
            sram_port.addr=addr[0];
        end
    end
end

//rewrite
// assign read_data=32'd23333;
// assign read_valid=2'b11;

endmodule