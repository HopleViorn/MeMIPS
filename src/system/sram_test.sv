`include "../defines.svh"
module sram_test(
    input logic clk,rst,
    inout wire[31:0] base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共享
    output wire[19:0] base_ram_addr, //BaseRAM地址
    output wire[3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output wire base_ram_ce_n,       //BaseRAM片选，低有效
    output wire base_ram_oe_n,       //BaseRAM读使能，低有效
    output wire base_ram_we_n       //BaseRAM写使能，低有效
);

logic[1:0] burst;
logic[31:0] addr;
logic[127:0] data_read;
logic[31:0] data_write;

logic read_req,write_req,ok;

assign base_ram_data=data_write;
assign base_ram_addr=addr;
assign base_ram_ce_n=0;
assign base_ram_we_n=0;
assign base_ram_oe_n=1;
assign base_ram_be_n=4'b0000;


// sram_control base_ram_control0(
//     .clk,.rst,
//     .data_sram(base_ram_data),
//     .addr_sram(base_ram_addr),
//     .sram_be_n(base_ram_be_n),
//     .sram_ce_n(base_ram_ce_n),.sram_oe_n(base_ram_oe_n),.sram_we_n(base_ram_we_n),

//     .burst,.be_n_master(4'b1111),
//     .addr_master(addr),
//     .read_req,.write_req,.ok,
//     .data_master_read(data_read),
//     .data_master_write(data_write)
// );

reg nuclear;
always_ff @(posedge clk)begin
    if(rst) begin
        addr<=32'h00000001;
        write_req<=0;
        read_req<=0;
        burst<=0;
        data_write<=32'habcd1234;
        nuclear<=0;
    end else if(nuclear)begin
        write_req<=1;
        addr<=addr+4;
        nuclear<=0;
    end else begin
        write_req<=0;
        nuclear<=1;
    end
end

endmodule