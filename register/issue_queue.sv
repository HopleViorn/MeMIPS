`include "../defines.svh"
module issue_queue(
    input logic clk,
    input logic rst,
    input ISSUE_QUEUE_ELEMENT[3:0] in_data,
    input logic[2:0] in_data_number,
    output logic[3:0] size,
    input logic[1:0] out_data_number,
    output ISSUE_QUEUE_ELEMENT[1:0] out_data
);

IQ_ADDR[3:0] head_pointer;
IQ_ADDR[1:0] tail_pointer;
ISSUE_QUEUE_ELEMENT[15:0] issue_queue;
ISSUE_QUEUE_ELEMENT nop='{default:0};//TODO:nop
always_comb begin
    case(out_data_number)
        0: out_data={nop,nop};
        1: out_data={nop,issue_queue[tail_pointer[0]]};
        2: out_data={issue_queue[tail_pointer[1]],issue_queue[tail_pointer[0]]};
        default: out_data={nop,nop};
    endcase
end

always_ff @(posedge clk) begin
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
always_ff @(posedge clk) begin
    tail_pointer[0]=tail_pointer[0]+out_data_number;
    tail_pointer[1]=tail_pointer[1]+out_data_number;
end
endmodule