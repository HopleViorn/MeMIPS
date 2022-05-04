`include "../defines.svh"

module execute(
    input FU_REQUIRE[1:0] fu_require,
    output PC_CHECK pc_execute,
    output MEM_REQUIRE[1:0] mem_require
);

MEM_REQUIRE[1:0] test;

FU FU0(
    .fu_require(fu_require[0]),
    .pc_execute(pc_execute),
    .mem_require(test[0])
);
FU FU1(
    .fu_require(fu_require[1]),
    .mem_require(test[1])
);

assign mem_require[0]=test[0];
assign mem_require[1]=test[1];

endmodule
