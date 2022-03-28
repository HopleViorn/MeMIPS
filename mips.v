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
wire[4:0] ID_r1_ena;
wire[4:0] ID_r1_addr;
wire[31:0]ID_r1_data;

wire[4:0] ID_r2_addr;
wire[4:0] ID_r2_ena;
wire[31:0]ID_r2_data;

ID ID0(
    .rst(rst),
    //if
    .pc(if_PC_id),
    .inst(if_INST_id),
    //regfile
    .r1_ena(ID_r1_ena),
    .r1_addr(ID_r1_addr),
    .r1_data(ID_r1_data),
    
    .r2_ena(ID_r2_ena),
    .r2_addr(ID_r2_addr),
    .r2_data(ID_r2_data)
);

regfile regfile0(
    .clk(clk),
    .rst(rst),

    .r1_ena(ID_r1_ena),
    .r1_addr(ID_r1_addr),
    .r1_out(ID_r1_data),
    
    .r2_ena(ID_r2_ena),
    .r2_addr(ID_r2_addr),
    .r2_out(ID_r2_data)
    //TODO w1
);
 ID_EX ID_EX0(
    .clk(clk),
    .rst(rst)
    //.stall,
    //.flash,

 );


endmodule