`include "../defines.sv"
module FU(
    input FU_REQUIRE fu_require,
    output PC_CHECK pc_execute,
    output MEM_REQUIRE mem_require
);
//TODO:bypass
logic[31:0] alu_result;
alu alu0(
    .a(fu_require.num1),
    .b(fu_require.num2),
    .alu_op(fu_require.alu_op),
    .c(alu_result)
);

//mem
assign mem_require.mem_write_ena=fu_require.mem_write_ena;
assign mem_require.mem_read_ena=fu_require.mem_read_ena;
assign mem_require.write_reg_addr=fu_require.write_reg_addr;
assign mem_require.write_reg_need=fu_require.write_reg_need;
addr mem_addr_calc(
    .a(fu_require.mem_address_offest),
    .b(fu_require.num2),
    .c(mem_require.addr)
);
always_comb begin
    if(fu_require.mem_read_ena==`true||fu_require.mem_write_ena==`true) begin
        mem_require.result=fu_require.num1;
    end else begin
        mem_require.result=alu_result;
    end
end

//brunch 
//TODO: jr jalr
logic llu_result;
llu llu0(
    .a(fu_require.num1),
    .b(fu_require.num2), 
    .llu_op(fu_require.llu_op),
    .c(llu_result)
);
always_comb begin
    if(fu_require.is_brunch==`true) begin
        if(llu_result==`true) begin
            pc_execute.pc_new=fu_require.jr_type==`true?fu_require.num1:fu_require.brunch_address;
            if(fu_require.brunch_taken==`false) begin
                pc_execute.enable=`true;
            end else begin
                pc_execute.enable=`false;
            end
        end else begin
            pc_execute.pc_new=fu_require.pc+8;
            if(fu_require.brunch_taken==`true) begin
                pc_execute.enable= `true;
            end else begin
                pc_execute.enable= `false;
            end
        end
    end else begin
        pc_execute.enable=`false;
        pc_execute.pc_new=32'b0;
    end
end



endmodule