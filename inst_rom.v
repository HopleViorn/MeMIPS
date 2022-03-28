module inst_rom(
    input wire rst,
    input wire[31:0] pc,
    output reg[31:0] inst
);

reg[31:0] rom [0:199];

always @(*) begin
    if(rst) begin
        inst=32'b0;
    end else begin
        inst=rom[pc];
    end
end

endmodule