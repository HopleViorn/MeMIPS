`include "defines.svh"
`define debug
module MeMIPS(
    input logic clk,
    input bool rst_n
);
wire rst=~rst_n;

bool stall_from_decode;
bool stall_from_issue;
bool stall_from_execute;
bool flash_from_execute;
bool stall_from_memory;

bool stall_to_pc;
bool stall_to_if_id;
bool stall_to_id_is;//make push number=0
bool stall_to_is;//score board
bool stall_to_is_ex;//make pop number=0    
bool stall_to_ex_mem;//
bool stall_to_mem_cmt;//

bool flash_to_if_id;
bool flash_to_id_is;
bool flash_to_iq;
bool flash_to_is_ex;
bool flash_to_ex_mem;
bool flash_to_mem_cmt;
control control0(
      stall_from_decode,
      stall_from_issue,
      stall_from_execute,
      flash_from_execute,
      stall_from_memory,

      stall_to_pc,
      stall_to_if_id,
      stall_to_id_is,//make push number=0
      stall_to_is,//score board
      stall_to_is_ex,//make pop number=0    
      stall_to_ex_mem,//
      stall_to_mem_cmt,//

      flash_to_if_id,
      flash_to_id_is,
      flash_to_iq,
      flash_to_is_ex,
      flash_to_ex_mem,
      flash_to_mem_cmt
);


PC pc_fetch;
PC_CHECK pc_from_fetch;
PC_CHECK pc_from_execute;
pc_select pc_select0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall_to_pc),
    .pc_from_fetch(pc_from_fetch),
    .pc_from_execute(pc_from_execute),
    .pc(pc_fetch)
);

DECODE_REQUIRE[3:0] if_out,id_in;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
fetch fetch0(
    .pc(pc_fetch),
    .pc_check(pc_from_fetch),
    .decode_require(if_out)
);
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
if_to_id if_to_id0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall_to_if_id),
    .flash(flash_to_if_id),
    .if_in(if_out),
    .id_out(id_in)
);

ISSUE_QUEUE_ELEMENT[3:0] in_data;
logic[2:0] in_data_number;
logic[2:0] iq_size_left;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
decode decode0(
    .decode_require(id_in),
    .issue_queue_push_number(in_data_number),
    .issue_queue_element(in_data),
    .iq_size_left(iq_size_left),
    .stall_from_decode(stall_from_decode)
);

ISSUE_QUEUE_ELEMENT[1:0] out_data;
logic[1:0] iq_pop_number;
logic[1:0] iq_size;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
issue_queue issue_queue0(
    .clk(clk),
    .rst_n(rst_n),
    .flash(flash_to_iq),
    //.stall,
    .in_data(in_data),
    .in_data_number(in_data_number),
    .iq_size(iq_size),
    .iq_size_left(iq_size_left),
    .out_data_number(iq_pop_number),
    .out_data(out_data)
);

FU_REQUIRE[1:0] is_out,ex_in;
REG_ADDR [3:0] regfile_read_addr;
REG_WIDTH [3:0] regfile_read_data;
REG_WIDTH[3:0] bypass_result;
SCORE_BOARD_DATA[3:0] score_board_data;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
issue issue0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall_to_is),
    .flash(`false),

    .issue_require(out_data),
    .iq_size(iq_size),
    .iq_pop_number(iq_pop_number),

    .score_board_data(score_board_data),
    .bypass_result(bypass_result),

    .regfile_read_addr(regfile_read_addr),
    .regfile_read_data(regfile_read_data),

    .fu_require(is_out)
);

`ifdef debug
(*DONT_TOUCH="true"*)
`endif
is_to_ex is_to_ex0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall_to_is_ex),
    .flash(flash_to_is_ex),
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
    .pc_check(pc_from_execute),
    .mem_require(ex_out),
    .execute_result(execute_result)
);
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
ex_to_mem ex_to_mem0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall_to_ex_mem),
    .flash(flash_to_ex_mem),
    .ex_in(ex_out),
    .mem_out(mem_in)
);

CMT_REQUIRE[1:0] mem_out,cmt_in;
REG_WIDTH[1:0] memory_result;
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
memory memory0(
    .clk(clk),
    .mem_require(mem_in),
    .cmt_require(mem_out),
    .memory_result(memory_result),
    .stall_from_memory(stall_from_memory)
);
`ifdef debug
(*DONT_TOUCH="true"*)
`endif
mem_to_cmt mem_to_cmt0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall_to_mem_cmt),
    .flash(flash_to_mem_cmt),
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
    .rst_n(rst_n),
    .read_addr(regfile_read_addr),
    .read_data(regfile_read_data),
    .write_ena(regfile_write_ena),
    .write_addr(regfile_write_addr),
    .write_data(regfile_write_data)
);

`ifdef debug
(*DONT_TOUCH="true"*)
`endif
bypass bypass0(
    .score_board_data(score_board_data),
    .result(bypass_result),
    .execute_result(execute_result),
    .memory_result(memory_result),
    .commit_result(commit_result)
);

endmodule