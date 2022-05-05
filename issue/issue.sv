`include "../defines.svh"
module issue(
    input logic clk,
    input logic rst,

    input ISSUE_QUEUE_ELEMENT [1:0] issue_require,
    input IQ_ADDR iq_size,
    output logic[1:0] iq_pop_number,

    output bool [1:0] regfile_read_ena,
    output REG_ADDR [1:0] regfile_read_addr,
    input REG_WIDTH [1:0] regfile_read_data,

    output FU_REQUIRE[1:0] fu_require
);

bool [1:0] score_board_write_ena;
REG_ADDR [1:0] score_board_addr;
SCORE_BOARD_DATA [1:0] score_board_write_data;
SCORE_BOARD_DATA [1:0] score_board_read_data;

score_board score_board0(
    .clk(clk),
    .rst(rst),
    .write_ena(score_board_write_ena),
    .addr(score_board_addr),
    .data_in(score_board_write_data),
    .data_out(score_board_read_data)
);
//LL
//BD
always_comb begin

end

endmodule