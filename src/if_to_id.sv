`include "defines.svh"
module if_to_id(
    input logic clk,
    input bool stall,
    input bool flash,
    input bool rst_n,
    input DECODE_REQUIRE[3:0] if_in,
    output DECODE_REQUIRE[3:0] id_out
);

wire rst=~rst_n;
always @(posedge clk) begin
    if(rst==`true||flash==`true) begin
        for(int i=0;i<4;i++) begin
            id_out[i]<='{default:0};
        end
    end else if(stall==`false)begin
        id_out<=if_in;
    end
end

endmodule