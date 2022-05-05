`include "../defines.svh"
module score_board(
    input logic clk,
    input logic rst,
    input bool write_ena,
    input REG_ADDR addr,
    input SCORE_BOARD_DATA data_in,
    output SCORE_BOARD_DATA data_out
);

SCORE_BOARD_DATA[31:0] score_board_ram;

always_comb begin
    if(rst==`false) begin
        data_out=score_board_ram[addr];
    end else begin
        data_out='{default:0};
    end
end

always_ff @(posedge clk) begin
    if(rst==`true) begin
        for(int i=0;i<32;i++) begin
            score_board_ram[i]='{default:0};
        end
    end
    if(write_ena==`true) begin
        score_board_ram[addr]=data_in;
    end
end


endmodule