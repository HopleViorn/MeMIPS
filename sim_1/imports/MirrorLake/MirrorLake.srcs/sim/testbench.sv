`timescale 1ns/1ps

`include "../src/defines.svh"

module testbench();
reg clk;
reg rst_n;

logic[5:0] addr_rom,addr_ram;
wire[31:0] data_rom,data_ram;
v_rom v_rom0(
    .rst(~rst_n),
    .addr(addr_rom),
    .data(data_rom)
);

wire we_n,oe_n;
v_ram v_ram0(
    .rst(~rst_n),
    .addr(addr_ram),
    .data(data_ram),
    .we_n,.oe_n
);
thinpad_top thinpad_top0(
    .clk_50M(clk),.reset_btn(~rst_n),
    .base_ram_data(data_rom),  //BaseRAM数据，低8位与CPLD串口控制器共�?
    .base_ram_addr(addr_rom), //BaseRAM地址
    // .base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持�?0
    // .base_ram_ce_n,       //BaseRAM片�?�，低有�?
    // .base_ram_oe_n,       //BaseRAM读使能，低有�?
    // .base_ram_we_n,
    .ext_ram_data(data_ram),  //BaseRAM数据，低8位与CPLD串口控制器共�?
    .ext_ram_addr(addr_ram), //BaseRAM地址
    // .ext_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持�?0
    // .ext_ram_ce_n,       //BaseRAM片�?�，低有�?
    .ext_ram_oe_n(oe_n),       //BaseRAM读使能，低有�?
    .ext_ram_we_n(we_n)
);

localparam CLK_PERIOD = 20;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    #200000 $finish;
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