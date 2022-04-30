module signed_extensio#(parameter A=16,B=32)(
    input logic[B-1:0] in,
    input logic[B-1:0] out
);

assign out={{(B-A){in[A-1]}},in[A-1:0]};

endmodule