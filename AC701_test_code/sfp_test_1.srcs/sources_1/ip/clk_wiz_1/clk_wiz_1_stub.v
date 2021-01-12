// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2700185 Thu Oct 24 18:46:05 MDT 2019
// Date        : Mon Nov  2 16:50:14 2020
// Host        : DiegoArandaPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/Diego/Documents/Fiuna/LME/Link
//               test/AC701/sfp_test_simple/sfp_test_simple.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_stub.v}
// Design      : clk_wiz_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_1(clk_240, clk_40, clk_300, reset, locked, clk_in1_p, 
  clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="clk_240,clk_40,clk_300,reset,locked,clk_in1_p,clk_in1_n" */;
  output clk_240;
  output clk_40;
  output clk_300;
  input reset;
  output locked;
  input clk_in1_p;
  input clk_in1_n;
endmodule
