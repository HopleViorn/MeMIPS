`include "../defines.svh"
module pc_select(
    input logic clk,
    input bool rst_n,
    input bool stall,

    input PC_CHECK pc_from_fetch,
    input PC_CHECK pc_from_execute,
    output PC pc
);

wire rst=~rst_n;

always_ff @(posedge clk) begin
    if(rst==`true) begin
        pc<=32'b0;
    end else if(stall==`false)begin
        if(pc_from_execute.enable==`true) begin
            pc<=pc_from_execute.pc_new;
        end else begin
            pc<=pc_from_fetch.pc_new;
        end
    end
end

endmodule