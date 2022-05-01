`include "../defines.sv"
module fetch2(
    input PC pc,
    output PC next_pc,

    output INST[1:0] inst
);

INST[1:0] inst_cache;
INST[1:0] inst_raw;
PC[1:0] brunch_address;

icache icache0(
    .pc(pc),
    .inst(inst_cache)
);

genvar i;
generate
    for(i=0;i<2;i++) begin
        brunch_predictor brunch_predictor_x(
            .inst_in(inst_cache),
            .inst_out(inst_raw),
            .brunch_address(brunch_address)
        );
    end   
endgenerate
always_comb begin
    if(inst_raw[0].is_brunch) begin
        inst[0]=inst_raw[0];
        inst[1]=inst_raw[1];
        if(inst_raw[0].brunch_taken) begin
            next_pc=brunch_address[0];
        end else begin
            next_pc=pc+8;
        end
    end else begin
        inst[0]=inst_raw[0];
        inst[1]=`NOP;
        next_pc=pc+4;
    end
end

endmodule