`include "../defines.svh"
module issue_queue(
    input logic clk,
    input logic rst_n,
    input bool stall,
    input bool flash,
    input ISSUE_QUEUE_ELEMENT[3:0] in_data,
    input logic[2:0] in_data_number,
    output logic[1:0] iq_size,
    output logic[2:0] iq_size_left,
    output IQ_ADDR size,
    output IQ_ADDR size_left,
    input logic[1:0] out_data_number,
    output ISSUE_QUEUE_ELEMENT[1:0] out_data
);
wire rst=~rst_n;

IQ_ADDR[3:0] head_pointer;
IQ_ADDR[1:0] tail_pointer;
ISSUE_QUEUE_ELEMENT [15:0] issue_queue;
ISSUE_QUEUE_ELEMENT nop='{default:0};//TODO:nop

always_comb begin
    if(size==0) begin
        out_data<={nop,nop};
    end else if(size==1) begin
        out_data<={nop,issue_queue[tail_pointer[0]]};
    end else begin
        out_data<={issue_queue[tail_pointer[1]],issue_queue[tail_pointer[0]]};
    end
end

always_ff @(posedge clk) begin
    if(rst==`true||flash==`true) begin
        for(int i=0;i<4;i++) begin
            head_pointer[i]<=i;
        end
        for(int i=0;i<16;i++) begin
            issue_queue[i]<=nop;
        end
    end else if(stall==`false)begin
        case(in_data_number)
            1: begin
                for(int i=0;i<1;i++) begin
                    issue_queue[head_pointer[i]]<=in_data[i];
                end
                for(int i=0;i<4;i++) begin
                    head_pointer[i]<=head_pointer[i]+1;
                end
            end
            2:begin
                for(int i=0;i<2;i++) begin
                    issue_queue[head_pointer[i]]<=in_data[i];
                end
                for(int i=0;i<4;i++) begin
                    head_pointer[i]<=head_pointer[i]+2;
                end
            end
            3:begin
                for(int i=0;i<3;i++) begin
                    issue_queue[head_pointer[i]]<=in_data[i];
                end
                for(int i=0;i<4;i++) begin
                    head_pointer[i]<=head_pointer[i]+3;
                end
            end
            4:begin
                for(int i=0;i<4;i++) begin
                    issue_queue[head_pointer[i]]<=in_data[i];
                end
                for(int i=0;i<4;i++) begin
                    head_pointer[i]<=head_pointer[i]+4;
                end
            end//0:do nothing
        endcase
    end
end
always_ff @(posedge clk) begin
    if(rst==`true||flash==`true)begin
        for(int i=0;i<2;i++)begin
            tail_pointer[i]=i;
        end
    end else if(stall==`false)begin
        tail_pointer[0]=tail_pointer[0]+out_data_number;
        tail_pointer[1]=tail_pointer[1]+out_data_number;
    end
end

always_ff @(posedge clk) begin
    if(rst==`true||flash==`true) begin
        size=0;
        size_left=16;
    end else if(stall==`false)begin
        size<=size+(in_data_number-out_data_number);
        size_left<=size_left+(out_data_number-in_data_number);
    end
end

assign iq_size=(size>=2?2:size);
assign iq_size_left=(size_left>=4?4:size_left);

endmodule