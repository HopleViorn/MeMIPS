`include "defines.svh"
module control(
    input bool stall_from_decode,
    input bool stall_from_issue,
    input bool stall_from_execute,
    input bool flash_from_execute,
    input bool stall_from_memory,

    output bool stall_to_pc,
    output bool stall_to_if_id,
    output bool stall_to_id_is,//make push number=0
    output bool stall_to_is,//score board
    output bool stall_to_is_ex,//make pop number=0    
    output bool stall_to_ex_mem,//
    output bool stall_to_mem_cmt,//

    output bool flash_to_if_id,
    output bool flash_to_id_is,
    output bool flash_to_iq,
    output bool flash_to_is_ex,
    output bool flash_to_ex_mem,
    output bool flash_to_mem_cmt
);

always_comb begin
    priority case(`true)
        stall_from_memory:  begin
            
        end
        default:begin
            stall_to_pc=`false;
            stall_to_if_id=`false;
            stall_to_id_is=`false;
            stall_to_is=`false;
            stall_to_is_ex=`false;
            stall_to_ex_mem=`false;
            stall_to_mem_cmt=`false;
            
            flash_to_if_id=`false;
            flash_to_id_is=`false;
            flash_to_iq=`false;
            flash_to_is_ex=`false;
            flash_to_ex_mem=`false;
            flash_to_mem_cmt=`false;

        end
    endcase
end

endmodule