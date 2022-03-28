`include "../includes/defines.v"
module ID(
//if
    input wire rst,
    input wire[31:0] pc,
    input wire[31:0] inst,

//regfile
    output reg[4:0] r1_ena,
    output reg[4:0] r1_addr,
    input wire[31:0]r1_data,

    output reg[4:0] r2_addr,
    output reg[4:0] r2_ena,
    input wire[31:0]r2_data,
//ex+mem
    output reg[31:0] num1,
    output reg[31:0] num2,
    output reg[2:0] alu_op,
    output reg load_ea,
    output reg save_ea,

//post_ex
    output reg wb_ena,
    output reg wb_addr
);

wire[5:0] op=inst[31:26];
wire[4:0] rs=inst[25:21];
wire[4:0] rt=inst[20:16];
wire[4:0] rd=inst[15:11];
wire[15:0] imm=inst[15:0];
wire[25:0] instr_index=inst[25:0];
wire[4:0] sa=inst[10:6];
wire[5:0] func=inst[5:0];

wire[31:0] imm_extension={16'b0,imm};
wire[31:0] imm_signed_extension={{16{imm[15]}},imm};

always @(*)begin 
    alu_op<=op[2:0];
end

always @(*) begin
    case(op)
        `op_ADDIU : begin
            r1_ena=1;
            r1_addr=rs;
            r2_addr=0;
            r2_addr=32'b0;

            num1=r1_data;
            num2=imm_signed_extension;
            load_ea=0;
            save_ea=0;

            wb_ena=1;
            wb_addr=rt;
        end
        `op_LW: begin
            r1_ena=1;
            r1_addr=rs;
            r2_addr=0;
            r2_addr=32'b0;

            num1=r1_data;
            num2=imm_signed_extension;
            load_ea=1;
            save_ea=0;

            wb_ena=1;
            wb_addr=rt;         
        end
        `op_LW: begin
            r1_ena=1;
            r1_addr=rs;
            r2_addr=0;
            r2_addr=32'b0;

            num1=r1_data;
            num2=imm_signed_extension;
            load_ea=0;
            save_ea=1;

            wb_ena=0;
            wb_addr=0;         
        end
        default : begin
            r1_ena=0;
            r2_addr=0;
            r1_addr=32'b0;
            r2_addr=32'b0;

            num1=32'b0;
            num2=32'b0;
            wb_ena=0;
            wb_addr=5'b0;
        end
    endcase

end

endmodule