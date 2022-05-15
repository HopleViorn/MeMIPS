`include "../defines.svh"
module score_board(
    input logic clk,
    input bool rst_n,
    input bool stall,
    input bool flash,
    input bool [2:0] post_is_stall_mask,
    
    input bool [1:0] write_ena,
    input REG_ADDR [1:0] write_addr,
    input SCORE_BOARD_DATA [1:0] data_in,

    input REG_ADDR [3:0] read_addr,
    output SCORE_BOARD_DATA [3:0] data_out
);
wire rst=~rst_n;
SCORE_BOARD_DATA[31:0] score_board_ram;

always_comb begin
    for(int i=0;i<4;i++) begin
        data_out[i]=score_board_ram[read_addr[i]];
    end
end

always_ff @(posedge clk) begin
    if(rst==`true||flash==`true) begin
        for(int i=0;i<32;i++) begin
            score_board_ram[i]<='{default:0};
        end
    end else if(stall==`false) begin
        if(write_ena!=2'b00) begin
            for(int i=1/*pass0*/;i<32;i++) begin
                if(write_ena==2'b11&&write_addr[0]==write_addr[1]) begin
                    if(i==write_addr[1])
                        score_board_ram[i]<=data_in[1];
                    else score_board_ram[i].position<=(score_board_ram[i].position>>(((post_is_stall_mask&score_board_ram[i])==3'b0)?1:0));
                    
                end else begin
                    case(i)
                        write_addr[0]: score_board_ram[i]<=data_in[0];
                        write_addr[1]: score_board_ram[i]<=data_in[1];
                        default:
                            score_board_ram[i].position<=(score_board_ram[i].position>>(((post_is_stall_mask&score_board_ram[i])==3'b0)?1:0));
                    endcase
                end
            end
        end else begin
            for(int i=1;i<32;i++)begin
                score_board_ram[i].position<=(score_board_ram[i].position>>(((post_is_stall_mask&score_board_ram[i])==3'b0)?1:0));
            end
        end
    end
end


endmodule