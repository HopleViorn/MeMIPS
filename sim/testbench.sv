`timescale 1ns/1ps

`include "../src/defines.svh"

module testbench();
reg clk;
reg rst_n;
 
MeMIPS MeMIPS0(
    .clk (clk),
    .rst_n (rst_n)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    #1200 $finish;
end
initial begin
    #1 rst_n<=1'bx;clk<=1'bx;
    #(CLK_PERIOD*3) rst_n<=1;
    #(CLK_PERIOD*3) rst_n<=0;clk<=0;
    repeat(5) @(posedge clk);
    rst_n<=1;
    @(posedge clk);
    repeat(2) @(posedge clk);
end

endmodule