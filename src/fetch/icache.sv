`include "../defines.svh"
module icache(
    input PC pc,
    output REG_WIDTH [3:0] inst
);

// `define OnBoard
`ifdef OnBoard
    REG_WIDTH rom[32]={
        32'h0800000b,
        32'h00000000,
        32'h34e7000a,
        32'h00411021,
        32'h24e7ffff,
        32'h34430000,
        32'h34220000,
        32'h14e0fffb,
        32'h34610000,
        32'h03e00008,
        32'h342a0000,
        32'h34010000,
        32'h0c000002,
        32'h34020001,
        32'h354b0000,
        32'h354c0000,
        32'h354d0000,
        32'h34010003,
        32'h0c000002,
        32'h34020005,
        32'h354b0000,
        32'h354c0000,
        32'h08000014,
        32'h354d0000,
        32'h00000000,
        32'h00000000,
        32'h00000000,
        32'h00000000,
        32'h00000000,
        32'h00000000,
        32'h00000000,
        32'h00000000
    };
    always_comb begin
        inst[0]=rom[pc[6:2]];
        inst[1]=rom[pc[6:2]+1];
        inst[2]=rom[pc[6:2]+2];
        inst[3]=rom[pc[6:2]+3];
    end
`else
REG_WIDTH rom[255:0];
initial begin
    $readmemh("inst_rom.data",rom);
end

always_comb begin
    inst[0]=rom[pc[10:2]];
    inst[1]=rom[pc[10:2]+1];
    inst[2]=rom[pc[10:2]+2];
    inst[3]=rom[pc[10:2]+3];
end
`endif

endmodule