`include "../defines.svh"
module decoder(
    input DECODE_REQUIRE decode_require,
    output ISSUE_QUEUE_ELEMENT is_o
);

wire[5:0] op_code=decode_require.inst[31:26];
wire[4:0] rs=decode_require.inst[25:21];
wire[4:0] rt=decode_require.inst[20:16];
wire[4:0] rd=decode_require.inst[15:11];
wire[4:0] sa=decode_require.inst[10: 6];
wire[15:0] imm=decode_require.inst[15:0];
wire[31:0] imm_signed_extension={{16{imm[15]}},imm};
wire[31:0] imm_zero_extension={16'b0,imm};
wire[5:0] op_Special_code=decode_require.inst[5:0];
assign is_o.pc=decode_require.pc;

always_comb begin 
    case(op_code)
        `op_ORI:begin//op,rs,rt,imm (rt=reg[rs]|sign[imm])
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=imm_zero_extension;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=arithmatic;
        is_o.alu_op=alu_or;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;

        is_o.shift_left=`true;
        end
        `op_XORI:begin//xop,rs,rt,imm (rt=reg[rs]|sign[imm])
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=imm_zero_extension;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=arithmatic;
        is_o.alu_op=alu_xor;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;

        is_o.shift_left=`true;
        end
        `op_ANDI:begin//op,rs,rt,imm (rt=reg[rs]|sign[imm])
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=imm_zero_extension;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=arithmatic;
        is_o.alu_op=alu_and;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;

        is_o.shift_left=`true;
        end
        `op_LUI:begin//lui rt,imm
        is_o.num1_need=`false;
        is_o.num1={imm,16'b0};
        is_o.num1_addr=5'b0;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=arithmatic;
        is_o.alu_op=alu_or;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;

        is_o.shift_left=`true;
        end
        `op_ADDIU:begin//op,rs,rt,imm (rt=reg[rs]+sign[imm])
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=imm_signed_extension;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=arithmatic;
        is_o.alu_op=alu_add;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;

        is_o.shift_left=`true;
        end
        `op_J:begin//j imm28
        is_o.num1_need=`false;
        is_o.num1=32'b0;
        is_o.num1_addr=5'b0;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=branch;
        is_o.alu_op=alu_nop;
        is_o.branch_type=j;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;

        is_o.shift_left=`true;
        end
        `op_JAL:begin//jal imm28
        is_o.num1_need=`false;
        is_o.num1=32'b0;
        is_o.num1_addr=5'b0;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=branch;
        is_o.alu_op=alu_nop;
        is_o.branch_type=j;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=5'd31;

        is_o.shift_left=`true;
        end
        `op_BNE:begin//bne rs,rt,offset
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`true;
        is_o.num2=32'b0;
        is_o.num2_addr=rt;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=branch;
        is_o.alu_op=alu_nop;
        is_o.branch_type=b;
        is_o.llu_op=llu_neq;

        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;

        is_o.shift_left=`true;
        end
        `op_BEQ:begin//beq rs,rt,offset
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`true;
        is_o.num2=32'b0;
        is_o.num2_addr=rt;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=branch;
        is_o.alu_op=alu_nop;
        is_o.branch_type=b;
        is_o.llu_op=llu_eq;

        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;

        is_o.shift_left=`true;
        end
        `op_BGTZ:begin//bgtz rs,rt,offset
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=branch;
        is_o.alu_op=alu_nop;
        is_o.branch_type=b;
        is_o.llu_op=llu_gt;

        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;

        is_o.shift_left=`true;
        end
        `op_LW:begin//lw rt,imm(rs)
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b011;
        
        is_o.exe_type=memory;
        is_o.alu_op=alu_nop;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=imm_signed_extension;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`true;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;

        is_o.shift_left=`true;
        end
        `op_LB:begin//lb rt,imm(rs)
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b011;
        
        is_o.exe_type=memory;
        is_o.alu_op=alu_nop;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=imm_signed_extension;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`true;
        is_o.mem_type=byt;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;

        is_o.shift_left=`true;
        end
        `op_SW:begin//sw rt,imm(rs)
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`true;
        is_o.num2=32'b0;
        is_o.num2_addr=rt;
        is_o.accept_mask=3'b011;
        
        is_o.exe_type=memory;
        is_o.alu_op=alu_nop;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=imm_signed_extension;

        is_o.mem_write_ena=`true;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;

        is_o.shift_left=`true;
        end
        `op_SB:begin//sw rt,imm(rs)
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`true;
        is_o.num2=32'b0;
        is_o.num2_addr=rt;
        is_o.accept_mask=3'b011;
        
        is_o.exe_type=memory;
        is_o.alu_op=alu_nop;
        is_o.branch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=imm_signed_extension;

        is_o.mem_write_ena=`true;
        is_o.mem_read_ena=`false;
        is_o.mem_type=byt;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;

        is_o.shift_left=`true;
        end
        `op_Special:begin
            case(op_Special_code)
                `op_Special_JR:begin//jr rs
                is_o.num1_need=`true;
                is_o.num1=32'b0;
                is_o.num1_addr=rs;
                is_o.num2_need=`false;
                is_o.num2=32'b0;
                is_o.num2_addr=5'b0;
                is_o.accept_mask=3'b111;
                
                is_o.exe_type=branch;
                is_o.alu_op=alu_nop;
                is_o.branch_type=jr;
                is_o.llu_op=llu_nop;
                is_o.memory_addr_offset=32'b0;

                is_o.mem_write_ena=`false;
                is_o.mem_read_ena=`false;
                is_o.mem_type=wrd;

                is_o.write_reg_need=`false;
                is_o.write_reg_addr=5'b0;

                is_o.shift_left=`true;
                end
                `op_Special_JALR:begin//jalr rs
                is_o.num1_need=`true;
                is_o.num1=32'b0;
                is_o.num1_addr=rs;
                is_o.num2_need=`false;
                is_o.num2=32'b0;
                is_o.num2_addr=5'b0;
                is_o.accept_mask=3'b111;
                
                is_o.exe_type=branch;
                is_o.alu_op=alu_nop;
                is_o.branch_type=jr;
                is_o.llu_op=llu_nop;
                is_o.memory_addr_offset=32'b0;

                is_o.mem_write_ena=`false;
                is_o.mem_read_ena=`false;
                is_o.mem_type=wrd;

                is_o.write_reg_need=`true;
                is_o.write_reg_addr=5'd31;

                is_o.shift_left=`true;
                end
                `op_Special_ADDU:begin
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rs;
                    is_o.num2_need=`true;
                    is_o.num2=32'b0;
                    is_o.num2_addr=rt;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=arithmatic;
                    is_o.alu_op=alu_add;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`true;
                end
                `op_Special_SUB:begin
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rs;
                    is_o.num2_need=`true;
                    is_o.num2=32'b0;
                    is_o.num2_addr=rt;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=arithmatic;
                    is_o.alu_op=alu_sub;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`true;
                end
                `op_Special_OR:begin
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rs;
                    is_o.num2_need=`true;
                    is_o.num2=32'b0;
                    is_o.num2_addr=rt;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=arithmatic;
                    is_o.alu_op=alu_or;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`true;
                end
                `op_Special_AND:begin
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rs;
                    is_o.num2_need=`true;
                    is_o.num2=32'b0;
                    is_o.num2_addr=rt;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=arithmatic;
                    is_o.alu_op=alu_and;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`true;
                end
                `op_Special_XOR:begin
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rs;
                    is_o.num2_need=`true;
                    is_o.num2=32'b0;
                    is_o.num2_addr=rt;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=arithmatic;
                    is_o.alu_op=alu_xor;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`true;
                end
                `op_Special_SLL:begin//SLL rd,rt,sa
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rt;
                    is_o.num2_need=`false;
                    is_o.num2=sa;
                    is_o.num2_addr=32'b0;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=shift;
                    is_o.alu_op=alu_nop;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`true;
                end
                `op_Special_SRL:begin//SRL rd,rt,sa
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rt;
                    is_o.num2_need=`false;
                    is_o.num2=sa;
                    is_o.num2_addr=32'b0;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=shift;
                    is_o.alu_op=alu_nop;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`false;
                end
                `op_Special_SRLV:begin//SRLV rd,rt,sa
                    is_o.num1_need=`true;
                    is_o.num1=32'b0;
                    is_o.num1_addr=rt;
                    is_o.num2_need=`true;
                    is_o.num2=32'b0;
                    is_o.num2_addr=rs;
                    is_o.accept_mask=3'b111;
                    
                    is_o.exe_type=shift;
                    is_o.alu_op=alu_nop;
                    is_o.branch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;

                    is_o.shift_left=`false;
                end
                
            default: begin
               // is_o='{default:0};
                is_o.num1_need=`false;
                is_o.num1=32'b0;
                is_o.num1_addr=5'b0;
                is_o.num2_need=`false;
                is_o.num2=32'b0;
                is_o.num2_addr=5'b0;
                is_o.accept_mask=3'b111;
                
                is_o.exe_type=arithmatic;
                is_o.alu_op=alu_nop;
                is_o.llu_op=llu_nop;
                is_o.memory_addr_offset=32'b0;

                is_o.branch_type=nbc;
                is_o.mem_write_ena=`false;
                is_o.mem_read_ena=`false;
                is_o.mem_type=wrd;

                is_o.write_reg_need=`false;
                is_o.write_reg_addr=5'b0;
                
                is_o.shift_left=`true;
            end
            endcase
        end
        `op_Special2:begin
            if(op_Special_code==`op_Special2_MUL) begin
                is_o.num1_need=`true;
                is_o.num1=32'b0;
                is_o.num1_addr=rs;
                is_o.num2_need=`true;
                is_o.num2=32'b0;
                is_o.num2_addr=rt;
                is_o.accept_mask=3'b111;
                
                is_o.exe_type=arithmatic;
                is_o.alu_op=alu_mul;
                is_o.branch_type=nbc;
                is_o.llu_op=llu_nop;
                is_o.memory_addr_offset=32'b0;

                is_o.mem_write_ena=`false;
                is_o.mem_read_ena=`false;
                is_o.mem_type=wrd;

                is_o.write_reg_need=`true;
                is_o.write_reg_addr=rd;

                is_o.shift_left=`true;
            end else begin
                is_o.num1_need=`false;
                is_o.num1=32'b0;
                is_o.num1_addr=5'b0;
                is_o.num2_need=`false;
                is_o.num2=32'b0;
                is_o.num2_addr=5'b0;
                is_o.accept_mask=3'b111;
                
                is_o.exe_type=arithmatic;
                is_o.alu_op=alu_nop;
                is_o.branch_type=nbc;
                is_o.llu_op=llu_nop;
                is_o.memory_addr_offset=32'b0;

                is_o.mem_write_ena=`false;
                is_o.mem_read_ena=`false;
                is_o.mem_type=wrd;

                is_o.write_reg_need=`false;
                is_o.write_reg_addr=5'b0;

                is_o.shift_left=`true;
            end
        end
        default:begin
            // is_o='{default:0};
            is_o.num1_need=`false;
            is_o.num1=32'b0;
            is_o.num1_addr=5'b0;
            is_o.num2_need=`false;
            is_o.num2=32'b0;
            is_o.num2_addr=5'b0;
            is_o.accept_mask=3'b111;
            
            is_o.exe_type=arithmatic;
            is_o.alu_op=alu_nop;
            is_o.branch_type=nbc;
            is_o.llu_op=llu_nop;
            is_o.memory_addr_offset=32'b0;

            is_o.mem_write_ena=`false;
            is_o.mem_read_ena=`false;
            is_o.mem_type=wrd;

            is_o.write_reg_need=`false;
            is_o.write_reg_addr=5'b0;

            is_o.shift_left=`true;
        end

    endcase
end

assign is_o.predict_pc_addr=decode_require.predict_pc_addr;
assign is_o.predict_branch_taken=decode_require.predict_branch_taken;

endmodule