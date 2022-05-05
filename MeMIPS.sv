`include "defines.svh"
module MeMIPS(
    input logic clk,
    input logic rst
);

MEM_REQUIRE [1:0] ex_out,mem_in;
execute execute0(
    .mem_require(ex_out)
);

ex_to_mem ex_to_mem0(
    .clk(clk),
    .rst(rst),
    .ex_in(ex_out),
    .mem_out(mem_in)
);

CMT_REQUIRE[1:0] mem_out,cmt_in;
memory memory0(
    .mem_require(mem_in),
    .cmt_require(mem_out)
);
mem_to_cmt mem_to_cmt0(
    .clk(clk),
    .rst(rst),
    .mem_in(mem_out),
    .cmt_out(cmt_in)
);

REG_ADDR[1:0] regfile_write_addr;
REG_WIDTH[1:0] regfile_write_data;
bool[1:0] regfile_write_ena;
commit commit0(
    .cmt_require(cmt_in),
    .regfile_write_ena(regfile_write_ena),
    .regfile_write_data(regfile_write_data),
    .regfile_write_addr(regfile_write_addr)
);

regfile regfile0(
    .clk(clk),
    .rst(rst),
    .write_ena(regfile_write_ena),
    .write_addr(regfile_write_addr),
    .write_data(regfile_write_data)
);

endmodule