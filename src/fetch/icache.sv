`include "../defines.svh"
module icache(
    input PC pc,
    output REG_WIDTH [3:0] inst
);

REG_WIDTH rom[127:0];

always_comb begin
    rom[0]=32'h34010001;
    rom[1]=32'h34020001;
    rom[2]=32'h34030000;
    rom[3]=32'h24040000;
    rom[4]=32'h24050001;
    rom[5]=32'h24060008;
end

always_comb begin
    inst[0]=rom[pc[10:2]];
    inst[1]=rom[pc[10:2]+4];
    inst[2]=rom[pc[10:2]+8];
    inst[3]=rom[pc[10:2]+12];
end

endmodule