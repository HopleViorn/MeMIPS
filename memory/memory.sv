`include "../defines.sv"
module memory(
    input MEM_REQUIRE[0:1] mem_require,
    output CMT_REQUIRE[0:1] cmt_require
);

REG cache_result;
dcache dcache0(
    .write_ena(mem_require[0].mem_write_ena),
    .read_ena(mem_require[0].mem_read_ena),
    .write_addr(mem_require[0].addr_or_result),
    .read_num(cache_result)
);

endmodule