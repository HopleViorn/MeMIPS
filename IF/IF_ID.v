module IF_ID(
    input wire clk,
    input wire rst,
    input wire stall,
    input wire flash,
    input wire[31:0] if_pc,
    input wire[31:0] if_inst,
    output reg[31:0] id_pc,
    output reg[31:0] id_inst
);

always @(posedge clk) begin
    if(rst||flash) begin
        id_pc<=32'b0;
        id_inst<=32'b0;
    end else if(~stall) begin
        id_pc<=if_pc;
        id_inst<=if_inst;
    end
end

endmodule