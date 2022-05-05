`include "../defines.svh"
module memory(
    input MEM_REQUIRE[1:0] mem_require,
    output CMT_REQUIRE[1:0] cmt_require
);

REG_WIDTH[1:0] cache_result;
dcache dcache0(
    .write_ena({mem_require[1].mem_write_ena,mem_require[0].mem_write_ena}),
    .read_ena({mem_require[1].mem_read_ena,mem_require[0].mem_read_ena}),
    .mem_type({mem_require[1].mem_type,mem_require[0].mem_type}),
    .addr({mem_require[1].addr,mem_require[0].addr}),
    .write_data({mem_require[1].write_data,mem_require[0].write_data}),
    .read_data(cache_result)
);

assign cmt_require[0].result=mem_require[0].mem_read_ena?cache_result[0]:mem_require[0].result;
assign cmt_require[0].write_reg_need=mem_require[0].write_reg_need;
assign cmt_require[0].write_reg_addr=mem_require[0].write_reg_addr;

assign cmt_require[1].result=mem_require[1].mem_read_ena?cache_result[1]:mem_require[1].result;
assign cmt_require[1].write_reg_need=mem_require[1].write_reg_need;
assign cmt_require[1].write_reg_addr=mem_require[1].write_reg_addr;
endmodule