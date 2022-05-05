`include "../defines.svh"
module issue(
    input logic clk,
    input logic rst,

    //issue queue
    input ISSUE_QUEUE_ELEMENT [1:0] issue_require,
    input IQ_ADDR iq_size,
    output logic[1:0] iq_pop_number,

    //bypass
    output SCORE_BOARD_DATA[3:0] score_board_data,
    input REG_WIDTH[3:0] bypass_result,

    //regfile
    output bool [3:0] regfile_read_ena,
    output REG_ADDR [3:0] regfile_read_addr,
    input REG_WIDTH [3:0] regfile_read_data,
    //ex
    output FU_REQUIRE[1:0] fu_require
);

bool [3:0] score_board_write_ena;
REG_ADDR [3:0] score_board_addr={
    issue_require[0].num1_addr,
    issue_require[0].num2_addr,
    issue_require[1].num1_addr,
    issue_require[1].num2_addr
};
SCORE_BOARD_DATA [3:0] score_board_write_data;
SCORE_BOARD_DATA [3:0] score_board_read_data;

score_board score_board0(
    .clk(clk),
    .rst(rst),
    .write_ena(score_board_write_ena),
    .addr(score_board_addr),
    .data_in(score_board_write_data),
    .data_out(score_board_read_data)
);

assign score_board_data[0]=score_board_read_data[0];
assign score_board_data[1]=score_board_read_data[1];
assign score_board_data[2]=score_board_read_data[2];
assign score_board_data[3]=score_board_read_data[3];
//LL
//BD

bool [1:0] num1_ready,num2_ready;

always_comb begin
    for(int i=0;i<2;i++) begin
        if(issue_require[i].num1_need==`false) begin//imm
            num1_ready[i]=`true;
            fu_require[i].num1=issue_require[i].num1;
        end else if(score_board_read_data[i*2].position==3'b0) begin//read from regfile
            num1_ready[i]=`true;
            fu_require[i].num1=regfile_read_data[i*2];
        end else begin
            if(score_board_read_data[i*2].position&score_board_read_data[i*2].accept_mask!=3'b0) begin//read from bypass
                num1_ready[i]=`true;
                fu_require[i].num1=bypass_result[i*2];
            end else begin//not ready
                num1_ready[i]=`false;
            end
        end
    end
end

always_comb begin
    if(issue_require[0].exe_type==brunch) begin

    end
end

endmodule