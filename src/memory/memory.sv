`include "../defines.svh"
module memory(
    input logic clk,
    input logic rst_n,
    input MEM_REQUIRE[1:0] mem_require,
    output CMT_REQUIRE[1:0] cmt_require,
    output REG_WIDTH[1:0] memory_result,
    output bool stall_from_memory,
    sram_interface.master_rw sram_port
);

REG_WIDTH[1:0] cache_result;
bool[1:0] ok;
wire[1:0] req={mem_require[1].mem_write_ena|mem_require[1].mem_read_ena,mem_require[0].mem_write_ena|mem_require[0].mem_read_ena};
dcache dcache0(
    .clk(clk),
    .rst_n(rst_n),
    .req(req),
    .we({mem_require[1].mem_write_ena,mem_require[0].mem_write_ena}),
    .mem_type({mem_require[1].mem_type,mem_require[0].mem_type}),
    .addr({mem_require[1].addr,mem_require[0].addr}),
    .write_data({mem_require[1].write_data,mem_require[0].write_data}),
    .read_data(cache_result),
    .ok(ok),
    .sram_port
);

assign cmt_require[0].result=mem_require[0].mem_read_ena?cache_result[0]:mem_require[0].result;
assign cmt_require[0].write_reg_need=mem_require[0].write_reg_need;
assign cmt_require[0].write_reg_addr=mem_require[0].write_reg_addr;

assign cmt_require[1].result=mem_require[1].mem_read_ena?cache_result[1]:mem_require[1].result;
assign cmt_require[1].write_reg_need=mem_require[1].write_reg_need;
assign cmt_require[1].write_reg_addr=mem_require[1].write_reg_addr;

assign memory_result[0]=cmt_require[0].result;
assign memory_result[1]=cmt_require[1].result;

assign stall_from_memory=((req[0]&~ok[0])|(req[1]&~ok[1]));

endmodule