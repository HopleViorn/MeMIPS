`include "../defines.sv"
module commmit(
    input CMT_REQUIRE cmt_require[1:0],
    output bool regfile_write_ena,
    output REG_ADDR regfile_write_addr,
    output REG regfile_write_data
);

always_comb begin
    if(cmt_require[0].write_reg_need==`true&&cmt_require[1].write_reg_need==`true) begin
        regfile_write_ena<=`true;
        regfile_write_addr<=cmt_require[1].write_reg_addr;
        regfile_write_data<=cmt_require[1].result;
    end else if(cmt_require[0].write_reg_need==`true) begin
        regfile_write_ena<=`true;
        regfile_write_addr<=cmt_require[0].write_reg_addr;
        regfile_write_data<=cmt_require[0].result;
    end else if(cmt_require[1].write_reg_need==`true) begin
        regfile_write_ena<=`true;
        regfile_write_addr<=cmt_require[1].write_reg_addr;
        regfile_write_data<=cmt_require[1].result;
    end else begin
        regfile_write_ena<=`false;
        regfile_write_addr<=5'b0;
        regfile_write_data<=32'b0;
    end
end

endmodule