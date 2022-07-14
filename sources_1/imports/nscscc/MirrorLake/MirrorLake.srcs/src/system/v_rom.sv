`include "../defines.svh"
module v_rom(
	input wire rst,
	input logic[5:0] addr,
	output wire[31:0] data
);

typedef reg[31:0] REG_WIDTH;

REG_WIDTH ram[64]={
	32'h34080001,
    32'h34090001,
    32'h34110004,
    32'h340c0100,
    32'h3c048040,
    32'h008c6821,
    32'h01095021,
    32'h35280000,
    32'h35490000,
    32'hac890000,
    32'h8c8b0000,
    32'h152b0004,
    32'h34000000,
    32'h00912021,
    32'h148dfff7,
    32'h34000000,
    32'h1620ffff,
    32'h34000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000,
    32'h00000000};

assign data=ram[addr];

endmodule