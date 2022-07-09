`include "../defines.svh"
module quick_decode(
    input PC pc,
    input REG_WIDTH inst,
    output bool is_branch,
    output bool predict_branch_taken,
    output REG_WIDTH predict_branch_address,
    output bool is_CALL,
    output bool is_RETURN
);

wire[2:0] op_0=inst[31:29];
wire[2:0] op_1=inst[28:26];

wire[31:0] pc_offset={{14{inst[15]}},inst[15:0],2'b0};
wire[31:0] pc_4=pc+4;
wire[31:0] pc_imm_addr=pc_4+pc_offset;

always_comb begin
    if(op_0==3'b0) begin
        case(op_1)
            3'b000:begin
                if(inst[5:1]==5'b00100) begin//JR JALR
                    predict_branch_taken=`true;
                    predict_branch_address=32'b0;//TODO
                    is_branch=`true;
                    is_RETURN=`true;
                    is_CALL=`false;
                end else begin
                    predict_branch_taken=`false;
                    predict_branch_address=32'b0;//TODO
                    is_branch=`false;
                    is_RETURN=`false;
                    is_CALL=`false;
                end
            end
            3'b001:begin
                if(inst[20:16]==5'b00000) begin//BLTZ
                    predict_branch_taken=`true;
                    predict_branch_address=pc_imm_addr;
                    is_branch=`true;
                    is_RETURN=`false;
                    is_CALL=`false;
                end else begin
                    predict_branch_taken=`false;
                    predict_branch_address=32'b0;
                    is_branch=`false;
                    is_RETURN=`false;
                    is_CALL=`false;
                end
            end
            3'b010:begin//J
                predict_branch_taken=`true;
                predict_branch_address={pc_4[31:28],inst[25:0],2'b0};
                is_branch=`true;
                is_RETURN=`false;
                is_CALL=`false;
            end
            3'b011:begin//JAL
                predict_branch_taken=`true;
                predict_branch_address={pc_4[31:28],inst[25:0],2'b0};
                is_branch=`true;
                is_RETURN=`false;
                is_CALL=`true;
            end
            default:begin
                predict_branch_taken=`true;
                predict_branch_address=pc_imm_addr;
                is_branch=`true;
                is_RETURN=`false;
                is_CALL=`false;
            end
        endcase
    end else begin
        predict_branch_taken=`false;
        predict_branch_address=32'b0;
        is_branch=`false;
        is_RETURN=`false;
        is_CALL=`false;
    end
end

endmodule