`include "../defines.svh"
module pc_select(
    input logic clk,
    input bool rst_n,
    input bool stall,
    output PC pc
);

wire rst=~rst_n;

always_ff @(posedge clk) begin
    if(rst==`true) begin
        pc<=32'b0;
    end else if(stall==`false)begin
        pc<=pc+4;
    end
end

endmodule