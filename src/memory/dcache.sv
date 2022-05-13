`include "../defines.svh"
module dcache(
    input logic clk,
    input bool[1:0] write_ena,
    input bool[1:0] read_ena,
    input MEM_TYPE[1:0] mem_type,
    input REG_WIDTH[1:0] addr,
    input REG_WIDTH[1:0] write_data,
    output bool[1:0] read_valid,
    output REG_WIDTH[1:0] read_data
);

//rewrite
assign read_data=32'd23333;
assign read_valid=2'b11;

endmodule