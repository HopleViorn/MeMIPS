`include "../defines.svh"
module branch_predictor(
    input REG_WIDTH pc,
    input REG_WIDTH inst,
    output bool branch_taken,
    output bool is_branch,
    output REG_WIDTH branch_address
);

wire[2:0] op_0=inst[31:29];
wire[2:0] op_1=inst[28:26];

wire[31:0] pc_offset={{14{inst[15]}},inst[15:0],2'b0};
wire[31:0] pc_4=pc+4;
wire[31:0] pc_imm_addr=pc_4+pc_offset;

logic is_RETURN,is_CALL;

always_comb begin
    if(op_0==3'b0) begin
        case(op_1)
            3'b000:begin
                if(inst[5:1]==5'b00100) begin//JR JALR
                    branch_taken=`false;
                    branch_address=32'h80000000;//TODO
                    is_branch=`true;
                    is_RETURN=`true;
                    is_CALL=`false;
                end else begin
                    branch_taken=`false;
                    branch_address=32'b0;//TODO
                    is_branch=`false;
                    is_RETURN=`false;
                    is_CALL=`false;
                end
            end
            3'b001:begin
                if(inst[20:16]==5'b00000) begin//BLTZ
                    branch_taken=`true;
                    branch_address=pc_imm_addr;
                    is_branch=`true;
                    is_RETURN=`false;
                    is_CALL=`false;
                end else begin
                    branch_taken=`false;
                    branch_address=32'b0;
                    is_branch=`false;
                    is_RETURN=`false;
                    is_CALL=`false;
                end
            end
            3'b010:begin//J
                branch_taken=`true;
                branch_address={pc_4[31:28],inst[25:0],2'b0};
                is_branch=`true;
                is_RETURN=`false;
                is_CALL=`false;
            end
            3'b011:begin//JAL
                branch_taken=`true;
                branch_address={pc_4[31:28],inst[25:0],2'b0};
                is_branch=`true;
                is_RETURN=`false;
                is_CALL=`true;
            end
            default:begin
                if(pc_offset[31])begin
                    branch_taken=`true;
                    branch_address=pc_imm_addr;
                    is_branch=`true;
                    is_RETURN=`false;
                    is_CALL=`false;
                end else begin
                    branch_taken=`false;
                    branch_address=pc_imm_addr;
                    is_branch=`true;
                    is_RETURN=`false;
                    is_CALL=`false;
                end
            end
        endcase
    end else begin
        branch_taken=`false;
        branch_address=32'b0;
        is_branch=`false;
        is_RETURN=`false;
        is_CALL=`false;
    end
end


endmodule