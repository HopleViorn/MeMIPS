`include "../defines.svh"
module dcache(
    input bool[1:0] write_ena,
    input bool[1:0] read_ena,
    input REG_WIDTH[1:0] addr,
    input REG_WIDTH[1:0] write_data,
    output REG_WIDTH[1:0] read_data
);

endmodule