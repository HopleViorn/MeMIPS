`include "defines.sv"

module fetch(
    input PC pc
);

INST inst;

icache icache0(
    .pc(pc),
    .inst(inst)
);

always_comb begin
end

endmodule