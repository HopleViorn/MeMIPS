`include "../defines.svh"
module fetch(
    input logic clk,
    input logic rst_n,
    input logic stall,
    input PC pc,
    output PC_CHECK pc_check,
    output DECODE_REQUIRE[3:0] decode_require
);

REG_WIDTH[3:0]inst;
icache icache0(
    .pc(pc),
    .inst(inst)
);

bool[3:0] predict_branch_taken;
bool[3:0] is_branch;
bool[3:0] is_CALL;
bool[3:0] is_RETURN;
REG_WIDTH[3:0] predict_branch_address;


REG_WIDTH push_data;
REG_WIDTH top_data;
bool push_ena;
bool pop_ena;

RAS RAS0(
    .clk(clk),
    .rst_n(rst_n),
    .stall(stall),
    .push_data(push_data),
    .top_data(top_data),
    .push_ena(push_ena),
    .pop_ena(pop_ena)
);

genvar i;
generate
    for(i=0;i<4;i++)begin
        quick_decode quick_decode_x(
            .pc(pc+4*i),
            .inst(inst[i]),
            .is_branch(is_branch[i]),
            .is_CALL(is_CALL[i]),
            .is_RETURN(is_RETURN[i]),
            .predict_branch_taken(predict_branch_taken[i]),
            .predict_branch_address(predict_branch_address[i])
        );
    end
endgenerate

assign pc_check.enable=`true;
/*
T___ pc=addr,valid=2
_T__
__T_ pc=addr,valid=4
___T pc+=12,valid=3

___B pc+=12,valid=3
____ pc+=16,valid=4
*/
always_comb begin
    priority case(`true) 
        predict_branch_taken[0]:begin
            decode_require[0].valid_number=2;
            pc_check.pc_new=is_RETURN[0]?top_data:predict_branch_address[0];
            if(is_CALL[0]) begin
                push_data=pc+8;
                push_ena=`true;
                pop_ena=`false;
            end else if(is_RETURN[0]) begin
                push_data=32'b0;
                push_ena=`false;
                pop_ena=`true;
            end else begin
                push_data=32'b0;
                push_ena=`false;
                pop_ena=`false;
            end


        end
        predict_branch_taken[1]:begin
            decode_require[0].valid_number=3;
            pc_check.pc_new=is_RETURN[1]?top_data:predict_branch_address[1];
            if(is_CALL[1]) begin
                push_data=pc+12;
                push_ena=`true;
                pop_ena=`false;
            end else if(is_RETURN[1]) begin
                push_data=32'b0;
                push_ena=`false;
                pop_ena=`true;
            end else begin
                push_data=32'b0;
                push_ena=`false;
                pop_ena=`false;
            end
        end
        predict_branch_taken[2]:begin
            decode_require[0].valid_number=4;
            pc_check.pc_new=is_RETURN[2]?top_data:predict_branch_address[2];
            if(is_CALL[2]) begin
                push_data=pc+16;
                push_ena=`true;
                pop_ena=`false;
            end else if(is_RETURN[2]) begin
                push_data=32'b0;
                push_ena=`false;
                pop_ena=`true;
            end else begin
                push_data=32'b0;
                push_ena=`false;
                pop_ena=`false;
            end
        end
        default:begin
            push_data=32'b0;
            push_ena=`false;
            pop_ena=`false;
            if(is_branch[3]) begin
                decode_require[0].valid_number=3;
                pc_check.pc_new=pc+12;
            end else begin
                decode_require[0].valid_number=4;
                pc_check.pc_new=pc+16;
            end
        end
    endcase
end

always_comb begin
    for(int i=0;i<4;i++) begin
        decode_require[i].pc=pc+i*4;
        decode_require[i].inst=inst[i];
        decode_require[i].predict_branch_taken=predict_branch_taken[i];
        decode_require[i].predict_pc_addr=is_RETURN[i]?top_data:predict_branch_address[i];
    end
end

endmodule