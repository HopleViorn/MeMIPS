`include "../defines.sv"
module execute(
    input FU_REQUIRE[1:0] fu_require,
    output PC_CHECK pc_execute,
    output MEM_REQUIRE[1:0] mem_require
);

FU FU0(
    .fu_require(fu_require[0]),
    .pc_execute(pc_execute),
    .mem_require(mem_require[0])
);
FU FU1(
    .fu_require(fu_require[1]),
    .mem_require(mem_require[1])
);

endmodule
