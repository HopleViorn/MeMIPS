`include "../defines.svh"
module fetch(
    input PC pc,
    output PC_CHECK pc_check,
    output DECODE_REQUIRE[3:0] decode_require
);

REG_WIDTH[3:0]inst;
icache icache0(
    .pc(pc),
    .inst(inst)
);

bool[3:0] predict_brunch_taken;
bool[3:0] is_brunch;
REG_WIDTH[3:0] predict_brunch_address;

genvar i;
generate
    for(i=0;i<4;i++)begin
        quick_decode quick_decode_x(
            .pc(pc+4*i),
            .inst(inst[i]),
            .is_brunch(is_brunch[i]),
            .predict_brunch_taken(predict_brunch_taken[i]),
            .predict_brunch_address(predict_brunch_address[i])
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
        predict_brunch_taken[0]:begin
            decode_require[0].valid_number=2;
            pc_check.pc_new=predict_brunch_address[i];
        end
        predict_brunch_taken[1]:begin
            decode_require[0].valid_number=3;
            pc_check.pc_new=predict_brunch_address[i];
        end
        predict_brunch_taken[2]:begin
            decode_require[0].valid_number=4;
            pc_check.pc_new=predict_brunch_address[i];
        end
        default:begin
            if(is_brunch[3]) begin
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
        decode_require[i].inst=inst[i];
    end
end

endmodule