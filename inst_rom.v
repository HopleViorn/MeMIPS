module inst_rom(
    input wire rst,
    input wire[31:0] pc,
    input wire[31:0] pc_4,
    output reg[31:0] inst1,
    output reg[31:0] inst2
);

reg[31:0] rom [0:199];

always @(*) begin
    if(rst) begin
        inst1=32'b0;
    end else begin
        inst1=rom[pc];
    end
end

always @(*) begin
    if(rst) begin
        inst1=32'b0;
    end else begin
        inst1=rom[pc_4];
    end
end

endmodule