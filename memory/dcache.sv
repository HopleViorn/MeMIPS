`include "../defines.svh"
module dcache(
    input bool[1:0] write_ena,
    input bool[1:0] read_ena,
    input MEM_TYPE[1:0] mem_type,
    input REG_WIDTH[1:0] addr,
    input REG_WIDTH[1:0] write_data,
    output REG_WIDTH[1:0] read_data
);
always_comb begin
    if(read_ena==`true) begin
        read_data=32'd23333;
    end else begin
        read_data<=32'b0;
    end
end

endmodule