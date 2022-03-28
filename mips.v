module mips(
    input wire clk,
    input wire rst
);

//IF
wire[31:0] if_PC_inst_rom;
IF IF0(
    .clk(clk),
    .rst(rst),
    .pc(if_PC_inst_rom)
);
wire[31:0] inst_rom_INST_id;

inst_rom inst_rom0(
    .pc(if_PC_inst_rom),
    .inst(inst_rom_INST_id)
);

//IF_ID
wire[31:0] if_PC_id;
wire[31:0] if_INST_id;

IF_ID IF_ID0(
    .clk(clk),
    .rst(rst),
    .if_inst(inst_rom_INST_id),
    .if_pc(if_PC_id),
    .id_pc(if_PC_id),
    .id_inst(if_INST_id)
);

//ID
ID ID0(
    .pc(if_PC_id),
    .inst(id_inst),
    .rst(rst)
);


endmodule