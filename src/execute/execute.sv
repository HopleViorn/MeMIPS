`include "../defines.svh"

module execute(
    input FU_REQUIRE[1:0] fu_require,
    output PC_CHECK pc_check,
    output MEM_REQUIRE[1:0] mem_require,
    output REG_WIDTH[1:0] execute_result
);

MEM_REQUIRE[1:0] test;

FU FU0(
    .fu_require(fu_require[0]),
    .pc_execute(pc_check),
    .mem_require(test[0])
);
FU FU1(
    .fu_require(fu_require[1]),
    .mem_require(test[1])
);

always_comb begin
    mem_require[0]=test[0];
    mem_require[1]=test[1];
end

assign execute_result[0]=test[0].result;
assign execute_result[1]=test[1].result;

endmodule
