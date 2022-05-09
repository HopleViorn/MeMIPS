`include "../defines.svh"
module decoder(
    input DECODE_REQUIRE decode_require,
    output ISSUE_QUEUE_ELEMENT issue_queue_element
);

assign issue_queue_element='{default:0};

endmodule