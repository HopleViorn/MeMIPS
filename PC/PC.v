module PC(
    input wire clk,
    input wire rst,
    input wire[31:0] next_pc,
    output reg[31:0] pc,
    output reg[31:0] pc_4
);

always @(posedge clk) begin
    if(rst) begin pc<=32'b0;
    end else begin
        pc<=next_pc;
    end    
end

always @(posedge clk) begin
    if(rst) begin pc_4<=32'd4;
    end else begin
        pc_4<=next_pc+4;
    end    
end

endmodule