`default_nettype none
`include "../defines.svh"
module thinpad_top(
    input wire clk_50M,           //50MHz 时钟输入
    input wire clk_11M0592,       //11.0592MHz 时钟输入（备用，可不用）

    input wire clock_btn,         //BTN5手动时钟按钮�??关，带消抖电路，按下时为1
    input wire reset_btn,         //BTN6手动复位按钮�??关，带消抖电路，按下时为1

    input  wire[3:0]  touch_btn,  //BTN1~BTN4，按钮开关，按下时为1
    input  wire[31:0] dip_sw,     //32位拨码开关，拨到“ON”时�??1
    output wire[15:0] leds,       //16位LED，输出时1点亮
    output wire[7:0]  dpy0,       //数码管低位信号，包括小数点，输出1点亮
    output wire[7:0]  dpy1,       //数码管高位信号，包括小数点，输出1点亮

    //BaseRAM信号
    inout wire[31:0] base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共�??
    output wire[19:0] base_ram_addr, //BaseRAM地址
    output wire[3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持�??0
    output wire base_ram_ce_n,       //BaseRAM片�?�，低有�??
    output wire base_ram_oe_n,       //BaseRAM读使能，低有�??
    output wire base_ram_we_n,       //BaseRAM写使能，低有�??

    //ExtRAM信号
    inout wire[31:0] ext_ram_data,  //ExtRAM数据
    output wire[19:0] ext_ram_addr, //ExtRAM地址
    output wire[3:0] ext_ram_be_n,  //ExtRAM字节使能，低有效。如果不使用字节使能，请保持�??0
    output wire ext_ram_ce_n,       //ExtRAM片�?�，低有�??
    output wire ext_ram_oe_n,       //ExtRAM读使能，低有�??
    output wire ext_ram_we_n,       //ExtRAM写使能，低有�??

    //直连串口信号
    output wire txd,  //直连串口发�?�端
    input  wire rxd,  //直连串口接收�??

    //Flash存储器信号，参�?? JS28F640 芯片手册
    output wire [22:0]flash_a,      //Flash地址，a0仅在8bit模式有效�??16bit模式无意�??
    inout  wire [15:0]flash_d,      //Flash数据
    output wire flash_rp_n,         //Flash复位信号，低有效
    output wire flash_vpen,         //Flash写保护信号，低电平时不能擦除、烧�??
    output wire flash_ce_n,         //Flash片�?�信号，低有�??
    output wire flash_oe_n,         //Flash读使能信号，低有�??
    output wire flash_we_n,         //Flash写使能信号，低有�??
    output wire flash_byte_n,       //Flash 8bit模式选择，低有效。在使用flash�??16位模式时请设�??1

    //图像输出信号
    output wire[2:0] video_red,    //红色像素�??3�??
    output wire[2:0] video_green,  //绿色像素�??3�??
    output wire[1:0] video_blue,   //蓝色像素�??2�??
    output wire video_hsync,       //行同步（水平同步）信�??
    output wire video_vsync,       //场同步（垂直同步）信�??
    output wire video_clk,         //像素时钟输出
    output wire video_de           //行数据有效信号，用于区分消隐�??
);

/* =========== Demo code begin =========== */

// 数码管连接关系示意图，dpy1同理
// p=dpy0[0] // ---a---
// c=dpy0[1] // |     |
// d=dpy0[2] // f     b
// e=dpy0[3] // |     |
// b=dpy0[4] // ---g---
// a=dpy0[5] // |     |
// f=dpy0[6] // e     c
// g=dpy0[7] // |     |
//           // ---d---  p

// 7段数码管译码器演示，将number�??16进制显示在数码管上面
wire[7:0] number;
SEG7_LUT segL(.oSEG1(dpy0), .iDIG(number[3:0])); //dpy0是低位数码管
SEG7_LUT segH(.oSEG1(dpy1), .iDIG(number[7:4])); //dpy1是高位数码管

reg[15:0] led_bits;
assign leds = led_bits;

always@(posedge clock_btn or posedge reset_btn) begin
    if(reset_btn)begin //复位按下，设置LED为初始�??
        led_bits <= 16'h1;
    end
    else begin //每次按下时钟按钮，LED循环左移
        led_bits <= {led_bits[14:0],led_bits[15]};
    end
end


wire clk_MMCM;
wire locked;
clk_wiz_0 clk_wiz_0_0(
    .reset(reset_btn),
    .clk_in1(clk_50M),
    .clk_out1(clk_MMCM),
    .locked
);
wire rst=~locked|reset_btn;


/* =========== Demo code end =========== */

`define MirrorLake
// `define SingleCycle
/* ======================================= */

`ifdef SingleCycle
// mips mips0(
//     .clk(clk_11M0592),.rst(~locked|reset_btn),
//     .base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共�??
//     .base_ram_addr, //BaseRAM地址
//     .base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持�??0
//     .base_ram_ce_n,       //BaseRAM片�?�，低有�??
//     .base_ram_oe_n,       //BaseRAM读使能，低有�??
//     .base_ram_we_n,
//     .ext_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共�??
//     .ext_ram_addr, //BaseRAM地址
//     .ext_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持�??0
//     .ext_ram_ce_n,       //BaseRAM片�?�，低有�??
//     .ext_ram_oe_n,       //BaseRAM读使能，低有�??
//     .ext_ram_we_n
// );

wire[31:0] ext_data;
wire[19:0] ext_addr;
wire[3:0] ext_be_n;
wire ext_req;
wire ext_wr;
wire ext_ok;
sram_control ext_ram_control(
    .clk(clk_MMCM),.rst(reset_btn),
    .master_addr(ext_addr),
    .master_be_n(ext_be_n),
    .req(ext_req),
    .wr(ext_wr),
    .data_ok(ext_ok),

    .ram_addr(ext_ram_addr),
    .ram_ce_n(ext_ram_ce_n),
    .ram_we_n(ext_ram_we_n),
    .ram_oe_n(ext_ram_oe_n),
    .ram_be_n(ext_ram_be_n)
);

mips_ctrl mips0(
    .clk(clk_MMCM),.rst(~locked|reset_btn),
    .ext_ram_addr(ext_addr),
    .ext_ram_data,
    .ext_ram_be_n(ext_be_n),
    .ext_ram_req(ext_req),
    .ext_ram_wr(ext_wr),
    .ext_ram_ok(ext_ok),

    .base_ram_addr,
    .base_ram_data,
    .base_ram_be_n
);

assign base_ram_ce_n=0;
assign base_ram_oe_n=0;
assign base_ram_we_n=1;
`endif


`ifdef MirrorLake
wire base_ram_we,ext_ram_we;
wire[31:0] base_ram_data_out,base_ram_data_in,ext_ram_data_out,ext_ram_data_in;
assign base_ram_data=base_ram_we?base_ram_data_out:32'bz;
assign base_ram_data_in=base_ram_data;

assign base_ram_we_n=~base_ram_we;
assign base_ram_oe_n=base_ram_we;
assign base_ram_ce_n=0;

assign ext_ram_data=ext_ram_we?ext_ram_data_out:32'bz;
assign ext_ram_data_in=ext_ram_data;

assign ext_ram_we_n=~ext_ram_we;
assign ext_ram_oe_n=ext_ram_we;
assign ext_ram_ce_n=0;

MirrorLake MirrorLake0(
    .clk(clk_MMCM),.rst_n(~rst),
    .base_ram_data_in,
    .base_ram_data_out,
    .base_ram_addr,
    .base_ram_be_n,
    .base_ram_we,

    .ext_ram_data_in,
    .ext_ram_data_out,
    .ext_ram_addr,
    .ext_ram_be_n,
    .ext_ram_we,

    .rxd,.txd,
    .number
);


`endif 


endmodule
