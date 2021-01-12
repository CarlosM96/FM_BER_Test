// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2700185 Thu Oct 24 18:46:05 MDT 2019
// Date        : Thu Nov 12 19:45:02 2020
// Host        : DiegoArandaPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Diego/Documents/Fiuna/LME/Link
//               test/AC701/sfp_test_1/sfp_test_1.srcs/sources_1/ip/fifo_fm/fifo_fm_stub.v}
// Design      : fifo_fm
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_5,Vivado 2019.2" *)
module fifo_fm(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  empty, wr_rst_busy, rd_rst_busy)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[33:0],wr_en,rd_en,dout[33:0],full,empty,wr_rst_busy,rd_rst_busy" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [33:0]din;
  input wr_en;
  input rd_en;
  output [33:0]dout;
  output full;
  output empty;
  output wr_rst_busy;
  output rd_rst_busy;
endmodule
