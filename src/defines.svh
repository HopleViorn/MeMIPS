`ifndef nuclear
`define nuclear

`define SIMULATION
`define CPU_clk 55000000

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

`define op_Special 6'b000_000
    `define op_Special_SLL 6'b000_000
    `define op_Special_SRL 6'b000_010
    `define op_Special_SRA 6'b000_011
    `define op_Special_SLLV 6'b000_100
    `define op_Special_SRLV 6'b000_110
    `define op_Special_SRAV 6'b000_111

    `define op_Special_JR 6'b001_000
    `define op_Special_JALR 6'b001_001

    `define op_Special_ADDU 6'b100_001
    `define op_Special_SUB 6'b100_010
    `define op_Special_AND 6'b100_100
    `define op_Special_OR 6'b100_101
    `define op_Special_XOR 6'b100_110
`define op_Special2 6'b011_100
    `define op_Special2_MUL 6'b000_010
typedef logic[31:0] PC;
typedef logic[31:0] REG_WIDTH;
typedef logic[4:0] REG_ADDR;
typedef logic[3:0] IQ_ADDR;
typedef logic bool;

// typedef struct packed {
//     logic[31:0] data_i,data_o;
//     logic[19:0] addr;
//     logic[3:0] be_n;
//     logic ce_n,wr;
// } sram_bus;

typedef struct packed {
    bool enable;
    PC pc_new;
} PC_CHECK;

//commmit
typedef struct packed {
    logic[31:0] result;
    bool write_reg_need;
    REG_ADDR write_reg_addr;
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
    REG_ADDR write_reg_addr;
} MEM_REQUIRE;

//execute
typedef enum logic[2:0] { 
    llu_nop,
    llu_eq,
    llu_neq,
    llu_gt,
    llu_ge,
    llu_lt,
    llu_le
} LLU_OP;
typedef enum logic[2:0] { 
    alu_nop,
    alu_add,
    alu_sub,
    alu_mul,
    alu_or,
    alu_xor,
    alu_and
} ALU_OP;

typedef enum logic[1:0] { arithmatic,shift,branch,memory } EXE_TYPE;
typedef enum logic[1:0] { nbc,b,j,jr } branch_TYPE;
typedef struct packed {
    EXE_TYPE exe_type;

    //ari
    ALU_OP alu_op;
    logic[31:0] num1;
    logic[31:0] num2;
    //shift
    logic shift_left;
    //branch
    PC pc;
    branch_TYPE branch_type;
    PC predict_pc_addr;
    bool predict_branch_taken;
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
    branch_TYPE branch_type;
    logic shift_left;
    PC predict_pc_addr;
    bool predict_branch_taken;
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

typedef struct packed {
    logic line;
    logic[2:0] position;
    logic[2:0] accept_mask;
} SCORE_BOARD_DATA;

//decode
typedef struct packed {
    PC pc;
    logic[31:0] inst;
    //branch predict
    logic[2:0] valid_number;
    PC predict_pc_addr;
    bool predict_branch_taken;
} DECODE_REQUIRE;

`endif