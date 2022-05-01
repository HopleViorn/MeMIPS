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
typedef logic[31:0] REG;
typedef logic[5:0] REG_ADDR;
typedef logic bool;

typedef struct packed {
    bool enable;
    PC pc_new;
} PC_CHECK;

typedef struct packed {
    PC pc;
    logic[31:0] inst;
    bool is_brunch;
    bool brunch_taken;
} INST;
`define NOP '{32'b0,32'b0,1'b0,1'b0}

`define true 1'b1
`define false 1'b0

//commmit
typedef struct packed {
    logic[31:0] result;
    bool write_reg_need;
    logic[31:0] write_reg_addr;
} CMT_REQUIRE;

//memory
typedef struct packed {
    logic[31:0] addr;
    logic[31:0] result;
    bool mem_write_ena;
    bool mem_read_ena;
    //wb
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

typedef struct packed {
    logic[31:0] num1;
    logic[31:0] num2;
    bool is_brunch;
    bool brunch_taken;
    bool jr_type;
    logic[31:0] brunch_address;
    LLU_OP llu_op;
    ALU_OP alu_op;
    //mem
    bool mem_write_ena;
    bool mem_read_ena;
    //wb
    bool write_reg_need;
    logic[31:0] write_reg_addr;
} FU_REQUIRE;


//issue
typedef struct packed {
    PC pc;
    //is
    logic[31:0] imm;
    bool num1_need;
    logic[31:0] num1_addr;
    bool num2_need;
    logic[31:0] num2_addr;
    //ex
    bool is_brunch;
    bool brunch_taken;
    bool jr_type;
    logic[31:0] brunch_address;
    LLU_OP llu_op;
    ALU_OP alu_op;
    //mem
    bool mem_write_ena;
    bool mem_read_ena;
    //wb
    bool write_reg_need;
    logic[31:0] write_reg_addr;
} ISSUE_QUEUE_ELEMENT;

typedef struct packed {
    ISSUE_QUEUE_ELEMENT[3:0] decoded_inst;
} ISSUE_REQUIRE;

//decode