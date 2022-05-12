`ifndef nuclear
`define nuclear

`define true 1'b1
`define false 1'b0

`define op_NOP 6'b000_000

`define op_J 6'b000_010
`define op_JAL 6'b000_011
`define op_BEQ 6'b000_100
`define op_BNE 6'b000_101
`define op_BLEZ 6'b000_110
`define op_BGTZ 6'b000_111

`define op_ADDIU 6'b001_001
`define op_ANDI 6'b001_100
`define op_ORI 6'b001_101
`define op_XORI 6'b001_110
`define op_LUI 6'b001_111

`define op_LB 6'b100_000
`define op_LW 6'b100_011
`define op_SB 6'b101_000
`define op_SW 6'b101_011

`define op_Secial 6'b000_000

typedef logic[31:0] PC;
typedef logic[31:0] REG_WIDTH;
typedef logic[4:0] REG_ADDR;
typedef logic[3:0] IQ_ADDR;
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
typedef enum logic { wrd,byt } MEM_TYPE;
typedef struct packed {
    logic[31:0] write_data;
    logic[31:0] addr;
    MEM_TYPE mem_type;
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
    llu_le,
    llu_nop
} LLU_OP;
typedef enum logic[2:0] { 
    alu_add,
    alu_sub,
    alu_mul,
    alu_or,
    alu_xor,
    alu_and
} ALU_OP;

typedef enum logic[1:0] { arithmatic,shift,brunch,memory } EXE_TYPE;
typedef enum logic[1:0] { b,j,jr,nbc } BRUNCH_TYPE;
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
    MEM_TYPE mem_type;
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
    logic[2:0] accept_mask;

    //ex
    EXE_TYPE exe_type;
    ALU_OP alu_op;
    BRUNCH_TYPE brunch_type;
    PC predict_pc_addr;
    bool predict_brunch_taken;
    LLU_OP llu_op;
    logic[31:0] memory_addr_offset;

    //mem
    MEM_TYPE mem_type;
    bool mem_write_ena;
    bool mem_read_ena;
    //wb
    bool write_reg_need;
    REG_ADDR write_reg_addr;
} ISSUE_QUEUE_ELEMENT;

//E-M-C
typedef struct packed {
    logic line;
    logic[2:0] position;
    logic[2:0] accept_mask;
} SCORE_BOARD_DATA;

//decode
typedef struct packed {
    PC pc;
    logic[31:0] inst;
    bool is_valid;
    //brunch predict
    PC predict_pc_addr;
    bool predict_brunch_taken;
} DECODE_REQUIRE;

`endif