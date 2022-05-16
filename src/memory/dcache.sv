`include "../defines.svh"
module dcache(
    input logic clk,
    input logic rst_n,
    input bool[1:0] write_ena,
    input bool[1:0] read_ena,
    input MEM_TYPE[1:0] mem_type,
    input REG_WIDTH[1:0] addr,
    input REG_WIDTH[1:0] write_data,
    

    // output bool[1:0] read_req,
    // output REG_WIDTH[1:0] addr_sram,
    // output REG_WIDTH[1:0] din_sram,
    // output bool[1:0] we_sram,
    output bool[1:0] read_valid,
    output REG_WIDTH[1:0] read_data
);

bram_control bram_control0(
    .clk(clk),
    .rst_n(rst_n),
    .read_req(read_ena),
    .addr(addr),
    .write_ena(write_ena),
    .write_data(write_data),
    .read_data(read_data),
    .read_valid(read_valid)
);

//rewrite
// assign read_data=32'd23333;
// assign read_valid=2'b11;

endmodule