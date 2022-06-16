`include "../defines.svh"
module RAS(
    input logic clk,
    input logic rst_n,
    input logic stall,
    input REG_WIDTH push_data,
    output REG_WIDTH top_data,
    input logic push_ena,
    input logic pop_ena
);

REG_WIDTH[15:0] stack;
reg[3:0] top;
assign top_data=stack[top];

always_ff @( posedge clk ) begin
    if(~rst_n) begin
        for(int i=0;i<16;i++) begin
            stack[i]<=32'b0;
        end
        top<=4'b0;
    end else if(~stall) begin
        if(push_ena) begin
            stack[top]<=push_data;
            top<=top+1;
        end else if(pop_ena) begin
            top<=top-1;
        end 
    end
end


endmodule