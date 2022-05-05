`ifndef nuclear
`define nuclear

`define true 1'b1
`define false 1'b0

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

typedef logic[31:0] PC;
typedef logic[31:0] REG_WIDTH;
typedef logic[4:0] REG_ADDR;
typedef logic bool;

typedef struct packed {
    bool enable;
    PC pc_new;
} PC_CHECK;

//commmit
typedef struct packed {
    logic[31:0] result;
    bool write_reg_need;
    logic[31:0] write_reg_addr;
} CMT_REQUIRE;


//memory
typedef struct packed {
    logic[31:0] write_data;
    logic[31:0] addr;
    bool mem_write_ena;
    bool mem_read_ena;
    //wb
    logic[31:0] result;
    bool write_reg_need;
    logic[31:0] write_reg_addr;
} MEM_REQUIRE;

//execute
typedef enum logic[2:0] { 
    llu_eq,
    llu_neq,
    llu_gt,
    llu_ge,
    llu_lt,
    llu_le
} LLU_OP;
typedef enum logic[2:0] { 
    alu_add,
    alu_sub,
    alu_mul,
    alu_or,
    alu_xor,
    alu_and
} ALU_OP;

typedef enum logic[1:0] { arithmatic,brunch,memory } EXE_TYPE;
typedef enum logic[1:0] { b,j,jr } BRUNCH_TYPE;
typedef struct packed {
    EXE_TYPE exe_type;

    //ari
    ALU_OP alu_op;
    logic[31:0] num1;
    logic[31:0] num2;
    //brunch
    PC pc;
    BRUNCH_TYPE brunch_type;
    PC predict_pc_addr;
    bool predict_brunch_taken;
    LLU_OP llu_op;
    //memory
    logic[31:0] memory_addr_offset;

    //mem
    bool mem_write_ena;
    bool mem_read_ena;
    //wb
    bool write_reg_need;
    REG_ADDR write_reg_addr;
} FU_REQUIRE;


//issue
typedef struct packed {
    PC pc;
    //is
    REG_WIDTH num1;
    bool num1_need;
    REG_ADDR num1_addr;
    REG_WIDTH num2;
    bool num2_need;
    REG_ADDR num2_addr;

    //ex
    EXE_TYPE exe_type;
    ALU_OP alu_op;
    BRUNCH_TYPE brunch_type;
    PC predict_pc_addr;
    bool predict_brunch_taken;
    LLU_OP llu_op;
    logic[31:0] memory_addr_offset;

    //mem
    bool mem_write_ena;
    bool mem_read_ena;
    //wb
    bool write_reg_need;
    REG_ADDR write_reg_addr;
} ISSUE_QUEUE_ELEMENT;

typedef struct packed {
    ISSUE_QUEUE_ELEMENT[3:0] decoded_inst;
} ISSUE_REQUIRE;

//decode

`endif