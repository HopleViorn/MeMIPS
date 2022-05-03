`include "../defines.sv"
module memory(
    input MEM_REQUIRE[0:1] mem_require,
    output CMT_REQUIRE[0:1] cmt_require
);

bool write_ena=mem_require[0].write_ena|mem_require[1].write_ena;
bool read_ena=mem_require[0].read_ena|mem_require[1].read_ena;
logic[31:0] addr=(mem_require[0].write_ena||mem_require[0].read_ena)?mem_require[0].addr:mem_require[1].addr;
REG cache_result;

dcache dcache0(
    .write_ena(write_ena),
    .read_ena(read_ena),
    .write_addr(addr),
    .read_num(cache_result)
);

assign cmt_require[0].result=mem_require[0].read_ena||mem_require[1].read_ena?cache_result:mem_require[0].result;
assign cmt_require[0].write_reg_need=mem_require[0].write_reg_need;
assign cmt_require[0].write_reg_addr=mem_require[0].write_reg_addr;

assign cmt_require[1].result=mem_require[0].read_ena||mem_require[1].read_ena?cache_result:mem_require[1].result;
assign cmt_require[1].write_reg_need=mem_require[1].write_reg_need;
assign cmt_require[1].write_reg_addr=mem_require[1].write_reg_addr;
endmodule