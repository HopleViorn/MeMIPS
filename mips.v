module mips(
    input wire clk,
    input wire rst
);


wire[31:0] fe_pc;
fe fe0(
    .clk(clk),
    .rst(rst),
    .pc(fe_pc)
);
wire[31:0] id_inst;

inst_rom inst_rom0(
    .pc(fe_pc),
    .inst(id_inst)
);

id id0(
    .pc(pc),
    .inst(id_inst),
    .rst(rst)
);


endmodule