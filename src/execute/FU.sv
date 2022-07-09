`include "../defines.svh"

module FU(
    input FU_REQUIRE fu_require,
    output PC_CHECK pc_execute,
    output MEM_REQUIRE mem_require
);
//TODO:shift
logic[31:0] alu_result;
alu alu0(
    .a(fu_require.num1),
    .b(fu_require.num2),
    .alu_op(fu_require.alu_op),
    .c(alu_result)
);

wire[31:0] shift_result=
    (fu_require.shift_left==`true?
        fu_require.num1<<fu_require.num2:
        fu_require.num1>>fu_require.num2);


PC pc_8;
adder pc_adder(
    .a(fu_require.pc),
    .b(32'd8),
    .c(pc_8)
);

//mem
assign mem_require.mem_write_ena=fu_require.mem_write_ena;
assign mem_require.mem_read_ena=fu_require.mem_read_ena;
assign mem_require.write_reg_need=fu_require.write_reg_need;
assign mem_require.write_reg_addr=fu_require.write_reg_addr;

//assign mem_require.result=fu_require.exe_type == branch?pc_8:alu_result;
always_comb begin
    case(fu_require.exe_type)
        branch:             mem_require.result=pc_8;
        arithmatic,memory:  mem_require.result=alu_result;
        shift:              mem_require.result=shift_result;
        default:            mem_require.result=32'b0;
    endcase
end

assign mem_require.write_data=fu_require.num2;
assign mem_require.mem_type=fu_require.mem_type;
//load save
adder mem_addr_calc(
    .a(fu_require.memory_addr_offset),
    .b(fu_require.num1),
    .c(mem_require.addr)
);

//branch 
//beq reg1,reg2,offset
//beq num1,num2,num3
//jr reg1
//jalr imm,reg1(saved to reg[imm])
logic llu_result;

llu llu0(
    .a(fu_require.num1),
    .b(fu_require.num2), 
    .llu_op(fu_require.llu_op),
    .c(llu_result)
);

//predictor_check
always_comb begin
    if(fu_require.exe_type==branch) begin
        case(fu_require.branch_type)
        b: begin
            if(llu_result==`true&&fu_require.predict_branch_taken==`false) begin
                pc_execute.enable=`true;
                pc_execute.pc_new=fu_require.predict_pc_addr;
            end else if(llu_result==`false&&fu_require.predict_branch_taken==`true) begin
                pc_execute.enable=`true;
                pc_execute.pc_new=pc_8;
            end else begin
                pc_execute.enable=`false;
                pc_execute.pc_new=32'b0;
            end
        end
        j: begin
            if(fu_require.predict_branch_taken==`false) begin
                pc_execute.enable=`true;
                pc_execute.pc_new=fu_require.predict_pc_addr;
            end else begin
                pc_execute.enable=`false;
                pc_execute.pc_new=32'b0;
            end
        end
        jr: begin
            if(fu_require.predict_branch_taken==`false||fu_require.predict_pc_addr!=fu_require.num1) begin
                pc_execute.enable=`true;
                pc_execute.pc_new=fu_require.num1;
            end else begin
                pc_execute.enable=`false;
                pc_execute.pc_new=32'b0;
            end
        end
        default: begin
            pc_execute.enable=`false;
            pc_execute.pc_new=32'b0;
        end
        endcase
    end else begin
        pc_execute.enable=`false;
        pc_execute.pc_new=32'b0;
    end
end

endmodule