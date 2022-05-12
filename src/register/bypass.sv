`include "../defines.svh"
module bypass(
    input SCORE_BOARD_DATA [3:0] score_board_data,

    output REG_WIDTH [3:0] result,

    input REG_WIDTH [1:0] execute_result,
    input REG_WIDTH [1:0] memory_result,
    input REG_WIDTH [1:0] commit_result
);

always_comb begin
    for(int i=0;i<4;i++) begin
        priority case(`true)
            score_board_data[i].position[2]: result[i]=execute_result[score_board_data[i].line];
            score_board_data[i].position[1]: result[i]=memory_result[score_board_data[i].line];
            score_board_data[i].position[0]: result[i]=commit_result[score_board_data[i].line];
        endcase
    end
end

endmodule