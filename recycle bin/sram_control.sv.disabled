`include"../defines.svh"
module sram_control (
    input logic clk,
    input logic rst_n,
    input SRAM_CONTROL_REQUIRE sram_control_require,
    output DCACHE_REQUIRE dcache_require,
    
    input REG_WIDTH data_fram_sram
);

logic[3:0] await;
always_ff @( posedge clk ) begin
    if(~rst_n) begin
        await<=4'b0;
        dcache_require<='{default:0};

    end else begin
        if(await!=4'b0) begin
            await<=await-1;
            dcache_require.valid<=1;
            dcache_require.data<=data_fram_sram;
        end else begin
            if(sram_control_require.read_ena) begin

                await<=4'd3;
                dcache_require.valid<=0;
                dcache_require.data<=data_fram_sram;
            end
            if(sram_control_require.we_n) begin
                
            end
        end
    end
end


endmodule