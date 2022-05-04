`include "../defines.sv"
module bypass(
    input REG_ADDR [1:0] issue_require,
    output REG [1:0] result,

    input REG [1:0] execute_result,
    input REG_ADDR [1:0] execute_addr,
    input REG       memory_result,
    input REG_ADDR  memory_addr,
    input REG [1:0] commit_result,
    input REG_ADDR [1:0] commit_addr
);

endmodule