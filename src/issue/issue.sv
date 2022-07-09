`include "../defines.svh"
module issue(
    input logic clk,
    input logic rst_n,
    input bool flash,
    input bool stall,
    input bool[2:0] post_is_stall_mask,

    //issue queue
    input ISSUE_QUEUE_ELEMENT [1:0] issue_require,
    input logic[1:0] iq_size,
    output logic[1:0] iq_pop_number,

    //bypass
    output SCORE_BOARD_DATA[3:0] score_board_data,
    input REG_WIDTH[3:0] bypass_result,

    //regfile
    output REG_ADDR [3:0] regfile_read_addr,
    input REG_WIDTH [3:0] regfile_read_data,
    //ex
    output FU_REQUIRE[1:0] fu_require
);
wire rst=~rst_n;

assign regfile_read_addr={
    issue_require[1].num2_addr,
    issue_require[1].num1_addr,
    issue_require[0].num2_addr,
    issue_require[0].num1_addr
};
REG_ADDR [3:0] score_board_read_addr;
assign score_board_read_addr={
    issue_require[1].num2_addr,
    issue_require[1].num1_addr,
    issue_require[0].num2_addr,
    issue_require[0].num1_addr
};
SCORE_BOARD_DATA [3:0] score_board_read_data;

bool [1:0] score_board_write_ena;
SCORE_BOARD_DATA [1:0] score_board_write_data;
REG_ADDR[1:0] score_board_write_addr;

score_board score_board0(
    .clk(clk),
    .rst_n(rst_n),
    .flash(flash),
    .stall(stall),
    .post_is_stall_mask(post_is_stall_mask),
    .write_ena(score_board_write_ena),
    .write_addr(score_board_write_addr),
    .read_addr(score_board_read_addr),
    .data_in(score_board_write_data),
    .data_out(score_board_read_data)
);

assign score_board_data[0]=score_board_read_data[0];
assign score_board_data[1]=score_board_read_data[1];
assign score_board_data[2]=score_board_read_data[2];
assign score_board_data[3]=score_board_read_data[3];
//LL
//BD

bool [1:0] num1_ready,num2_ready;
REG_WIDTH[1:0] num1_pre_ready,num2_pre_ready;
logic[2:0]  test[1:0]={0,0};
always_comb begin
    for(int i=0;i<2;i++) begin
        if(issue_require[i].num1_need==`false) begin//imm
            num1_ready[i]=`true;
            num1_pre_ready[i]=issue_require[i].num1;
            test[i]=1;
        end else if(i==1&&issue_require[0].write_reg_need&&issue_require[0].write_reg_addr!=5'b0&&issue_require[1].num1_addr==issue_require[0].write_reg_addr) begin
            num1_ready[i]=`false;
            num1_pre_ready[i]=32'b0;
            //TODO:SL bypass
            test[i]=2;
        end else if(score_board_read_data[i*2].position==3'b0) begin//read from regfile
        test[i]=3;
            num1_ready[i]=`true;
            num1_pre_ready[i]=regfile_read_data[2*i];
        end else begin
            test[i]=4;
            if((score_board_read_data[i*2].position&score_board_read_data[i*2].accept_mask)!=3'b0) begin//read from bypass
                num1_ready[i]=`true;
                num1_pre_ready[i]=bypass_result[i*2];
            end else begin//not ready
                num1_ready[i]=`false;
                num1_pre_ready[i]=32'b0;
            end
        end
        if(issue_require[i].num2_need==`false) begin//imm
            num2_ready[i]=`true;
            num2_pre_ready[i]=issue_require[i].num2;
        end else if(i==1&&issue_require[0].write_reg_need&&issue_require[0].write_reg_addr!=5'b0&&issue_require[1].num2_addr==issue_require[0].write_reg_addr) begin
            num2_ready[i]=`false;
            num2_pre_ready[i]=32'b0;
            //TODO:SL bypass
        end else if(score_board_read_data[i*2+1].position==3'b0) begin//read from regfile
            num2_ready[i]=`true;
            num2_pre_ready[i]=regfile_read_data[i*2+1];
        end else begin
            if((score_board_read_data[i*2+1].position&score_board_read_data[i*2+1].accept_mask)!=3'b0) begin//read from bypass
                num2_ready[i]=`true;
                num2_pre_ready[i]=bypass_result[i*2+1];
            end else begin//not ready
                num2_ready[i]=`false;
                num2_pre_ready[i]=32'b0;
            end
        end
    end
end

/*
0:
    NN:zero op
    XX:first not ready
    BD:first is branch,second not ready
1:
    XN:one op and the first is ready
    XX:first ready, but second not
   // WR:first ready, but second need first(=the second is not ready)
    XB:second is branch
2:
    XX:first ready,second ready
    BD:branch must with delay slot
   //TODO: SL in-line bypass
*/

wire first_ready=num1_ready[0]&num2_ready[0];
wire second_ready=num1_ready[1]&num2_ready[1];

`define nop '{default:0};
SCORE_BOARD_DATA ndt='{default:0};
always_comb begin
    if(stall==`true) begin
        fu_require[0]=`nop;
        fu_require[1]=`nop;
        iq_pop_number=2'd0;
        score_board_write_ena={`false,`false};
        score_board_write_data={ndt,ndt};
        score_board_write_addr={5'b0,5'b0};
    end else 
    if(iq_size==2'd0||
       first_ready==`false||
       (issue_require[0].exe_type==branch&&second_ready==`false)
    ) begin
        fu_require[0]=`nop;
        fu_require[1]=`nop;
        iq_pop_number=2'd0;
        score_board_write_ena={`false,`false};
        score_board_write_data={ndt,ndt};
        score_board_write_addr={5'b0,5'b0};
    end else if(
        (iq_size==2'd1&&first_ready==`true)||
        (iq_size==2'd2&&(
            (first_ready==`true&&second_ready==`false)||
            (issue_require[1].exe_type==branch)
            ||(issue_require[1].exe_type==memory)//this
            )
        )
    ) begin
        fu_require[0].pc=issue_require[0].pc;

        fu_require[0].num1=num1_pre_ready[0];
        fu_require[0].num2=num2_pre_ready[0];

        fu_require[0].alu_op=issue_require[0].alu_op;
        fu_require[0].exe_type=issue_require[0].exe_type;
        fu_require[0].branch_type=issue_require[0].branch_type;
        fu_require[0].predict_pc_addr=issue_require[0].predict_pc_addr;
        fu_require[0].predict_branch_taken=issue_require[0].predict_branch_taken;
        fu_require[0].llu_op=issue_require[0].llu_op;
        fu_require[0].memory_addr_offset=issue_require[0].memory_addr_offset;
        fu_require[0].mem_type=issue_require[0].mem_type;
        fu_require[0].mem_write_ena=issue_require[0].mem_write_ena;
        fu_require[0].mem_read_ena=issue_require[0].mem_read_ena;
        fu_require[0].write_reg_need=issue_require[0].write_reg_need;
        fu_require[0].write_reg_addr=issue_require[0].write_reg_addr;
        fu_require[0].shift_left=issue_require[0].shift_left;
        if(issue_require[0].write_reg_need) begin
            score_board_write_ena[0]=`true;
            score_board_write_data[0]='{
                line:0,
                position:3'b100,
                accept_mask:issue_require[0].accept_mask
            };
            score_board_write_addr[0]=issue_require[0].write_reg_addr;
        end else begin
            score_board_write_ena[0]=`false;
            score_board_write_data[0]=ndt;
            score_board_write_addr[0]=5'b0;
        end

        fu_require[1]=`nop;
        score_board_write_ena[1]=`false;
        score_board_write_data[1]=ndt;
        score_board_write_addr[1]=5'b0;

        iq_pop_number=2'd1;


    end else if(
        iq_size==2'd2&&(
            (first_ready==`true&&second_ready==`true)||
            (issue_require[0].exe_type==branch&&second_ready==`true)
        )
    ) begin
        fu_require[0].pc=issue_require[0].pc;

        fu_require[0].num1=num1_pre_ready[0];
        fu_require[0].num2=num2_pre_ready[0];

        fu_require[0].alu_op=issue_require[0].alu_op;
        fu_require[0].exe_type=issue_require[0].exe_type;
        fu_require[0].branch_type=issue_require[0].branch_type;
        fu_require[0].predict_pc_addr=issue_require[0].predict_pc_addr;
        fu_require[0].predict_branch_taken=issue_require[0].predict_branch_taken;
        fu_require[0].llu_op=issue_require[0].llu_op;
        fu_require[0].memory_addr_offset=issue_require[0].memory_addr_offset;
        fu_require[0].mem_type=issue_require[0].mem_type;
        fu_require[0].mem_write_ena=issue_require[0].mem_write_ena;
        fu_require[0].mem_read_ena=issue_require[0].mem_read_ena;
        fu_require[0].write_reg_need=issue_require[0].write_reg_need;
        fu_require[0].write_reg_addr=issue_require[0].write_reg_addr;
        fu_require[0].shift_left=issue_require[0].shift_left;
        if(issue_require[0].write_reg_need) begin
            score_board_write_ena[0]=`true;
            score_board_write_data[0]='{
                line:0,
                position:3'b100,
                accept_mask:issue_require[0].accept_mask
            };
            score_board_write_addr[0]=issue_require[0].write_reg_addr;
        end else begin
            score_board_write_ena[0]=`false;
            score_board_write_data[0]=ndt;
            score_board_write_addr[0]=5'b0;
        end

        fu_require[1].pc=issue_require[1].pc;

        fu_require[1].num1=num1_pre_ready[1];
        fu_require[1].num2=num2_pre_ready[1];

        fu_require[1].alu_op=issue_require[1].alu_op;
        fu_require[1].exe_type=issue_require[1].exe_type;
        fu_require[1].branch_type=issue_require[1].branch_type;
        fu_require[1].predict_pc_addr=issue_require[1].predict_pc_addr;
        fu_require[1].predict_branch_taken=issue_require[1].predict_branch_taken;
        fu_require[1].llu_op=issue_require[1].llu_op;
        fu_require[1].memory_addr_offset=issue_require[1].memory_addr_offset;
        fu_require[1].mem_type=issue_require[1].mem_type;
        fu_require[1].mem_write_ena=issue_require[1].mem_write_ena;
        fu_require[1].mem_read_ena=issue_require[1].mem_read_ena;
        fu_require[1].write_reg_need=issue_require[1].write_reg_need;
        fu_require[1].write_reg_addr=issue_require[1].write_reg_addr;
        fu_require[1].shift_left=issue_require[1].shift_left;
        if(issue_require[1].write_reg_need) begin
            score_board_write_ena[1]=`true;
            score_board_write_data[1]='{
                line:1,
                position:3'b100,
                accept_mask:issue_require[1].accept_mask
            };
            score_board_write_addr[1]=issue_require[1].write_reg_addr;
        end else begin
            score_board_write_ena[1]=`false;
            score_board_write_data[1]=ndt;
            score_board_write_addr[1]=5'b0;
        end
        iq_pop_number=2'd2;
    end else begin
        fu_require[0]=`nop;
        fu_require[1]=`nop;
        iq_pop_number=2'd0;
        score_board_write_ena={`false,`false};
        score_board_write_data={ndt,ndt};
        score_board_write_addr={5'b0,5'b0};
    end
end

`undef nop

endmodule