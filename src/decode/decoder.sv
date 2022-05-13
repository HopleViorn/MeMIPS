`include "../defines.svh"
module decoder(
    input DECODE_REQUIRE decode_require,
    output ISSUE_QUEUE_ELEMENT is_o
);

wire[5:0] op_code=decode_require.inst[31:26];
wire[4:0] rs=decode_require.inst[25:21];
wire[4:0] rt=decode_require.inst[20:16];
wire[4:0] rd=decode_require.inst[15:11];
wire[15:0] imm=decode_require.inst[15:0];
wire[31:0] imm_signed_extension={{16{imm[15]}},imm};
wire[5:0] op_Special_code=decode_require.inst[5:0];
assign is_o.pc=decode_require.pc;

always_comb begin 
    case(op_code)
        `op_ORI:begin//op,rs,rt,imm (rt=reg[rs]|sign[imm])
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`false;
        is_o.num2=imm_signed_extension;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=arithmatic;
        is_o.alu_op=alu_or;
        is_o.brunch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;
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
        is_o.brunch_type=nbc;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=rt;
        end
        `op_J:begin//j imm28
        is_o.num1_need=`false;
        is_o.num1=32'b0;
        is_o.num1_addr=5'b0;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=brunch;
        is_o.alu_op=alu_nop;
        is_o.brunch_type=j;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;
        end
        `op_JAL:begin//jal imm28
        is_o.num1_need=`false;
        is_o.num1=32'b0;
        is_o.num1_addr=5'b0;
        is_o.num2_need=`false;
        is_o.num2=32'b0;
        is_o.num2_addr=5'b0;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=brunch;
        is_o.alu_op=alu_nop;
        is_o.brunch_type=j;
        is_o.llu_op=llu_nop;
        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`true;
        is_o.write_reg_addr=5'd31;
        end
        `op_BNE:begin//bne rs,rt,offset
        is_o.num1_need=`true;
        is_o.num1=32'b0;
        is_o.num1_addr=rs;
        is_o.num2_need=`true;
        is_o.num2=32'b0;
        is_o.num2_addr=rt;
        is_o.accept_mask=3'b111;
        
        is_o.exe_type=brunch;
        is_o.alu_op=alu_nop;
        is_o.brunch_type=b;
        is_o.llu_op=llu_neq;

        is_o.memory_addr_offset=32'b0;

        is_o.mem_write_ena=`false;
        is_o.mem_read_ena=`false;
        is_o.mem_type=wrd;

        is_o.write_reg_need=`false;
        is_o.write_reg_addr=5'b0;
        end
        `op_Special:begin
            case(op_Special_code)
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
                    is_o.brunch_type=nbc;
                    is_o.llu_op=llu_nop;
                    is_o.memory_addr_offset=32'b0;

                    is_o.mem_write_ena=`false;
                    is_o.mem_read_ena=`false;
                    is_o.mem_type=wrd;

                    is_o.write_reg_need=`true;
                    is_o.write_reg_addr=rd;
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

                is_o.brunch_type=nbc;
                is_o.mem_write_ena=`false;
                is_o.mem_read_ena=`false;
                is_o.mem_type=wrd;

                is_o.write_reg_need=`false;
                is_o.write_reg_addr=5'b0; 
            end
            endcase
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
            is_o.brunch_type=nbc;
            is_o.llu_op=llu_nop;
            is_o.memory_addr_offset=32'b0;

            is_o.mem_write_ena=`false;
            is_o.mem_read_ena=`false;
            is_o.mem_type=wrd;

            is_o.write_reg_need=`false;
            is_o.write_reg_addr=5'b0;
        end

    endcase
end

assign is_o.predict_pc_addr=decode_require.predict_pc_addr;
assign is_o.predict_brunch_taken=decode_require.predict_brunch_taken;

endmodule