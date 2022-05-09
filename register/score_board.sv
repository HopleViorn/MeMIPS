`include "../defines.svh"
module score_board(
    input logic clk,
    input bool rst_n,
    
    input bool [1:0] write_ena,
    input REG_ADDR [1:0] write_addr,
    input SCORE_BOARD_DATA [1:0] data_in,

    input REG_ADDR [3:0] read_addr,
    output SCORE_BOARD_DATA [3:0] data_out
);
bool rst=~rst_n;
SCORE_BOARD_DATA[31:0] score_board_ram;

always_comb begin
    if(rst==`false) begin
        for(int i=0;i<4;i++) begin
            data_out[i]=score_board_ram[read_addr[i]];
        end
    end else begin
        data_out='{default:0};
    end
end

always_ff @(posedge clk) begin
    if(rst==`true) begin
        for(int i=0;i<32;i++) begin
            score_board_ram[i]='{default:0};
        end
    end else if(write_ena==`true) begin
        for(int i=0;i<32;i++) begin
            case(i) 
                write_addr[0]: 
                    score_board_ram[i].position=data_in[0];
                write_addr[1]:
                    score_board_ram[i].position=data_in[1];
                default:
                    score_board_ram[i].position=score_board_ram[i].position>>1;
            endcase
        end
    end else begin
        for(int i=0;i<32;i++)begin
            score_board_ram[i].position=score_board_ram[i].position>>1;
        end
    end
end


endmodule