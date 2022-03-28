module IF(
    input wire clk,
    input wire rst,
    input wire[31:0] brunch_addr,
    input wire brucn_flag,
    output reg[31:0] pc
);

always @(posedge clk) begin
    if(rst) begin
    end else if(brucn_flag) begin
        pc<=brunch_addr;
    end else begin
        pc<=pc+4;
    end    
end

endmodule