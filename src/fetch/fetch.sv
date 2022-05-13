`include "../defines.svh"
module fetch(
    input PC pc,
    output DECODE_REQUIRE[3:0] decode_require
);

REG_WIDTH[3:0]inst;
icache icache0(
    .pc(pc),
    .inst(inst)
);

always_comb begin
    for(int i=0;i<4;i++) begin
        decode_require[i].pc=pc+i*4;
        decode_require[i].inst=inst[i];
        decode_require[i].is_valid=(inst[i]!==32'bX);
        decode_require[i].predict_pc_addr=32'b0;
        decode_require[i].predict_brunch_taken=`false;
    end
end

endmodule