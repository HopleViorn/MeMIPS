`include "../defines.svh"
module commit(
    input CMT_REQUIRE[1:0] cmt_require,
    output bool[1:0] regfile_write_ena,
    output REG_ADDR[1:0] regfile_write_addr,
    output REG_WIDTH[1:0] regfile_write_data,

    output REG_WIDTH[1:0] commit_result
);


always_comb begin
    if(cmt_require[0].write_reg_addr==cmt_require[1].write_reg_addr) begin
        regfile_write_ena={`false,`true};
        regfile_write_addr={32'b0,cmt_require[1].write_reg_addr};
        regfile_write_data={32'b0,cmt_require[1].result};
    end else begin
        regfile_write_ena={cmt_require[1].write_reg_need,cmt_require[0].write_reg_need};
        regfile_write_addr={cmt_require[1].write_reg_addr,cmt_require[0].write_reg_addr};
        regfile_write_data={cmt_require[1].result,cmt_require[0].result};
    end
end

assign commit_result[0]=cmt_require[0].result;
assign commit_result[1]=cmt_require[1].result;

endmodule