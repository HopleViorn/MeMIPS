module brunch_predictor(
    input wire rst,
    input wire j_flag,
    input wire[31:0] pc,
    input wire[31:0] addr,
    output reg brunch_flag,
    output reg[31:0] brunch_addr
);

always @(*)begin
    if(rst||~j_flag) begin 
        brunch_flag=0;
        brunch_addr<=32'b0;
    end begin//always not take
        brunch_flag<=0;
        brunch_addr<=32'b0;
    end
end

endmodule