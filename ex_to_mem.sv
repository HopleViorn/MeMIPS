`include "defines.svh"
module ex_to_mem(
    input logic clk,
    input bool rst,
    input bool stall,
    input bool flash,

    input MEM_REQUIRE[1:0] ex_in,
    output MEM_REQUIRE[1:0] mem_out
);


always_ff @( posedge clk  ) begin 
    if(rst==`true||flash==`true) begin
        mem_out<='{default:0};
    end else if(stall==`false) begin
        mem_out<=ex_in;
    end //else keep
end

endmodule