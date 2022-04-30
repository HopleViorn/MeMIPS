`define op_NOP 000_000

`define op_J 000_010
`define op_JAL 000_011
`define op_BEQ 000_100
`define op_BNE 000_101
`define op_BLEZ 000_110
`define op_BGTZ 000_111

`define op_ADDIU 001_001
`define op_ANDI 001_100
`define op_ORI 001_101
`define op_XORI 001_110
`define op_LUI 001_111

`define op_LB 100_000
`define op_LW 100_011
`define op_SB 101_000
`define op_SW 101_011

`define op_Secial 000_000

typedef struct packed {
    logic[31:0] pc;
} PC;

`define NOP '{32'b0,32'b0,1'b0,1'b0}

typedef struct packed {
    PC pc;
    logic[31:0] inst;
    logic is_brunch;
    logic brunch_taken;
} INST;


`define true 1'b1
`define false 1'b0