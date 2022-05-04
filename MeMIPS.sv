`include "defines.svh"
module MeMIPS(
    input logic clk,
    input logic rst
);

MEM_REQUIRE[1:0] mem_require;
execute execute0(
    .mem_require(mem_require)
);

CMT_REQUIRE[1:0] cmt_require;
memory memory0(
    .mem_require(mem_require),
    .cmt_require(cmt_require)
);

commit commit0(
    .cmt_require(cmt_require)
);

endmodule