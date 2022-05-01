`include "../defines.sv"
module execute(
    input FU_REQUIRE[1:0] fu_require,
    output PC_CHECK pc_execute,
    output MEM_REQUIRE[1:0] mem_require
);

FU FU0(
    .fu_require(fu_require[0]),
    .pc_execute(pc_execute)
);
FU FU1(
    .fu_require(fu_require[1]),
    .alu_result(mem_require[1].result)
);

assign mem_require[0].mem_write_ena=fu_require[0].mem_write_ena;
assign mem_require[0].mem_read_ena=fu_require[0].mem_read_ena;
assign mem_require[0].write_reg_addr=fu_require[0].write_reg_addr;
assign mem_require[0].write_reg_need=fu_require[0].write_reg_need;

assign mem_require[1].mem_write_ena=fu_require[1].mem_write_ena;
assign mem_require[1].mem_read_ena=fu_require[1].mem_read_ena;
assign mem_require[1].write_reg_addr=fu_require[1].write_reg_addr;
assign mem_require[1].write_reg_need=fu_require[1].write_reg_need;

endmodule
