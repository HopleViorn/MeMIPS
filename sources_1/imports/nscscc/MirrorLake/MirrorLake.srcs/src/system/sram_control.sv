`include "../defines.svh"
module sram_control(
    input logic clk,rst,
    //master
    input logic[19:0] master_addr,
    input logic[3:0] master_be_n,
    input logic req,
    input logic wr,
    output logic data_ok,

    //sram
    output logic[19:0] ram_addr,
    output logic[3:0] ram_be_n,
    output logic ram_we_n,
    output logic ram_oe_n,
    output logic ram_ce_n
);

assign ram_addr=master_addr;
assign ram_be_n=master_be_n;
assign ram_ce_n=0;

bool busy;

always_comb begin
    if(rst) begin
        ram_we_n=1;
        ram_oe_n=1;
    end else begin
        if(busy&&req) begin
            ram_we_n=~wr;
            ram_oe_n=wr;
        end else begin
            ram_we_n=1;
            ram_oe_n=1;
        end
    end
end

always_ff @(posedge clk) begin
    if(rst) begin
        data_ok<=0;
        busy<=0;
    end else if(req&&busy==0) begin
        busy<=1;
        data_ok<=0;
    end else if(req&&busy==1) begin
        busy<=1;
        data_ok<=1;
    end else begin
        busy<=0;
        data_ok<=0;
    end
end

endmodule