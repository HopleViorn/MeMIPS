`include "defines.svh"
module control(
    input bool stall_from_decode,
    input bool stall_from_issue,
    input bool stall_from_execute,
    input bool flash_from_execute,
    input bool stall_from_memory,

    output logic[6:0] stall_signal,
    output logic[6:0] flash_signal
    //pc
    //if-id
    //id-is
    //iq
    //is
    //is-ex
    //ex-mem
    //mem-cmt
);

always_comb begin
    priority case(`true)
        stall_from_memory:  stall_signal=7'b1111110;
        stall_from_execute: stall_signal=7'b1111100;
        stall_from_issue:   stall_signal=7'b1111000;
        default:            stall_signal=7'b0000000;
    endcase
end

endmodule