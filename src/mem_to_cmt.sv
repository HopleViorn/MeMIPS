`include "defines.svh"
module mem_to_cmt(
    input logic clk,
    input bool rst_n,
    input bool stall,
    input bool flash,

    input CMT_REQUIRE[1:0] mem_in,
    output CMT_REQUIRE[1:0] cmt_out
);

bool rst=~rst_n;
always_ff @( posedge clk  ) begin 
    if(rst==`true||flash==`true) begin
        cmt_out<='{default:0};
    end else if(stall==`false) begin
        cmt_out<=mem_in;
    end //else keep
end

endmodule