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
commit commit0(
    .cmt_require(cmt_in)
);

endmodule