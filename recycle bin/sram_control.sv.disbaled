`include "../defines.svh"
module sram_control(
    input logic clk,rst,
    input logic[1:0] burst,
    output logic[127:0] data_master_read,
    input logic[31:0] data_master_write,

    input logic[3:0] be_n_master,

    input REG_WIDTH addr_master,
    
    input bool read_req,
    input bool write_req,

    output bool ok,

    inout REG_WIDTH data_sram,
    output REG_WIDTH addr_sram,
    output wire[3:0] sram_be_n,
    output logic sram_ce_n,       
    output logic sram_oe_n,       
    output logic sram_we_n    
);

REG_WIDTH [3:0] buffer;
assign data_master_read={buffer[3],buffer[2],buffer[1],buffer[0]};
assign sram_be_n=be_n_master;
assign addr_sram=addr_master;

REG_WIDTH data_to_sram,data_from_sram;
bool wea;
assign data_sram=wea?data_to_sram:32'bz;
assign data_from_sram=data_sram;

logic[1:0] cc;
typedef enum logic[1:0] { 
    idle,
    reading,
    writing
} state_type;

state_type state;

always_ff @(posedge clk)begin
    if(rst)begin
        cc<=0;
        ok<=0;
        wea<=0;
        data_to_sram<=32'b0;
        sram_ce_n<=0;
        sram_oe_n<=1;
        sram_we_n<=1;
        for(int i=0;i<4;i++) buffer<=32'b0;
    end else begin
        case(state)
            idle:begin
                if(read_req) begin
                    state<=reading;
                    cc<=0;
                    ok<=0;
                    wea<=0;
                    data_to_sram<=32'b0;
                    sram_oe_n<=0;
                end else if(write_req) begin
                    state<=writing;
                    cc<=0;
                    ok<=0;
                    wea<=1;
                    data_to_sram<=data_master_write;
                    sram_we_n<=0;
                end else begin
                    state<=idle;
                    cc<=0;
                    ok<=0;
                    wea<=0;
                    data_to_sram<=32'b0;
                    sram_we_n<=1;
                    sram_oe_n<=1;
                end
            end
            reading:begin
                if(cc==burst) begin
                    buffer[cc]<=data_from_sram;
                    cc<=0;
                    ok<=1;
                    state<=idle;
                    sram_oe_n<=1;
                end else begin
                    buffer[cc]<=data_from_sram;
                    cc<=cc+1;
                    ok<=0;
                    state<=reading;
                end
            end
            writing: begin
                ok<=1;
                wea<=0;
                state<=idle;
                sram_we_n<=1;
            end
        endcase
    end
end

endmodule