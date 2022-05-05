`include "defines.svh"
module MeMIPS(
    input logic clk,
    input logic rst
);

ISSUE_QUEUE_ELEMENT[1:0] out_data;
logic[1:0] iq_pop_number;
IQ_ADDR iq_size;
IQ_ADDR iq_size_left;
issue_queue issue_queue0(
    .clk(clk),
    .rst(rst),
    //.in_data(),
    //.in_data_number(),
    .size_left(iq_size_left),
    .size(iq_size),
    .out_data_number(iq_pop_number),
    .out_data(out_data)
);

FU_REQUIRE[1:0] is_out,ex_in;
bool [1:0] regfile_read_ena;
REG_ADDR [1:0] regfile_read_addr;
REG_WIDTH [1:0] regfile_read_data;
issue issue0(
    .clk(clk),
    .rst(rst),
    .issue_require(out_data),
    .iq_size(iq_size),
    .iq_pop_number(iq_pop_number),

    .regfile_read_ena(regfile_read_ena),
    .regfile_read_addr(regfile_read_addr),
    .regfile_read_data(regfile_read_data),

    .fu_require(is_out)
);

is_to_ex is_to_ex0(
    .clk(clk),
    .rst(rst),
    .is_in(is_out),
    .ex_out(ex_in)
);

MEM_REQUIRE [1:0] ex_out,mem_in;
execute execute0(
    .fu_require(ex_in),
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

REG_ADDR[1:0] regfile_write_addr;
REG_WIDTH[1:0] regfile_write_data;
bool[1:0] regfile_write_ena;
commit commit0(
    .cmt_require(cmt_in),
    .regfile_write_ena(regfile_write_ena),
    .regfile_write_data(regfile_write_data),
    .regfile_write_addr(regfile_write_addr)
);

regfile regfile0(
    .clk(clk),
    .rst(rst),
    .read_ena(regfile_read_ena),
    .read_addr(regfile_read_addr),
    .read_data(regfile_read_data),
    .write_ena(regfile_write_ena),
    .write_addr(regfile_write_addr),
    .write_data(regfile_write_data)
);

endmodule