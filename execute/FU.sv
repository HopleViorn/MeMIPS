`include "../defines.sv"
module FU(
    input FU_REQUIRE fu_require,
    output PC_CHECK pc_execute,
    output logic[31:0] alu_result
);
//TODO:bypass
alu alu0(
    .a(fu_require.num1),
    .b(fu_require.num2),
    .alu_op(fu_require.alu_op),
    .c(alu_result)
);

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