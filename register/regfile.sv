`include "../defines.svh"
module regfile(
    input logic clk,
    input bool [1:0] read_ena,
    input REG_ADDR [1:0] read_addr,
    output REG_WIDTH [1:0] read_data,
    input bool write_ena,
    input REG_ADDR write_addr,
    input REG_WIDTH write_data
);

logic[31:0] regs [0:31];

always_comb begin
    for(int i=0;i<2;i++) begin
        if(read_ena[i]==`true) begin
            if(read_addr[i]==5'b0) read_data[i]=32'b0;
            else begin 
                read_data[i]=regs[read_addr];
            end
        end
    end
end

always_ff @(posedge clk) begin
    if(write_ena==`true) begin
        if(write_addr!==5'b0) begin
            regs[write_addr]<=write_data;
        end
    end
end

endmodule