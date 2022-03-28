//op
`define op_Special  6'b000_000
`define op_RegImm   6'b000_000
`define op_J        6'b000_010  
`define op_JAL      6'b000_011
`define op_BEQ      6'b000_100
`define op_BNE      6'b000_101
`define op_BGTZ     6'b000_111

`define op_ADDIU    6'b001_001
`define op_ANDI     6'b001_100
`define op_ORI     `6'b001_101
`define op_XORI     6'b001_110
`define op_LUI      6'b001_111