`include "../defines.sv"
module brunch_predictor(
    input INST inst_in,
    output INST inst_out,
    output PC brunch_address
);

PC_4 pc_4=inst_in.pc+4;

always_comb begin
    inst_out.pc=inst_in.pc;
    inst_out.inst=inst_in.inst;
    if(inst_in.inst[31:29]==3'b000) begin
        case(inst_in.inst[28:27])
            2'b00:begin//Special,RegImm
                inst_out.is_brunch=`false;//TODO RegImm,Special
                inst_out.brunch_taken=`false;
            end
            2'b01:begin//J 
                inst_out.is_brunch=`true;
                inst_out.brunch_taken=`true;
                brunch_address={pc_4[31:28],inst_in.inst[25:0],2'b00};
            end
            default:begin//B
                inst_out.is_brunch=`true;
                inst_out.brunch_taken=`true;
                brunch_address=pc_4+{{14{inst_in.inst[15]}},inst_in.inst[15:0],2'b00};
            end
        endcase
    end
end

endmodule