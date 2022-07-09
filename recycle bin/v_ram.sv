`include "../defines.svh"
module v_ram(
	input wire rst,
	input logic[5:0] addr,
	inout logic[31:0] data,
    input wire we_n,
    input wire oe_n
);

logic[31:0] data_o,data_i;
assign data=oe_n?32'bz:data_o;
assign data_i=data;

typedef reg[31:0] REG_WIDTH;

REG_WIDTH ram[127];

assign #8 data_o=ram[addr];

always @(addr or data or we_n or rst) begin
    if(rst) begin
        for(int i=0;i<128;i++) begin
            ram[i]=32'b0;
        end
    end else if(~we_n) begin
        #8 ram[addr]=data;
    end
end

endmodule