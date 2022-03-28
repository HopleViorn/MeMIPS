module ID(
    input wire rst,
    input wire[31:0] pc,
    input wire[31:0] inst,
    output reg[31:0] num1,
    output reg[31:0] num2
);

wire[5:0] op=inst[31:26];
wire[4:0] rs=inst[25:21];
wire[4:0] rt=inst[20:16];
wire[4:0] rd=inst[15:11];
wire[15:0] imm=inst[15:0];
wire[25:0] instr_index=inst[25:0];
wire[4:0] sa=inst[10:6];
wire[5:0] func=inst[5:0];

always @(*) begin


end

endmodule