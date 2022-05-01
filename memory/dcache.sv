`include "../defines.sv"
module dcache(
    input bool write_ena,
    input logic[31:0] write_addr,
    input logic[31:0] write_num,

    input bool read_ena,
    output logic[31:0] read_num
);

endmodule