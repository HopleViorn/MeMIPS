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

assign stall_to_pc=stall_from_decode;
assign stall_to_if_id=stall_from_decode;
assign stall_to_id_is=stall_from_decode;


assign stall_to_is=stall_from_memory;;
assign stall_to_is_ex=stall_from_memory;
assign stall_to_ex_mem=stall_from_memory;
assign stall_to_mem_cmt=`false;

assign flash_to_if_id=flash_from_execute;
assign flash_to_id_is=flash_from_execute;
assign flash_to_iq=flash_from_execute;
assign flash_to_is_ex=flash_from_execute;
assign flash_to_ex_mem=`false;
assign flash_to_mem_cmt=stall_from_memory;

/*
always_comb begin
    priority case(`true)
        stall_from_memory:  begin//cache miss
            stall_to_pc=`false;
            stall_to_if_id=`false;
            stall_to_id_is=`false;
            stall_to_is=`true;
            stall_to_is_ex=`true;
            stall_to_ex_mem=`true;
            stall_to_mem_cmt=`false;
            
            flash_to_if_id=`false;
            flash_to_id_is=`false;
            flash_to_iq=`false;
            flash_to_is_ex=`false;
            flash_to_ex_mem=`false;
            flash_to_mem_cmt=`true;
        end
        stall_from_decode: begin//iq is full
            stall_to_pc=`true;
            stall_to_if_id=`true;
            stall_to_id_is=`true;
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
*/
endmodule