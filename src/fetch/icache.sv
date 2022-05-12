`include "../defines.svh"
module icache(
    input PC pc,
    output REG_WIDTH [3:0] inst
);

REG_WIDTH rom[127:0];
initial begin
    $readmemh("inst_rom.data",rom);
end

always_comb begin
    inst[0]=rom[pc[10:2]];
    inst[1]=rom[pc[10:2]+1];
    inst[2]=rom[pc[10:2]+2];
    inst[3]=rom[pc[10:2]+3];
end

endmodule