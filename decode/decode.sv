`include "../defines.svh"
module decode(
    input DECODE_REQUIRE[3:0] decode_require,
    output ISSUE_QUEUE_ELEMENT[3:0] issue_queue_element,

    //issue_queue
    output logic[2:0] issue_queue_push_number,
    input logic[2:0] iq_size_left
);

ISSUE_QUEUE_ELEMENT[3:0] tmp;

genvar i;
generate
    for(i=0;i<4;i++) begin
        decoder decoderx(
            .decode_require(decode_require[i]),
            .is_o(tmp[i])
        );
    end
endgenerate

assign issue_queue_element=tmp;

endmodule