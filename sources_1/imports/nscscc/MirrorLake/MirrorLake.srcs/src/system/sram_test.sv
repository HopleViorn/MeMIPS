`include "../defines.svh"
module sram_test(
    input logic clk,rst,
    inout wire[31:0] ext_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共享
    output wire[19:0] ext_ram_addr, //BaseRAM地址
    output wire[3:0] ext_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output logic ext_ram_ce_n,       //BaseRAM片选，低有效
    output logic ext_ram_oe_n,       //BaseRAM读使能，低有效
    output logic ext_ram_we_n       //BaseRAM写使能，低有效
);

REG_WIDTH data[64]={
    32'h00000002,
    32'h00000003,
    32'h00000005,
    32'h00000008,
    32'h0000000d,
    32'h00000015,
    32'h00000022,
    32'h00000037,
    32'h00000059,
    32'h00000090,
    32'h000000e9,
    32'h00000179,
    32'h00000262,
    32'h000003db,
    32'h0000063d,
    32'h00000a18,
    32'h00001055,
    32'h00001a6d,
    32'h00002ac2,
    32'h0000452f,
    32'h00006ff1,
    32'h0000b520,
    32'h00012511,
    32'h0001da31,
    32'h0002ff42,
    32'h0004d973,
    32'h0007d8b5,
    32'h000cb228,
    32'h00148add,
    32'h00213d05,
    32'h0035c7e2,
    32'h005704e7,
    32'h008cccc9,
    32'h00e3d1b0,
    32'h01709e79,
    32'h02547029,
    32'h03c50ea2,
    32'h06197ecb,
    32'h09de8d6d,
    32'h0ff80c38,
    32'h19d699a5,
    32'h29cea5dd,
    32'h43a53f82,
    32'h6d73e55f,
    32'hb11924e1,
    32'h1e8d0a40,
    32'hcfa62f21,
    32'hee333961,
    32'hbdd96882,
    32'hac0ca1e3,
    32'h69e60a65,
    32'h15f2ac48,
    32'h7fd8b6ad,
    32'h95cb62f5,
    32'h15a419a2,
    32'hab6f7c97,
    32'hc1139639,
    32'h6c8312d0,
    32'h2d96a909,
    32'h9a19bbd9,
    32'hc7b064e2,
    32'h61ca20bb,
    32'h297a859d,
    32'h8b44a658
};

logic[5:0] cc;

assign ext_ram_addr=cc;
assign ext_ram_data=data[cc];
assign ext_ram_be_n=4'b0000;
assign ext_ram_ce_n=0;
assign ext_ram_we_n=0;
assign ext_ram_oe_n=1;

always_ff @( posedge clk ) begin
    if(rst) begin
        cc<=0;
    end else cc<=cc+1;
end


endmodule