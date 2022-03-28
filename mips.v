module mips(
    input wire clk,
    input wire rst
);

//FE
wire[31:0] fe_PC_inst_rom;
IF IF0(
    .clk(clk),
    .rst(rst),
    .pc(fe_PC_inst_rom)
);
wire[31:0] inst_rom_INST_id;

inst_rom inst_rom0(
    .pc(fe_PC_inst_rom),
    .inst(inst_rom_INST_id)
);

//FE_ID
wire[31:0] fe_PC_id;
wire[31:0] fe_INST_id;

IF_ID IF_ID0(
    .clk(clk),
    .rst(rst),
    .fe_inst(inst_rom_INST_id),
    .fe_pc(fe_PC_id),
    .id_pc(fe_PC_id),
    .id_inst(fe_INST_id)
);

//ID
ID ID0(
    .pc(fe_PC_id),
    .inst(id_inst),
    .rst(rst)
);


endmodule