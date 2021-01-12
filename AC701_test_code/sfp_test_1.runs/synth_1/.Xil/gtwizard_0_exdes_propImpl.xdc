set_property SRC_FILE_INFO {cfile:/home/daphnelme/Desktop/CarlosPrueba/sfp_test_1/sfp_test_1.srcs/constrs_1/imports/example_design/gtwizard_0_exdes.xdc rfile:../../../sfp_test_1.srcs/constrs_1/imports/example_design/gtwizard_0_exdes.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:74 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clk40 [get_pins clk_wiz_1/inst/mmcm_adv_inst/CLKOUT1]
set_property src_info {type:XDC file:1 line:79 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -datapath_only -from [get_clocks clk40] -to [get_clocks clkout0_1] 24.97
set_property src_info {type:XDC file:1 line:80 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -datapath_only -from [get_clocks clkout0_1] -to [get_clocks clk40] 24.97
set_property src_info {type:XDC file:1 line:97 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AB13 [get_ports  Q0_CLK1_GTREFCLK_PAD_N_IN ]
set_property src_info {type:XDC file:1 line:98 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AA13 [get_ports  Q0_CLK1_GTREFCLK_PAD_P_IN ]
set_property src_info {type:XDC file:1 line:101 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AC10 [get_ports  TXP_OUT ]
set_property src_info {type:XDC file:1 line:102 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AD10 [get_ports  TXN_OUT ]
set_property src_info {type:XDC file:1 line:104 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AC12 [get_ports  RXP_IN ]
set_property src_info {type:XDC file:1 line:105 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC AD12 [get_ports  RXN_IN ]
set_property src_info {type:XDC file:1 line:107 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC D23 [get_ports  clk_si5324_240_out_p ]
set_property src_info {type:XDC file:1 line:108 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC D24 [get_ports  clk_si5324_240_out_n ]
set_property src_info {type:XDC file:1 line:112 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B24 [get_ports si5324_resetn]
set_property src_info {type:XDC file:1 line:115 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R17 [get_ports i2cmux_rst]
set_property src_info {type:XDC file:1 line:119 export:INPUT save:INPUT read:READ} [current_design]
set_property  LOC K25 [get_ports  SDA ]
set_property src_info {type:XDC file:1 line:120 export:INPUT save:INPUT read:READ} [current_design]
set_property  LOC N18 [get_ports  SCL ]
set_property src_info {type:XDC file:1 line:128 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC M21 [get_ports  USER_CLK_P]
set_property src_info {type:XDC file:1 line:131 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC M22 [get_ports  USER_CLK_N]
set_property src_info {type:XDC file:1 line:134 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC M26 [get_ports led0]
set_property src_info {type:XDC file:1 line:137 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC T24 [get_ports led1]
set_property src_info {type:XDC file:1 line:140 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC T25 [get_ports led2]
set_property src_info {type:XDC file:1 line:143 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC R26 [get_ports led3]
set_property src_info {type:XDC file:1 line:146 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC U4 [get_ports RESET]
set_property src_info {type:XDC file:1 line:149 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC U19 [get_ports TXSERIAL]
set_property src_info {type:XDC file:1 line:153 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC B26 [get_ports pcie_mgt_clk_sel0]
set_property src_info {type:XDC file:1 line:156 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC C24 [get_ports pcie_mgt_clk_sel1]
set_property src_info {type:XDC file:1 line:159 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC U4 [get_ports RESET]
set_property src_info {type:XDC file:1 line:162 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC U6 [get_ports SW6]
set_property src_info {type:XDC file:1 line:173 export:INPUT save:INPUT read:READ} [current_design]
set_property LOC GTPE2_CHANNEL_X0Y0 [get_cells gtwizard_0_support_i/inst/gtwizard_0_init_i/gtwizard_0_i/gt0_gtwizard_0_i/gtpe2_i]