`include "../defines.svh"
module icache(
    input bool ce,
    input PC pc,
    output REG_WIDTH [3:0] inst
);

REG_WIDTH rom[3:0][16383:0];

always_comb begin
    if(ce==`true) begin
        for(int i=0;i<4;i++) begin
            inst[i]=rom[i][pc[17:2]];
        end 
    end else begin
        inst={4{32'b0}};
    end
end

endmodule