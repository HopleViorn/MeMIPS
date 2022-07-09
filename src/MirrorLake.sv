`include "defines.svh"
`define debug
module MirrorLake(
    input logic clk,
    input bool rst_n,

    input REG_WIDTH base_ram_data_in,
    output REG_WIDTH base_ram_addr,
    output logic[3:0] base_ram_be_n,
    output logic base_ram_we,

    input REG_WIDTH ext_ram_data_in,
    output REG_WIDTH ext_ram_data_out,
    output REG_WIDTH ext_ram_addr,
    output logic[3:0] ext_ram_be_n,
    output logic ext_ram_we,
    
    input logic rxd,
    output logic txd,

    output logic[7:0] number
);

wire rst=~rst_n;

bool stall_from_decode;
bool stall_from_issue;
bool stall_from_execute;
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
bool[2:0] post_is_stall_mask;
control control0(
      stall_from_decode,
      stall_from_issue,
      stall_from_execute,
      pc_from_execute.enable,
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
      flash_to_mem_cmt,

      post_is_stall_mask
);

PC_CHECK pc_from_execute;

DECODE_REQUIRE[3:0] if_out,id_in;


sram_interface icache_interface();
sram_interface dcache_interface();

crossbar crossbar0(
    .clk,.rst,

    .base_ram_data_in,.base_ram_addr,
    .base_ram_be_n,.base_ram_we,

    .ext_ram_data_in,.ext_ram_data_out,.ext_ram_addr,
    .ext_ram_be_n,.ext_ram_we,

    .rxd,.txd,
    .number,

    .icache(icache_interface.slave_r),
    .dcache(dcache_interface.slave_rw)
);

wire stall_from_fetch;

`ifdef debug
(*DONT_TOUCH="true"*)
`endif
fetch fetch0(
    .clk,.rst,
    .pc_from_execute,
    .stall(stall_to_if_id),
    .decode_require(if_out),
    .stall_from_fetch,
    .sram_port(icache_interface.master_r)
);

`ifdef debug
(*DONT_TOUCH="true"*)
`endif
if_to_id if_to_id0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall_to_if_id),
    .flash(flash_to_if_id|stall_from_fetch),
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
    .post_is_stall_mask(post_is_stall_mask),

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
    .rst_n(rst_n),
    .mem_require(mem_in),
    .cmt_require(mem_out),
    .memory_result(memory_result),
    .stall_from_memory(stall_from_memory),
    .sram_port(dcache_interface.master_rw)
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

    // .number
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