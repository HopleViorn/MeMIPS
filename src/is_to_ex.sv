`include "defines.svh"
module is_to_ex(
    input logic clk,
    input bool rst_n,
    input bool stall,
    input bool flash,

    input FU_REQUIRE[1:0] is_in,
    output FU_REQUIRE[1:0] ex_out
);

wire rst=~rst_n;
always_ff @( posedge clk  ) begin 
    if(rst==`true||flash==`true) begin
        ex_out<='{default:0};
    end else if(stall==`false) begin
        ex_out<=is_in;
    end //else keep
end

endmodule