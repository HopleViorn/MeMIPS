`include "../defines.svh"
module fetch(
    (*mark_debug="true"*)
    input wire clk,rst,
    input PC_CHECK pc_from_execute,
    input wire stall,
    output DECODE_REQUIRE[3:0] decode_require,

    output logic stall_from_fetch,
    sram_interface.master_r sram_port
);

(*mark_debug="true"*)REG_WIDTH pc;
REG_WIDTH pc_4;
assign pc_4=pc+4;

REG_WIDTH next_pc;
REG_WIDTH stalled_branch_address;

REG_WIDTH[1:0] inst;
REG_WIDTH[1:0] branch_address;
bool [1:0] branch_taken;


branch_predictor branch_predictor0(
    .pc(pc),
    .inst(inst[0]),
    .branch_taken(branch_taken[0]),
    .branch_address(branch_address[0])
);
branch_predictor branch_predictor1(
    .pc(pc_4),
    .inst(inst[1]),
    .branch_taken(branch_taken[1]),
    .branch_address(branch_address[1])
);

bool hit;
bool state,next_state;

assign stall_from_fetch=~hit;

PC_CHECK pc_reserve;

always_ff @(posedge clk) begin
    if(rst) begin
        pc_reserve.enable<=0;
        pc_reserve.pc_new<=32'b0;;
    end else begin
        if(~stall&hit) begin
            pc_reserve.enable<=0;
            pc_reserve.pc_new<=32'b0;
        end else begin
            if(~pc_reserve.enable) begin
                pc_reserve<=pc_from_execute;
            end
        end
    end
end

REG_WIDTH nuclear_branch_address;
always_ff @(posedge clk)begin : pc_generate
    if(rst) begin
        pc<=32'h80000000;
        // pc<=32'h8000303c;
        state<=0;
        stalled_branch_address<=0;
    end else if(~stall) begin 
        if(hit) begin
            pc<=next_pc;
            state<=next_state;
            stalled_branch_address<=nuclear_branch_address;
        end
    end
end

always_comb begin
    if(rst) begin
        next_pc=0;
        next_state=0;
        nuclear_branch_address=32'b0;
    end else begin
        if(pc_from_execute.enable|pc_reserve.enable) begin
            next_pc=pc_from_execute.pc_new|pc_reserve.pc_new;
            next_state=0;
            nuclear_branch_address=32'b0;
            for(int i=0;i<4;i++) begin
                decode_require[i].pc=32'b0;
                decode_require[i].inst=32'b0;
                decode_require[i].valid_number=0;
                decode_require[i].predict_pc_addr=32'b0;
                decode_require[i].predict_branch_taken=0;
            end
        end else begin
            if(~state) begin
                if(pc[3:2]==2'b11) begin
                    nuclear_branch_address=branch_address[0];
                    if(branch_taken[0]) begin
                        next_state=1;
                        next_pc=pc+4;
                    end else begin
                        next_pc=pc+4;
                        next_state=0;
                    end
                    for(int i=0;i<1;i++) begin
                        decode_require[i].pc=pc+i*4;
                        decode_require[i].inst=inst[i];
                        decode_require[i].valid_number=1;
                        decode_require[i].predict_pc_addr=branch_address[i];
                        decode_require[i].predict_branch_taken=branch_taken[i];
                    end
                    for(int i=1;i<4;i++) begin
                        decode_require[i].pc=32'b0;
                        decode_require[i].inst=32'b0;
                        decode_require[i].valid_number=1;
                        decode_require[i].predict_pc_addr=32'b0;
                        decode_require[i].predict_branch_taken=0;
                    end
                end else begin
                    nuclear_branch_address=branch_address[1];
                    if(branch_taken[1]) begin
                        next_state=1;
                        next_pc=pc+8;
                    end else if(branch_taken[0]) begin
                        next_state=0;
                        next_pc=branch_address[0];
                    end else begin
                        next_state=0;
                        next_pc=pc+8;
                    end
                    for(int i=0;i<2;i++) begin
                        decode_require[i].pc=pc+i*4;
                        decode_require[i].inst=inst[i];
                        decode_require[i].valid_number=2;
                        decode_require[i].predict_pc_addr=branch_address[i];
                        decode_require[i].predict_branch_taken=branch_taken[i];
                    end
                    for(int i=2;i<4;i++) begin
                        decode_require[i].pc=32'b0;
                        decode_require[i].inst=32'b0;
                        decode_require[i].valid_number=0;
                        decode_require[i].predict_pc_addr=32'b0;
                        decode_require[i].predict_branch_taken=0;
                    end
                end
            end else begin
                next_state=0;
                next_pc=stalled_branch_address;
                for(int i=0;i<1;i++) begin
                    decode_require[i].pc=pc+i*4;
                    decode_require[i].inst=inst[i];
                    decode_require[i].valid_number=1;
                    decode_require[i].predict_pc_addr=branch_address[i];
                    decode_require[i].predict_branch_taken=branch_taken[i];
                end
                for(int i=1;i<4;i++) begin
                    decode_require[i].pc=32'b0;
                    decode_require[i].inst=32'b0;
                    decode_require[i].valid_number=1;
                    decode_require[i].predict_pc_addr=32'b0;
                    decode_require[i].predict_branch_taken=0;
                end
            end
        end
    end
end

icache icache0(
    .clk,.rst,
    .pc(pc),
    .hit(hit),
    .inst(inst),
    .sram_port(sram_port)
);

endmodule
