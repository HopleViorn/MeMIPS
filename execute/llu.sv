`include "../defines.svh"
module llu(
    input logic[31:0] a,
    input logic[31:0] b,
    input LLU_OP llu_op,
    output bool c
);

always_comb begin
    case(llu_op)
        llu_eq:c=(a==b);
        llu_neq:c=(a!=b);
        llu_gt:c=(a>b);
        llu_ge:c=(a>=b);
        llu_lt:c=(a<b);
        llu_le:c=(a<=b);
    endcase
end

endmodule