`include "../defines.svh"
module regfile(
    input logic clk,
    input bool rst_n,
    input bool [3:0] read_ena,
    input REG_ADDR [3:0] read_addr,
    output REG_WIDTH [3:0] read_data,
    input bool[1:0] write_ena,
    input REG_ADDR[1:0] write_addr,
    input REG_WIDTH[1:0] write_data
);
bool rst=~rst_n;

logic[31:0] regs [0:31];

always_comb begin
    for(int i=0;i<4;i++) begin
        if(read_ena[i]==`true) begin
            if(read_addr[i]==5'b0) read_data[i]=32'b0;
            else begin 
                read_data[i]=regs[read_addr];
            end
        end else begin
            read_data[i]=32'b0;
        end
    end
end

always_ff @(posedge clk) begin
    if(rst==`true) begin
        for(int i=0;i<32;i++) begin
            regs[i]=32'b0;
        end
    end else begin
        for(int i=0;i<2;i++) begin
            if(write_ena[i]==`true) begin
                if(write_addr[i]!==5'b0) begin
                    regs[write_addr[i]]<=write_data[i];
                end
            end
        end
    end
end

endmodule