set_property SRC_FILE_INFO {cfile:/home/daphnelme/Desktop/GTH_RX_SIM_Folder_diego/RX_error_int/rx_error_int/rx_error_int.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0/clk_wiz_0_in_context.xdc rfile:../../../rx_error_int.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0/clk_wiz_0_in_context.xdc id:1 order:EARLY scoped_inst:clk_wiz_0} [current_design]
set_property SRC_FILE_INFO {cfile:/home/daphnelme/Desktop/GTH_RX_SIM_Folder_diego/RX_error_int/rx_error_int/rx_error_int.srcs/sources_1/ip/RX_vc709/RX_vc709/RX_vc709_in_context.xdc rfile:../../../rx_error_int.srcs/sources_1/ip/RX_vc709/RX_vc709/RX_vc709_in_context.xdc id:2 order:EARLY scoped_inst:RX_TOP/RX_vc709_support_i} [current_design]
set_property SRC_FILE_INFO {cfile:/home/daphnelme/Desktop/GTH_RX_SIM_Folder_diego/RX_error_int/rx_error_int/rx_error_int.srcs/constrs_1/new/const.xdc rfile:../../../rx_error_int.srcs/constrs_1/new/const.xdc id:3} [current_design]
current_instance clk_wiz_0
set_property src_info {type:SCOPED_XDC file:1 line:1 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 6.400 [get_ports -no_traverse {}]
set_property src_info {type:SCOPED_XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -source [get_ports clk_in1_p] -edges {1 2 3} -edge_shift {0.000 -1.116 -2.233} [get_ports {}]
set_property src_info {type:SCOPED_XDC file:1 line:6 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -source [get_ports clk_in1_p] -edges {1 2 3} -edge_shift {0.000 9.302 18.605} [get_ports {}]
current_instance
current_instance RX_TOP/RX_vc709_support_i
set_property src_info {type:SCOPED_XDC file:2 line:2 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 4.167 [get_ports {}]
set_property src_info {type:SCOPED_XDC file:2 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 8.334 [get_ports {}]
set_property src_info {type:SCOPED_XDC file:2 line:6 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 4.167 [get_ports {}]
current_instance
set_property src_info {type:XDC file:3 line:85 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -to [get_pins -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_on_error_in_r*}]]
set_property src_info {type:XDC file:3 line:94 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AH7 [get_ports  clk_n]
set_property src_info {type:XDC file:3 line:95 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AH8 [get_ports  clk_p ]
set_property src_info {type:XDC file:3 line:97 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AW32 [get_ports clk_si5324_240_out_p]
set_property src_info {type:XDC file:3 line:98 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AW33 [get_ports clk_si5324_240_out_n]
set_property src_info {type:XDC file:3 line:113 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AK34 [get_ports USER_CLK_P]
set_property src_info {type:XDC file:3 line:114 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AL34 [get_ports USER_CLK_N]
set_property src_info {type:XDC file:3 line:116 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AU32 [get_ports SDA]
set_property src_info {type:XDC file:3 line:117 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AT35 [get_ports SCL]
set_property src_info {type:XDC file:3 line:118 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AY42 [get_ports i2cmux_rst]
set_property src_info {type:XDC file:3 line:124 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AT36 [get_ports si5324_resetn]
set_property src_info {type:XDC file:3 line:127 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AV30 [get_ports transerial]
set_property src_info {type:XDC file:3 line:130 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AV40 [get_ports reset]
set_property src_info {type:XDC file:3 line:133 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AN6 [get_ports  rx_p]
set_property src_info {type:XDC file:3 line:135 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN AN5 [get_ports  rx_n]
set_property src_info {type:XDC file:3 line:141 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AM39 [get_ports  rxinit]
set_property src_info {type:XDC file:3 line:145 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AN39 [get_ports  commadet]
set_property src_info {type:XDC file:3 line:149 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AR37 [get_ports  led_3c]
set_property src_info {type:XDC file:3 line:153 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AT37 [get_ports  led_aligned]
set_property src_info {type:XDC file:3 line:156 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AU36 [get_ports  data_serial2]
set_property src_info {type:XDC file:3 line:169 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC GTHE2_CHANNEL_X1Y12 [get_cells RX_vc709_support_i/inst/RX_vc709_init_i/RX_vc709_i/gt0_RX_vc709_i/gthe2_i]
