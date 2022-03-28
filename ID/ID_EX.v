module ID_EX(
    input wire clk,
    input wire rst,
    input wire stall,
    input wire flash,

    //id
    input wire[31:0] id_num1,
    input wire[31:0] id_num2,
    input wire[2:0] id_aluop,
    input wire id_load_ea,
    input wire id_save_ea,
    //pos_ex
    input wire id_wb_ena,
    input wire id_wb_addr,

    //ex
    output reg[31:0] ex_num1,
    output reg[31:0] ex_num2,
    output reg[2:0] ex_aluop,
    output reg ex_load_ea,
    output reg ex_save_ea,
    //pos_ex
    output reg ex_wb_ena,
    output reg ex_wb_addr 
);

always @(*) begin
    if(rst||flash)begin
        ex_num1<=32'b0;
        ex_num2<=32'b0;
        ex_aluop<=3'b0;
        ex_load_ea<=0;
        ex_save_ea<=0;
        ex_wb_ena<=0;
        ex_wb_addr<=5'b0;
    end else if(~stall) begin
        ex_num1<=id_num1;
        ex_num2<=id_num2;
        ex_aluop<=id_aluop;
        ex_load_ea<=id_load_ea;
        ex_save_ea<=id_save_ea;
        ex_wb_ena<=id_wb_ena;
        ex_wb_addr<=id_wb_addr;
    end
end

endmodule