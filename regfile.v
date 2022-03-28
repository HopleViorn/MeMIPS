module regfile(
    input wire clk,
    input wire rst,
    input wire      r1_ena,
    input wire[4:0] r1_addr,
    output reg[31:0]r1_out,

    input wire      r2_ena,
    input wire[4:0] r2_addr,
    output reg[31:0]r2_out,

    input wire      w1_ena,
    input wire[4:0] w1_addr,
    input wire[31:0]w1_data
);
reg[31:0] Reg [0:31];

always @(*)begin
    if(rst) begin
        r1_out<=32'b0;
    end else begin
        if(r1_ena)begin
            if(r1_addr==32'b0) r1_out<=32'b0;
            else    r1_out<=Reg[r1_addr];
        end else    r1_out<=32'b0;
    end
end

always @(*)begin
    if(rst) begin
        r2_out<=32'b0;
    end else begin
        if(r2_ena)begin
            if(r2_addr==32'b0) r2_out<=32'b0;
            else    r2_out<=Reg[r2_addr];
        end else    r2_out<=32'b0;
    end
end

always @(posedge clk) begin
    if(rst) begin
        Reg[0]<=32'b0;
    end else begin
        if(w1_ena) begin
            if(w1_addr!=32'b0) Reg[w1_addr]<=w1_data;
        end
    end
end

endmodule