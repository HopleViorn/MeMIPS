





create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_wiz_0_0/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {mips0/Reg[11]__0[0]} {mips0/Reg[11]__0[1]} {mips0/Reg[11]__0[2]} {mips0/Reg[11]__0[3]} {mips0/Reg[11]__0[4]} {mips0/Reg[11]__0[5]} {mips0/Reg[11]__0[6]} {mips0/Reg[11]__0[7]} {mips0/Reg[11]__0[8]} {mips0/Reg[11]__0[9]} {mips0/Reg[11]__0[10]} {mips0/Reg[11]__0[11]} {mips0/Reg[11]__0[12]} {mips0/Reg[11]__0[13]} {mips0/Reg[11]__0[14]} {mips0/Reg[11]__0[15]} {mips0/Reg[11]__0[16]} {mips0/Reg[11]__0[17]} {mips0/Reg[11]__0[18]} {mips0/Reg[11]__0[19]} {mips0/Reg[11]__0[20]} {mips0/Reg[11]__0[21]} {mips0/Reg[11]__0[22]} {mips0/Reg[11]__0[23]} {mips0/Reg[11]__0[24]} {mips0/Reg[11]__0[25]} {mips0/Reg[11]__0[26]} {mips0/Reg[11]__0[27]} {mips0/Reg[11]__0[28]} {mips0/Reg[11]__0[29]} {mips0/Reg[11]__0[30]} {mips0/Reg[11]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {mips0/Reg[10]__0[0]} {mips0/Reg[10]__0[1]} {mips0/Reg[10]__0[2]} {mips0/Reg[10]__0[3]} {mips0/Reg[10]__0[4]} {mips0/Reg[10]__0[5]} {mips0/Reg[10]__0[6]} {mips0/Reg[10]__0[7]} {mips0/Reg[10]__0[8]} {mips0/Reg[10]__0[9]} {mips0/Reg[10]__0[10]} {mips0/Reg[10]__0[11]} {mips0/Reg[10]__0[12]} {mips0/Reg[10]__0[13]} {mips0/Reg[10]__0[14]} {mips0/Reg[10]__0[15]} {mips0/Reg[10]__0[16]} {mips0/Reg[10]__0[17]} {mips0/Reg[10]__0[18]} {mips0/Reg[10]__0[19]} {mips0/Reg[10]__0[20]} {mips0/Reg[10]__0[21]} {mips0/Reg[10]__0[22]} {mips0/Reg[10]__0[23]} {mips0/Reg[10]__0[24]} {mips0/Reg[10]__0[25]} {mips0/Reg[10]__0[26]} {mips0/Reg[10]__0[27]} {mips0/Reg[10]__0[28]} {mips0/Reg[10]__0[29]} {mips0/Reg[10]__0[30]} {mips0/Reg[10]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {mips0/Reg[0]__0[0]} {mips0/Reg[0]__0[1]} {mips0/Reg[0]__0[2]} {mips0/Reg[0]__0[3]} {mips0/Reg[0]__0[4]} {mips0/Reg[0]__0[5]} {mips0/Reg[0]__0[6]} {mips0/Reg[0]__0[7]} {mips0/Reg[0]__0[8]} {mips0/Reg[0]__0[9]} {mips0/Reg[0]__0[10]} {mips0/Reg[0]__0[11]} {mips0/Reg[0]__0[12]} {mips0/Reg[0]__0[13]} {mips0/Reg[0]__0[14]} {mips0/Reg[0]__0[15]} {mips0/Reg[0]__0[16]} {mips0/Reg[0]__0[17]} {mips0/Reg[0]__0[18]} {mips0/Reg[0]__0[19]} {mips0/Reg[0]__0[20]} {mips0/Reg[0]__0[21]} {mips0/Reg[0]__0[22]} {mips0/Reg[0]__0[23]} {mips0/Reg[0]__0[24]} {mips0/Reg[0]__0[25]} {mips0/Reg[0]__0[26]} {mips0/Reg[0]__0[27]} {mips0/Reg[0]__0[28]} {mips0/Reg[0]__0[29]} {mips0/Reg[0]__0[30]} {mips0/Reg[0]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {mips0/Reg[20]__0[0]} {mips0/Reg[20]__0[1]} {mips0/Reg[20]__0[2]} {mips0/Reg[20]__0[3]} {mips0/Reg[20]__0[4]} {mips0/Reg[20]__0[5]} {mips0/Reg[20]__0[6]} {mips0/Reg[20]__0[7]} {mips0/Reg[20]__0[8]} {mips0/Reg[20]__0[9]} {mips0/Reg[20]__0[10]} {mips0/Reg[20]__0[11]} {mips0/Reg[20]__0[12]} {mips0/Reg[20]__0[13]} {mips0/Reg[20]__0[14]} {mips0/Reg[20]__0[15]} {mips0/Reg[20]__0[16]} {mips0/Reg[20]__0[17]} {mips0/Reg[20]__0[18]} {mips0/Reg[20]__0[19]} {mips0/Reg[20]__0[20]} {mips0/Reg[20]__0[21]} {mips0/Reg[20]__0[22]} {mips0/Reg[20]__0[23]} {mips0/Reg[20]__0[24]} {mips0/Reg[20]__0[25]} {mips0/Reg[20]__0[26]} {mips0/Reg[20]__0[27]} {mips0/Reg[20]__0[28]} {mips0/Reg[20]__0[29]} {mips0/Reg[20]__0[30]} {mips0/Reg[20]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {mips0/Reg[25]__0[0]} {mips0/Reg[25]__0[1]} {mips0/Reg[25]__0[2]} {mips0/Reg[25]__0[3]} {mips0/Reg[25]__0[4]} {mips0/Reg[25]__0[5]} {mips0/Reg[25]__0[6]} {mips0/Reg[25]__0[7]} {mips0/Reg[25]__0[8]} {mips0/Reg[25]__0[9]} {mips0/Reg[25]__0[10]} {mips0/Reg[25]__0[11]} {mips0/Reg[25]__0[12]} {mips0/Reg[25]__0[13]} {mips0/Reg[25]__0[14]} {mips0/Reg[25]__0[15]} {mips0/Reg[25]__0[16]} {mips0/Reg[25]__0[17]} {mips0/Reg[25]__0[18]} {mips0/Reg[25]__0[19]} {mips0/Reg[25]__0[20]} {mips0/Reg[25]__0[21]} {mips0/Reg[25]__0[22]} {mips0/Reg[25]__0[23]} {mips0/Reg[25]__0[24]} {mips0/Reg[25]__0[25]} {mips0/Reg[25]__0[26]} {mips0/Reg[25]__0[27]} {mips0/Reg[25]__0[28]} {mips0/Reg[25]__0[29]} {mips0/Reg[25]__0[30]} {mips0/Reg[25]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {mips0/Reg[21]__0[0]} {mips0/Reg[21]__0[1]} {mips0/Reg[21]__0[2]} {mips0/Reg[21]__0[3]} {mips0/Reg[21]__0[4]} {mips0/Reg[21]__0[5]} {mips0/Reg[21]__0[6]} {mips0/Reg[21]__0[7]} {mips0/Reg[21]__0[8]} {mips0/Reg[21]__0[9]} {mips0/Reg[21]__0[10]} {mips0/Reg[21]__0[11]} {mips0/Reg[21]__0[12]} {mips0/Reg[21]__0[13]} {mips0/Reg[21]__0[14]} {mips0/Reg[21]__0[15]} {mips0/Reg[21]__0[16]} {mips0/Reg[21]__0[17]} {mips0/Reg[21]__0[18]} {mips0/Reg[21]__0[19]} {mips0/Reg[21]__0[20]} {mips0/Reg[21]__0[21]} {mips0/Reg[21]__0[22]} {mips0/Reg[21]__0[23]} {mips0/Reg[21]__0[24]} {mips0/Reg[21]__0[25]} {mips0/Reg[21]__0[26]} {mips0/Reg[21]__0[27]} {mips0/Reg[21]__0[28]} {mips0/Reg[21]__0[29]} {mips0/Reg[21]__0[30]} {mips0/Reg[21]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {mips0/Reg[26]__0[0]} {mips0/Reg[26]__0[1]} {mips0/Reg[26]__0[2]} {mips0/Reg[26]__0[3]} {mips0/Reg[26]__0[4]} {mips0/Reg[26]__0[5]} {mips0/Reg[26]__0[6]} {mips0/Reg[26]__0[7]} {mips0/Reg[26]__0[8]} {mips0/Reg[26]__0[9]} {mips0/Reg[26]__0[10]} {mips0/Reg[26]__0[11]} {mips0/Reg[26]__0[12]} {mips0/Reg[26]__0[13]} {mips0/Reg[26]__0[14]} {mips0/Reg[26]__0[15]} {mips0/Reg[26]__0[16]} {mips0/Reg[26]__0[17]} {mips0/Reg[26]__0[18]} {mips0/Reg[26]__0[19]} {mips0/Reg[26]__0[20]} {mips0/Reg[26]__0[21]} {mips0/Reg[26]__0[22]} {mips0/Reg[26]__0[23]} {mips0/Reg[26]__0[24]} {mips0/Reg[26]__0[25]} {mips0/Reg[26]__0[26]} {mips0/Reg[26]__0[27]} {mips0/Reg[26]__0[28]} {mips0/Reg[26]__0[29]} {mips0/Reg[26]__0[30]} {mips0/Reg[26]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {mips0/Reg[2]__0[0]} {mips0/Reg[2]__0[1]} {mips0/Reg[2]__0[2]} {mips0/Reg[2]__0[3]} {mips0/Reg[2]__0[4]} {mips0/Reg[2]__0[5]} {mips0/Reg[2]__0[6]} {mips0/Reg[2]__0[7]} {mips0/Reg[2]__0[8]} {mips0/Reg[2]__0[9]} {mips0/Reg[2]__0[10]} {mips0/Reg[2]__0[11]} {mips0/Reg[2]__0[12]} {mips0/Reg[2]__0[13]} {mips0/Reg[2]__0[14]} {mips0/Reg[2]__0[15]} {mips0/Reg[2]__0[16]} {mips0/Reg[2]__0[17]} {mips0/Reg[2]__0[18]} {mips0/Reg[2]__0[19]} {mips0/Reg[2]__0[20]} {mips0/Reg[2]__0[21]} {mips0/Reg[2]__0[22]} {mips0/Reg[2]__0[23]} {mips0/Reg[2]__0[24]} {mips0/Reg[2]__0[25]} {mips0/Reg[2]__0[26]} {mips0/Reg[2]__0[27]} {mips0/Reg[2]__0[28]} {mips0/Reg[2]__0[29]} {mips0/Reg[2]__0[30]} {mips0/Reg[2]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {mips0/Reg[30]__0[0]} {mips0/Reg[30]__0[1]} {mips0/Reg[30]__0[2]} {mips0/Reg[30]__0[3]} {mips0/Reg[30]__0[4]} {mips0/Reg[30]__0[5]} {mips0/Reg[30]__0[6]} {mips0/Reg[30]__0[7]} {mips0/Reg[30]__0[8]} {mips0/Reg[30]__0[9]} {mips0/Reg[30]__0[10]} {mips0/Reg[30]__0[11]} {mips0/Reg[30]__0[12]} {mips0/Reg[30]__0[13]} {mips0/Reg[30]__0[14]} {mips0/Reg[30]__0[15]} {mips0/Reg[30]__0[16]} {mips0/Reg[30]__0[17]} {mips0/Reg[30]__0[18]} {mips0/Reg[30]__0[19]} {mips0/Reg[30]__0[20]} {mips0/Reg[30]__0[21]} {mips0/Reg[30]__0[22]} {mips0/Reg[30]__0[23]} {mips0/Reg[30]__0[24]} {mips0/Reg[30]__0[25]} {mips0/Reg[30]__0[26]} {mips0/Reg[30]__0[27]} {mips0/Reg[30]__0[28]} {mips0/Reg[30]__0[29]} {mips0/Reg[30]__0[30]} {mips0/Reg[30]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {mips0/Reg[3]__0[0]} {mips0/Reg[3]__0[1]} {mips0/Reg[3]__0[2]} {mips0/Reg[3]__0[3]} {mips0/Reg[3]__0[4]} {mips0/Reg[3]__0[5]} {mips0/Reg[3]__0[6]} {mips0/Reg[3]__0[7]} {mips0/Reg[3]__0[8]} {mips0/Reg[3]__0[9]} {mips0/Reg[3]__0[10]} {mips0/Reg[3]__0[11]} {mips0/Reg[3]__0[12]} {mips0/Reg[3]__0[13]} {mips0/Reg[3]__0[14]} {mips0/Reg[3]__0[15]} {mips0/Reg[3]__0[16]} {mips0/Reg[3]__0[17]} {mips0/Reg[3]__0[18]} {mips0/Reg[3]__0[19]} {mips0/Reg[3]__0[20]} {mips0/Reg[3]__0[21]} {mips0/Reg[3]__0[22]} {mips0/Reg[3]__0[23]} {mips0/Reg[3]__0[24]} {mips0/Reg[3]__0[25]} {mips0/Reg[3]__0[26]} {mips0/Reg[3]__0[27]} {mips0/Reg[3]__0[28]} {mips0/Reg[3]__0[29]} {mips0/Reg[3]__0[30]} {mips0/Reg[3]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {mips0/Reg[5]__0[0]} {mips0/Reg[5]__0[1]} {mips0/Reg[5]__0[2]} {mips0/Reg[5]__0[3]} {mips0/Reg[5]__0[4]} {mips0/Reg[5]__0[5]} {mips0/Reg[5]__0[6]} {mips0/Reg[5]__0[7]} {mips0/Reg[5]__0[8]} {mips0/Reg[5]__0[9]} {mips0/Reg[5]__0[10]} {mips0/Reg[5]__0[11]} {mips0/Reg[5]__0[12]} {mips0/Reg[5]__0[13]} {mips0/Reg[5]__0[14]} {mips0/Reg[5]__0[15]} {mips0/Reg[5]__0[16]} {mips0/Reg[5]__0[17]} {mips0/Reg[5]__0[18]} {mips0/Reg[5]__0[19]} {mips0/Reg[5]__0[20]} {mips0/Reg[5]__0[21]} {mips0/Reg[5]__0[22]} {mips0/Reg[5]__0[23]} {mips0/Reg[5]__0[24]} {mips0/Reg[5]__0[25]} {mips0/Reg[5]__0[26]} {mips0/Reg[5]__0[27]} {mips0/Reg[5]__0[28]} {mips0/Reg[5]__0[29]} {mips0/Reg[5]__0[30]} {mips0/Reg[5]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 32 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {mips0/Reg[14]__0[0]} {mips0/Reg[14]__0[1]} {mips0/Reg[14]__0[2]} {mips0/Reg[14]__0[3]} {mips0/Reg[14]__0[4]} {mips0/Reg[14]__0[5]} {mips0/Reg[14]__0[6]} {mips0/Reg[14]__0[7]} {mips0/Reg[14]__0[8]} {mips0/Reg[14]__0[9]} {mips0/Reg[14]__0[10]} {mips0/Reg[14]__0[11]} {mips0/Reg[14]__0[12]} {mips0/Reg[14]__0[13]} {mips0/Reg[14]__0[14]} {mips0/Reg[14]__0[15]} {mips0/Reg[14]__0[16]} {mips0/Reg[14]__0[17]} {mips0/Reg[14]__0[18]} {mips0/Reg[14]__0[19]} {mips0/Reg[14]__0[20]} {mips0/Reg[14]__0[21]} {mips0/Reg[14]__0[22]} {mips0/Reg[14]__0[23]} {mips0/Reg[14]__0[24]} {mips0/Reg[14]__0[25]} {mips0/Reg[14]__0[26]} {mips0/Reg[14]__0[27]} {mips0/Reg[14]__0[28]} {mips0/Reg[14]__0[29]} {mips0/Reg[14]__0[30]} {mips0/Reg[14]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 32 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {mips0/Reg[19]__0[0]} {mips0/Reg[19]__0[1]} {mips0/Reg[19]__0[2]} {mips0/Reg[19]__0[3]} {mips0/Reg[19]__0[4]} {mips0/Reg[19]__0[5]} {mips0/Reg[19]__0[6]} {mips0/Reg[19]__0[7]} {mips0/Reg[19]__0[8]} {mips0/Reg[19]__0[9]} {mips0/Reg[19]__0[10]} {mips0/Reg[19]__0[11]} {mips0/Reg[19]__0[12]} {mips0/Reg[19]__0[13]} {mips0/Reg[19]__0[14]} {mips0/Reg[19]__0[15]} {mips0/Reg[19]__0[16]} {mips0/Reg[19]__0[17]} {mips0/Reg[19]__0[18]} {mips0/Reg[19]__0[19]} {mips0/Reg[19]__0[20]} {mips0/Reg[19]__0[21]} {mips0/Reg[19]__0[22]} {mips0/Reg[19]__0[23]} {mips0/Reg[19]__0[24]} {mips0/Reg[19]__0[25]} {mips0/Reg[19]__0[26]} {mips0/Reg[19]__0[27]} {mips0/Reg[19]__0[28]} {mips0/Reg[19]__0[29]} {mips0/Reg[19]__0[30]} {mips0/Reg[19]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {mips0/Reg[29]__0[0]} {mips0/Reg[29]__0[1]} {mips0/Reg[29]__0[2]} {mips0/Reg[29]__0[3]} {mips0/Reg[29]__0[4]} {mips0/Reg[29]__0[5]} {mips0/Reg[29]__0[6]} {mips0/Reg[29]__0[7]} {mips0/Reg[29]__0[8]} {mips0/Reg[29]__0[9]} {mips0/Reg[29]__0[10]} {mips0/Reg[29]__0[11]} {mips0/Reg[29]__0[12]} {mips0/Reg[29]__0[13]} {mips0/Reg[29]__0[14]} {mips0/Reg[29]__0[15]} {mips0/Reg[29]__0[16]} {mips0/Reg[29]__0[17]} {mips0/Reg[29]__0[18]} {mips0/Reg[29]__0[19]} {mips0/Reg[29]__0[20]} {mips0/Reg[29]__0[21]} {mips0/Reg[29]__0[22]} {mips0/Reg[29]__0[23]} {mips0/Reg[29]__0[24]} {mips0/Reg[29]__0[25]} {mips0/Reg[29]__0[26]} {mips0/Reg[29]__0[27]} {mips0/Reg[29]__0[28]} {mips0/Reg[29]__0[29]} {mips0/Reg[29]__0[30]} {mips0/Reg[29]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 32 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {mips0/Reg[18]__0[0]} {mips0/Reg[18]__0[1]} {mips0/Reg[18]__0[2]} {mips0/Reg[18]__0[3]} {mips0/Reg[18]__0[4]} {mips0/Reg[18]__0[5]} {mips0/Reg[18]__0[6]} {mips0/Reg[18]__0[7]} {mips0/Reg[18]__0[8]} {mips0/Reg[18]__0[9]} {mips0/Reg[18]__0[10]} {mips0/Reg[18]__0[11]} {mips0/Reg[18]__0[12]} {mips0/Reg[18]__0[13]} {mips0/Reg[18]__0[14]} {mips0/Reg[18]__0[15]} {mips0/Reg[18]__0[16]} {mips0/Reg[18]__0[17]} {mips0/Reg[18]__0[18]} {mips0/Reg[18]__0[19]} {mips0/Reg[18]__0[20]} {mips0/Reg[18]__0[21]} {mips0/Reg[18]__0[22]} {mips0/Reg[18]__0[23]} {mips0/Reg[18]__0[24]} {mips0/Reg[18]__0[25]} {mips0/Reg[18]__0[26]} {mips0/Reg[18]__0[27]} {mips0/Reg[18]__0[28]} {mips0/Reg[18]__0[29]} {mips0/Reg[18]__0[30]} {mips0/Reg[18]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 32 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {mips0/Reg[6]__0[0]} {mips0/Reg[6]__0[1]} {mips0/Reg[6]__0[2]} {mips0/Reg[6]__0[3]} {mips0/Reg[6]__0[4]} {mips0/Reg[6]__0[5]} {mips0/Reg[6]__0[6]} {mips0/Reg[6]__0[7]} {mips0/Reg[6]__0[8]} {mips0/Reg[6]__0[9]} {mips0/Reg[6]__0[10]} {mips0/Reg[6]__0[11]} {mips0/Reg[6]__0[12]} {mips0/Reg[6]__0[13]} {mips0/Reg[6]__0[14]} {mips0/Reg[6]__0[15]} {mips0/Reg[6]__0[16]} {mips0/Reg[6]__0[17]} {mips0/Reg[6]__0[18]} {mips0/Reg[6]__0[19]} {mips0/Reg[6]__0[20]} {mips0/Reg[6]__0[21]} {mips0/Reg[6]__0[22]} {mips0/Reg[6]__0[23]} {mips0/Reg[6]__0[24]} {mips0/Reg[6]__0[25]} {mips0/Reg[6]__0[26]} {mips0/Reg[6]__0[27]} {mips0/Reg[6]__0[28]} {mips0/Reg[6]__0[29]} {mips0/Reg[6]__0[30]} {mips0/Reg[6]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 32 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {mips0/Reg[7]__0[0]} {mips0/Reg[7]__0[1]} {mips0/Reg[7]__0[2]} {mips0/Reg[7]__0[3]} {mips0/Reg[7]__0[4]} {mips0/Reg[7]__0[5]} {mips0/Reg[7]__0[6]} {mips0/Reg[7]__0[7]} {mips0/Reg[7]__0[8]} {mips0/Reg[7]__0[9]} {mips0/Reg[7]__0[10]} {mips0/Reg[7]__0[11]} {mips0/Reg[7]__0[12]} {mips0/Reg[7]__0[13]} {mips0/Reg[7]__0[14]} {mips0/Reg[7]__0[15]} {mips0/Reg[7]__0[16]} {mips0/Reg[7]__0[17]} {mips0/Reg[7]__0[18]} {mips0/Reg[7]__0[19]} {mips0/Reg[7]__0[20]} {mips0/Reg[7]__0[21]} {mips0/Reg[7]__0[22]} {mips0/Reg[7]__0[23]} {mips0/Reg[7]__0[24]} {mips0/Reg[7]__0[25]} {mips0/Reg[7]__0[26]} {mips0/Reg[7]__0[27]} {mips0/Reg[7]__0[28]} {mips0/Reg[7]__0[29]} {mips0/Reg[7]__0[30]} {mips0/Reg[7]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 32 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {mips0/Reg[27]__0[0]} {mips0/Reg[27]__0[1]} {mips0/Reg[27]__0[2]} {mips0/Reg[27]__0[3]} {mips0/Reg[27]__0[4]} {mips0/Reg[27]__0[5]} {mips0/Reg[27]__0[6]} {mips0/Reg[27]__0[7]} {mips0/Reg[27]__0[8]} {mips0/Reg[27]__0[9]} {mips0/Reg[27]__0[10]} {mips0/Reg[27]__0[11]} {mips0/Reg[27]__0[12]} {mips0/Reg[27]__0[13]} {mips0/Reg[27]__0[14]} {mips0/Reg[27]__0[15]} {mips0/Reg[27]__0[16]} {mips0/Reg[27]__0[17]} {mips0/Reg[27]__0[18]} {mips0/Reg[27]__0[19]} {mips0/Reg[27]__0[20]} {mips0/Reg[27]__0[21]} {mips0/Reg[27]__0[22]} {mips0/Reg[27]__0[23]} {mips0/Reg[27]__0[24]} {mips0/Reg[27]__0[25]} {mips0/Reg[27]__0[26]} {mips0/Reg[27]__0[27]} {mips0/Reg[27]__0[28]} {mips0/Reg[27]__0[29]} {mips0/Reg[27]__0[30]} {mips0/Reg[27]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 32 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {mips0/Reg[8]__0[0]} {mips0/Reg[8]__0[1]} {mips0/Reg[8]__0[2]} {mips0/Reg[8]__0[3]} {mips0/Reg[8]__0[4]} {mips0/Reg[8]__0[5]} {mips0/Reg[8]__0[6]} {mips0/Reg[8]__0[7]} {mips0/Reg[8]__0[8]} {mips0/Reg[8]__0[9]} {mips0/Reg[8]__0[10]} {mips0/Reg[8]__0[11]} {mips0/Reg[8]__0[12]} {mips0/Reg[8]__0[13]} {mips0/Reg[8]__0[14]} {mips0/Reg[8]__0[15]} {mips0/Reg[8]__0[16]} {mips0/Reg[8]__0[17]} {mips0/Reg[8]__0[18]} {mips0/Reg[8]__0[19]} {mips0/Reg[8]__0[20]} {mips0/Reg[8]__0[21]} {mips0/Reg[8]__0[22]} {mips0/Reg[8]__0[23]} {mips0/Reg[8]__0[24]} {mips0/Reg[8]__0[25]} {mips0/Reg[8]__0[26]} {mips0/Reg[8]__0[27]} {mips0/Reg[8]__0[28]} {mips0/Reg[8]__0[29]} {mips0/Reg[8]__0[30]} {mips0/Reg[8]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 32 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {mips0/Reg[28]__0[0]} {mips0/Reg[28]__0[1]} {mips0/Reg[28]__0[2]} {mips0/Reg[28]__0[3]} {mips0/Reg[28]__0[4]} {mips0/Reg[28]__0[5]} {mips0/Reg[28]__0[6]} {mips0/Reg[28]__0[7]} {mips0/Reg[28]__0[8]} {mips0/Reg[28]__0[9]} {mips0/Reg[28]__0[10]} {mips0/Reg[28]__0[11]} {mips0/Reg[28]__0[12]} {mips0/Reg[28]__0[13]} {mips0/Reg[28]__0[14]} {mips0/Reg[28]__0[15]} {mips0/Reg[28]__0[16]} {mips0/Reg[28]__0[17]} {mips0/Reg[28]__0[18]} {mips0/Reg[28]__0[19]} {mips0/Reg[28]__0[20]} {mips0/Reg[28]__0[21]} {mips0/Reg[28]__0[22]} {mips0/Reg[28]__0[23]} {mips0/Reg[28]__0[24]} {mips0/Reg[28]__0[25]} {mips0/Reg[28]__0[26]} {mips0/Reg[28]__0[27]} {mips0/Reg[28]__0[28]} {mips0/Reg[28]__0[29]} {mips0/Reg[28]__0[30]} {mips0/Reg[28]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 32 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {mips0/Reg[9]__0[0]} {mips0/Reg[9]__0[1]} {mips0/Reg[9]__0[2]} {mips0/Reg[9]__0[3]} {mips0/Reg[9]__0[4]} {mips0/Reg[9]__0[5]} {mips0/Reg[9]__0[6]} {mips0/Reg[9]__0[7]} {mips0/Reg[9]__0[8]} {mips0/Reg[9]__0[9]} {mips0/Reg[9]__0[10]} {mips0/Reg[9]__0[11]} {mips0/Reg[9]__0[12]} {mips0/Reg[9]__0[13]} {mips0/Reg[9]__0[14]} {mips0/Reg[9]__0[15]} {mips0/Reg[9]__0[16]} {mips0/Reg[9]__0[17]} {mips0/Reg[9]__0[18]} {mips0/Reg[9]__0[19]} {mips0/Reg[9]__0[20]} {mips0/Reg[9]__0[21]} {mips0/Reg[9]__0[22]} {mips0/Reg[9]__0[23]} {mips0/Reg[9]__0[24]} {mips0/Reg[9]__0[25]} {mips0/Reg[9]__0[26]} {mips0/Reg[9]__0[27]} {mips0/Reg[9]__0[28]} {mips0/Reg[9]__0[29]} {mips0/Reg[9]__0[30]} {mips0/Reg[9]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 32 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {mips0/Reg[15]__0[0]} {mips0/Reg[15]__0[1]} {mips0/Reg[15]__0[2]} {mips0/Reg[15]__0[3]} {mips0/Reg[15]__0[4]} {mips0/Reg[15]__0[5]} {mips0/Reg[15]__0[6]} {mips0/Reg[15]__0[7]} {mips0/Reg[15]__0[8]} {mips0/Reg[15]__0[9]} {mips0/Reg[15]__0[10]} {mips0/Reg[15]__0[11]} {mips0/Reg[15]__0[12]} {mips0/Reg[15]__0[13]} {mips0/Reg[15]__0[14]} {mips0/Reg[15]__0[15]} {mips0/Reg[15]__0[16]} {mips0/Reg[15]__0[17]} {mips0/Reg[15]__0[18]} {mips0/Reg[15]__0[19]} {mips0/Reg[15]__0[20]} {mips0/Reg[15]__0[21]} {mips0/Reg[15]__0[22]} {mips0/Reg[15]__0[23]} {mips0/Reg[15]__0[24]} {mips0/Reg[15]__0[25]} {mips0/Reg[15]__0[26]} {mips0/Reg[15]__0[27]} {mips0/Reg[15]__0[28]} {mips0/Reg[15]__0[29]} {mips0/Reg[15]__0[30]} {mips0/Reg[15]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 32 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list {mips0/Reg[23]__0[0]} {mips0/Reg[23]__0[1]} {mips0/Reg[23]__0[2]} {mips0/Reg[23]__0[3]} {mips0/Reg[23]__0[4]} {mips0/Reg[23]__0[5]} {mips0/Reg[23]__0[6]} {mips0/Reg[23]__0[7]} {mips0/Reg[23]__0[8]} {mips0/Reg[23]__0[9]} {mips0/Reg[23]__0[10]} {mips0/Reg[23]__0[11]} {mips0/Reg[23]__0[12]} {mips0/Reg[23]__0[13]} {mips0/Reg[23]__0[14]} {mips0/Reg[23]__0[15]} {mips0/Reg[23]__0[16]} {mips0/Reg[23]__0[17]} {mips0/Reg[23]__0[18]} {mips0/Reg[23]__0[19]} {mips0/Reg[23]__0[20]} {mips0/Reg[23]__0[21]} {mips0/Reg[23]__0[22]} {mips0/Reg[23]__0[23]} {mips0/Reg[23]__0[24]} {mips0/Reg[23]__0[25]} {mips0/Reg[23]__0[26]} {mips0/Reg[23]__0[27]} {mips0/Reg[23]__0[28]} {mips0/Reg[23]__0[29]} {mips0/Reg[23]__0[30]} {mips0/Reg[23]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 32 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list {mips0/Reg[12]__0[0]} {mips0/Reg[12]__0[1]} {mips0/Reg[12]__0[2]} {mips0/Reg[12]__0[3]} {mips0/Reg[12]__0[4]} {mips0/Reg[12]__0[5]} {mips0/Reg[12]__0[6]} {mips0/Reg[12]__0[7]} {mips0/Reg[12]__0[8]} {mips0/Reg[12]__0[9]} {mips0/Reg[12]__0[10]} {mips0/Reg[12]__0[11]} {mips0/Reg[12]__0[12]} {mips0/Reg[12]__0[13]} {mips0/Reg[12]__0[14]} {mips0/Reg[12]__0[15]} {mips0/Reg[12]__0[16]} {mips0/Reg[12]__0[17]} {mips0/Reg[12]__0[18]} {mips0/Reg[12]__0[19]} {mips0/Reg[12]__0[20]} {mips0/Reg[12]__0[21]} {mips0/Reg[12]__0[22]} {mips0/Reg[12]__0[23]} {mips0/Reg[12]__0[24]} {mips0/Reg[12]__0[25]} {mips0/Reg[12]__0[26]} {mips0/Reg[12]__0[27]} {mips0/Reg[12]__0[28]} {mips0/Reg[12]__0[29]} {mips0/Reg[12]__0[30]} {mips0/Reg[12]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 32 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list {mips0/Reg[13]__0[0]} {mips0/Reg[13]__0[1]} {mips0/Reg[13]__0[2]} {mips0/Reg[13]__0[3]} {mips0/Reg[13]__0[4]} {mips0/Reg[13]__0[5]} {mips0/Reg[13]__0[6]} {mips0/Reg[13]__0[7]} {mips0/Reg[13]__0[8]} {mips0/Reg[13]__0[9]} {mips0/Reg[13]__0[10]} {mips0/Reg[13]__0[11]} {mips0/Reg[13]__0[12]} {mips0/Reg[13]__0[13]} {mips0/Reg[13]__0[14]} {mips0/Reg[13]__0[15]} {mips0/Reg[13]__0[16]} {mips0/Reg[13]__0[17]} {mips0/Reg[13]__0[18]} {mips0/Reg[13]__0[19]} {mips0/Reg[13]__0[20]} {mips0/Reg[13]__0[21]} {mips0/Reg[13]__0[22]} {mips0/Reg[13]__0[23]} {mips0/Reg[13]__0[24]} {mips0/Reg[13]__0[25]} {mips0/Reg[13]__0[26]} {mips0/Reg[13]__0[27]} {mips0/Reg[13]__0[28]} {mips0/Reg[13]__0[29]} {mips0/Reg[13]__0[30]} {mips0/Reg[13]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 32 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list {mips0/Reg[22]__0[0]} {mips0/Reg[22]__0[1]} {mips0/Reg[22]__0[2]} {mips0/Reg[22]__0[3]} {mips0/Reg[22]__0[4]} {mips0/Reg[22]__0[5]} {mips0/Reg[22]__0[6]} {mips0/Reg[22]__0[7]} {mips0/Reg[22]__0[8]} {mips0/Reg[22]__0[9]} {mips0/Reg[22]__0[10]} {mips0/Reg[22]__0[11]} {mips0/Reg[22]__0[12]} {mips0/Reg[22]__0[13]} {mips0/Reg[22]__0[14]} {mips0/Reg[22]__0[15]} {mips0/Reg[22]__0[16]} {mips0/Reg[22]__0[17]} {mips0/Reg[22]__0[18]} {mips0/Reg[22]__0[19]} {mips0/Reg[22]__0[20]} {mips0/Reg[22]__0[21]} {mips0/Reg[22]__0[22]} {mips0/Reg[22]__0[23]} {mips0/Reg[22]__0[24]} {mips0/Reg[22]__0[25]} {mips0/Reg[22]__0[26]} {mips0/Reg[22]__0[27]} {mips0/Reg[22]__0[28]} {mips0/Reg[22]__0[29]} {mips0/Reg[22]__0[30]} {mips0/Reg[22]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 32 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list {mips0/Reg[1]__0[0]} {mips0/Reg[1]__0[1]} {mips0/Reg[1]__0[2]} {mips0/Reg[1]__0[3]} {mips0/Reg[1]__0[4]} {mips0/Reg[1]__0[5]} {mips0/Reg[1]__0[6]} {mips0/Reg[1]__0[7]} {mips0/Reg[1]__0[8]} {mips0/Reg[1]__0[9]} {mips0/Reg[1]__0[10]} {mips0/Reg[1]__0[11]} {mips0/Reg[1]__0[12]} {mips0/Reg[1]__0[13]} {mips0/Reg[1]__0[14]} {mips0/Reg[1]__0[15]} {mips0/Reg[1]__0[16]} {mips0/Reg[1]__0[17]} {mips0/Reg[1]__0[18]} {mips0/Reg[1]__0[19]} {mips0/Reg[1]__0[20]} {mips0/Reg[1]__0[21]} {mips0/Reg[1]__0[22]} {mips0/Reg[1]__0[23]} {mips0/Reg[1]__0[24]} {mips0/Reg[1]__0[25]} {mips0/Reg[1]__0[26]} {mips0/Reg[1]__0[27]} {mips0/Reg[1]__0[28]} {mips0/Reg[1]__0[29]} {mips0/Reg[1]__0[30]} {mips0/Reg[1]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 32 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list {mips0/Reg[24]__0[0]} {mips0/Reg[24]__0[1]} {mips0/Reg[24]__0[2]} {mips0/Reg[24]__0[3]} {mips0/Reg[24]__0[4]} {mips0/Reg[24]__0[5]} {mips0/Reg[24]__0[6]} {mips0/Reg[24]__0[7]} {mips0/Reg[24]__0[8]} {mips0/Reg[24]__0[9]} {mips0/Reg[24]__0[10]} {mips0/Reg[24]__0[11]} {mips0/Reg[24]__0[12]} {mips0/Reg[24]__0[13]} {mips0/Reg[24]__0[14]} {mips0/Reg[24]__0[15]} {mips0/Reg[24]__0[16]} {mips0/Reg[24]__0[17]} {mips0/Reg[24]__0[18]} {mips0/Reg[24]__0[19]} {mips0/Reg[24]__0[20]} {mips0/Reg[24]__0[21]} {mips0/Reg[24]__0[22]} {mips0/Reg[24]__0[23]} {mips0/Reg[24]__0[24]} {mips0/Reg[24]__0[25]} {mips0/Reg[24]__0[26]} {mips0/Reg[24]__0[27]} {mips0/Reg[24]__0[28]} {mips0/Reg[24]__0[29]} {mips0/Reg[24]__0[30]} {mips0/Reg[24]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 32 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list {mips0/Reg[31]__0[0]} {mips0/Reg[31]__0[1]} {mips0/Reg[31]__0[2]} {mips0/Reg[31]__0[3]} {mips0/Reg[31]__0[4]} {mips0/Reg[31]__0[5]} {mips0/Reg[31]__0[6]} {mips0/Reg[31]__0[7]} {mips0/Reg[31]__0[8]} {mips0/Reg[31]__0[9]} {mips0/Reg[31]__0[10]} {mips0/Reg[31]__0[11]} {mips0/Reg[31]__0[12]} {mips0/Reg[31]__0[13]} {mips0/Reg[31]__0[14]} {mips0/Reg[31]__0[15]} {mips0/Reg[31]__0[16]} {mips0/Reg[31]__0[17]} {mips0/Reg[31]__0[18]} {mips0/Reg[31]__0[19]} {mips0/Reg[31]__0[20]} {mips0/Reg[31]__0[21]} {mips0/Reg[31]__0[22]} {mips0/Reg[31]__0[23]} {mips0/Reg[31]__0[24]} {mips0/Reg[31]__0[25]} {mips0/Reg[31]__0[26]} {mips0/Reg[31]__0[27]} {mips0/Reg[31]__0[28]} {mips0/Reg[31]__0[29]} {mips0/Reg[31]__0[30]} {mips0/Reg[31]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 32 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list {mips0/Reg[4]__0[0]} {mips0/Reg[4]__0[1]} {mips0/Reg[4]__0[2]} {mips0/Reg[4]__0[3]} {mips0/Reg[4]__0[4]} {mips0/Reg[4]__0[5]} {mips0/Reg[4]__0[6]} {mips0/Reg[4]__0[7]} {mips0/Reg[4]__0[8]} {mips0/Reg[4]__0[9]} {mips0/Reg[4]__0[10]} {mips0/Reg[4]__0[11]} {mips0/Reg[4]__0[12]} {mips0/Reg[4]__0[13]} {mips0/Reg[4]__0[14]} {mips0/Reg[4]__0[15]} {mips0/Reg[4]__0[16]} {mips0/Reg[4]__0[17]} {mips0/Reg[4]__0[18]} {mips0/Reg[4]__0[19]} {mips0/Reg[4]__0[20]} {mips0/Reg[4]__0[21]} {mips0/Reg[4]__0[22]} {mips0/Reg[4]__0[23]} {mips0/Reg[4]__0[24]} {mips0/Reg[4]__0[25]} {mips0/Reg[4]__0[26]} {mips0/Reg[4]__0[27]} {mips0/Reg[4]__0[28]} {mips0/Reg[4]__0[29]} {mips0/Reg[4]__0[30]} {mips0/Reg[4]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 32 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list {mips0/Reg[16]__0[0]} {mips0/Reg[16]__0[1]} {mips0/Reg[16]__0[2]} {mips0/Reg[16]__0[3]} {mips0/Reg[16]__0[4]} {mips0/Reg[16]__0[5]} {mips0/Reg[16]__0[6]} {mips0/Reg[16]__0[7]} {mips0/Reg[16]__0[8]} {mips0/Reg[16]__0[9]} {mips0/Reg[16]__0[10]} {mips0/Reg[16]__0[11]} {mips0/Reg[16]__0[12]} {mips0/Reg[16]__0[13]} {mips0/Reg[16]__0[14]} {mips0/Reg[16]__0[15]} {mips0/Reg[16]__0[16]} {mips0/Reg[16]__0[17]} {mips0/Reg[16]__0[18]} {mips0/Reg[16]__0[19]} {mips0/Reg[16]__0[20]} {mips0/Reg[16]__0[21]} {mips0/Reg[16]__0[22]} {mips0/Reg[16]__0[23]} {mips0/Reg[16]__0[24]} {mips0/Reg[16]__0[25]} {mips0/Reg[16]__0[26]} {mips0/Reg[16]__0[27]} {mips0/Reg[16]__0[28]} {mips0/Reg[16]__0[29]} {mips0/Reg[16]__0[30]} {mips0/Reg[16]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 32 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list {mips0/Reg[17]__0[0]} {mips0/Reg[17]__0[1]} {mips0/Reg[17]__0[2]} {mips0/Reg[17]__0[3]} {mips0/Reg[17]__0[4]} {mips0/Reg[17]__0[5]} {mips0/Reg[17]__0[6]} {mips0/Reg[17]__0[7]} {mips0/Reg[17]__0[8]} {mips0/Reg[17]__0[9]} {mips0/Reg[17]__0[10]} {mips0/Reg[17]__0[11]} {mips0/Reg[17]__0[12]} {mips0/Reg[17]__0[13]} {mips0/Reg[17]__0[14]} {mips0/Reg[17]__0[15]} {mips0/Reg[17]__0[16]} {mips0/Reg[17]__0[17]} {mips0/Reg[17]__0[18]} {mips0/Reg[17]__0[19]} {mips0/Reg[17]__0[20]} {mips0/Reg[17]__0[21]} {mips0/Reg[17]__0[22]} {mips0/Reg[17]__0[23]} {mips0/Reg[17]__0[24]} {mips0/Reg[17]__0[25]} {mips0/Reg[17]__0[26]} {mips0/Reg[17]__0[27]} {mips0/Reg[17]__0[28]} {mips0/Reg[17]__0[29]} {mips0/Reg[17]__0[30]} {mips0/Reg[17]__0[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 32 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list {mips0/inst[0]} {mips0/inst[1]} {mips0/inst[2]} {mips0/inst[3]} {mips0/inst[4]} {mips0/inst[5]} {mips0/inst[6]} {mips0/inst[7]} {mips0/inst[8]} {mips0/inst[9]} {mips0/inst[10]} {mips0/inst[11]} {mips0/inst[12]} {mips0/inst[13]} {mips0/inst[14]} {mips0/inst[15]} {mips0/inst[16]} {mips0/inst[17]} {mips0/inst[18]} {mips0/inst[19]} {mips0/inst[20]} {mips0/inst[21]} {mips0/inst[22]} {mips0/inst[23]} {mips0/inst[24]} {mips0/inst[25]} {mips0/inst[26]} {mips0/inst[27]} {mips0/inst[28]} {mips0/inst[29]} {mips0/inst[30]} {mips0/inst[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 32 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list {mips0/pc[0]} {mips0/pc[1]} {mips0/pc[2]} {mips0/pc[3]} {mips0/pc[4]} {mips0/pc[5]} {mips0/pc[6]} {mips0/pc[7]} {mips0/pc[8]} {mips0/pc[9]} {mips0/pc[10]} {mips0/pc[11]} {mips0/pc[12]} {mips0/pc[13]} {mips0/pc[14]} {mips0/pc[15]} {mips0/pc[16]} {mips0/pc[17]} {mips0/pc[18]} {mips0/pc[19]} {mips0/pc[20]} {mips0/pc[21]} {mips0/pc[22]} {mips0/pc[23]} {mips0/pc[24]} {mips0/pc[25]} {mips0/pc[26]} {mips0/pc[27]} {mips0/pc[28]} {mips0/pc[29]} {mips0/pc[30]} {mips0/pc[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list mips0/rst]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list clk_wiz_0_0/inst/clkfbout_buf_clk_wiz_0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 1 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list clk_50M_IBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_1_clkfbout_buf_clk_wiz_0]
