`include "../defines.svh"
module pc_select(
    input logic clk,
    input bool rst_n,
    output PC pc
);

bool rst=~rst_n;

always_ff @(posedge clk) begin
    if(rst==`true) begin
        pc<=32'b0;
    end else begin
        pc<=pc+4;
    end
end

endmodule