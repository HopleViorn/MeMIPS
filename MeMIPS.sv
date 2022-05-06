`include "defines.svh"
`define debug
module MeMIPS(
    input logic clk,
    input logic rst
);

ISSUE_QUEUE_ELEMENT[1:0] out_data;
logic[1:0] iq_pop_number;
logic[1:0] iq_size;
IQ_ADDR iq_size_left;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
issue_queue issue_queue0(
    .clk(clk),
    .rst(rst),
    //.in_data(),
    //.in_data_number(),
    .size_left(iq_size_left),
    //.size(iq_size),
    .iq_size(iq_size),
    .out_data_number(iq_pop_number),
    .out_data(out_data)
);

FU_REQUIRE[1:0] is_out,ex_in;
bool [3:0] regfile_read_ena;
REG_ADDR [3:0] regfile_read_addr;
REG_WIDTH [3:0] regfile_read_data;
REG_WIDTH[3:0] bypass_result;
SCORE_BOARD_DATA[3:0] score_board_data;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
issue issue0(
    .clk(clk),
    .rst(rst),

    .issue_require(out_data),
    .iq_size(iq_size),
    .iq_pop_number(iq_pop_number),

    .score_board_data(score_board_data),
    .bypass_result(bypass_result),

    .regfile_read_ena(regfile_read_ena),
    .regfile_read_addr(regfile_read_addr),
    .regfile_read_data(regfile_read_data),

    .fu_require(is_out)
);

`ifdef debug
(*DONT_TOUCH="true"*)
`endif
is_to_ex is_to_ex0(
    .clk(clk),
    .rst(rst),
    .is_in(is_out),
    .ex_out(ex_in)
);

MEM_REQUIRE [1:0] ex_out,mem_in;
REG_WIDTH[1:0] execute_result;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
execute execute0(
    .fu_require(ex_in),
    .mem_require(ex_out),
    .execute_result(execute_result)
);
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
ex_to_mem ex_to_mem0(
    .clk(clk),
    .rst(rst),
    .ex_in(ex_out),
    .mem_out(mem_in)
);

CMT_REQUIRE[1:0] mem_out,cmt_in;
REG_WIDTH[1:0] memory_result;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
memory memory0(
    .mem_require(mem_in),
    .cmt_require(mem_out),
    .memory_result(memory_result)
);
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
mem_to_cmt mem_to_cmt0(
    .clk(clk),
    .rst(rst),
    .mem_in(mem_out),
    .cmt_out(cmt_in)
);

REG_ADDR[1:0] regfile_write_addr;
REG_WIDTH[1:0] regfile_write_data;
bool[1:0] regfile_write_ena;
REG_WIDTH[1:0] commit_result;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
commit commit0(
    .cmt_require(cmt_in),
    .regfile_write_ena(regfile_write_ena),
    .regfile_write_data(regfile_write_data),
    .regfile_write_addr(regfile_write_addr),
    .commit_result(commit_result)
);
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
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

bypass bypass0(
    .score_board_data(score_board_data),
    .result(bypass_result),
    .execute_result(execute_result),
    .memory_result(memory_result),
    .commit_result(commit_result)
);

endmodule