`include "../defines.svh"
module icache(
    input PC pc,
    output REG_WIDTH [3:0] inst
);

REG_WIDTH rom[127:0];

always_comb begin
    rom[0]=32'b001001_00001_00001_000000000000001;
    rom[1]=32'b001001_00001_00001_000000000000001;
    rom[2]=32'b001001_00001_00001_000000000000001;
    rom[3]=32'b001001_00001_00001_000000000000001;
end

always_comb begin
    inst[0]=rom[pc[17:2]];
    inst[1]=rom[pc[17:2]+4];
    inst[2]=rom[pc[17:2]+8];
    inst[3]=rom[pc[17:2]+12];
end

endmodule