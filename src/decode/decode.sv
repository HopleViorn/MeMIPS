`include "../defines.svh"
module decode(
    input DECODE_REQUIRE[3:0] decode_require,
    output ISSUE_QUEUE_ELEMENT[3:0] issue_queue_element,

    //issue_queue
    output logic[2:0] issue_queue_push_number,
    input logic[2:0] iq_size_left,

    output bool stall_from_decode
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
wire[2:0] valid_inst=decode_require[0].valid_number;
always_comb begin;
    if(valid_inst>iq_size_left) begin
        stall_from_decode=`true;
        issue_queue_push_number=0;
    end else begin
        stall_from_decode=`false;
        issue_queue_push_number=valid_inst;
    end
end

endmodule