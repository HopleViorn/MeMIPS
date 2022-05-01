`include "../defines.sv"
module alu(
    input logic[31:0] a,
    input logic[31:0] b,
    input ALU_OP alu_op,
    output logic[31:0] c
);

always_comb begin
    case(alu_op)
        alu_add: c=a+b;
        alu_and: c=a&b;
        alu_mul: c=a*b;
        alu_or: c=a|b;
        alu_xor:c=a^b;
        default c=32'b0;
    endcase
end

endmodule