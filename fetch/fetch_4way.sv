`include "../defines.svh"
module fetch(
    input PC pc,
    output PC_CHECK pc_fetch,
    output INST[3:0] inst
);

INST[3:0] inst_cache;
INST[3:0] inst_raw;
PC[3:0] brunch_address;

icache icache0(
    .pc(pc),
    .inst(inst_cache)
);

genvar i;
generate
    for(i=0;i<4;i++) begin
        brunch_predictor brunch_predictor_x(
            .inst_in(inst_cache),
            .inst_out(inst_raw),
            .brunch_address(brunch_address)
        );
    end   
endgenerate
//BDXB
//BDXX
//BDBD
//XBDX
//XBDB
//XXBD
//XXXB
//XXXX

logic mark=`false;
always_comb begin
    pc_fetch.enable=`true;
    for(int i=0;i<3;++i) begin
        if(inst_raw[i].brunch_taken==`true) begin
            for(int j=0;j<=i+1;j++) begin
                inst[j]=inst_raw[j];
            end//reserve delay-slot
            for(int j=i+2;j<4;j++) begin
                inst[j]=`NOP;
            end
            pc_fetch.pc_new=brunch_address[i];
            mark=`true;
            break;
        end
    end
    if(mark==`false) begin
        if(inst_raw[3].is_brunch==`true) begin
            for(int i=0;i<3;i++) begin
                inst[i]=inst_raw[i];
            end
            inst[3]=`NOP;
            pc_fetch.pc_new=pc+12;
        end else begin
            for(int i=0;i<4;i++) begin
                inst[i]=inst_raw[i];
            end
            pc_fetch.pc_new=pc+16;
        end
    end
end

endmodule