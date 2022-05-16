`include"../defines.svh"
module bram_control (
    input logic clk,
    input logic rst_n,
    input bool[1:0] read_req,
    input REG_WIDTH[1:0] addr,
    output bool[1:0] write_ena,
    input REG_WIDTH[1:0] write_data,
    output REG_WIDTH[1:0] read_data,
    output bool[1:0] read_valid
);

genvar i;
generate
    for(i=0;i<4;i++)begin 
        blk_mem blk_memx(
            .clka(clk),
            .addra(addr[0]),
            .dina(write_data[0][i*8+7:i*8]),
            .douta(read_data[0][i*8+7:i*8]),
            .wea(write_ena[0]),
            .clkb(clk),
            .addrb(addr[1]),
            .dinb(write_data[1][i*8+7:i*8]),
            .doutb(read_data[1][i*8+7:i*8]),
            .web(write_ena[1])
        );
    end
endgenerate

localparam IDLE = 0,
            READING= 1;

logic state[1:0];
always_ff @(posedge clk) begin
    for(int i=0;i<2;i++) begin
        if(~rst_n) begin
            read_valid[i]<=0;
            state[i]<=IDLE;
        end else if(state[i]==IDLE) begin
            state[i]<=read_req[i]?READING:IDLE;
            read_valid<=0;
        end else if(state[i]==READING) begin
            state[i]<=IDLE;
            read_valid<=1;
        end
    end
end

endmodule