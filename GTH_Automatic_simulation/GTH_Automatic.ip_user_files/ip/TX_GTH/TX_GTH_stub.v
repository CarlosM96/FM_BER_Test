// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Wed Nov  4 14:30:41 2020
// Host        : localhost.localdomain running 64-bit Scientific Linux release 7.7 (Nitrogen)
// Command     : write_verilog -force -mode synth_stub
//               /home/daphnelme/Desktop/CarlosPrueba/GTH_RX_SIM_Folder/GTH_RX_VC709/GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/TX_GTH_stub.v
// Design      : TX_GTH
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "TX_GTH,gtwizard_v3_6_11,{protocol_file=Start_from_scratch}" *)
module TX_GTH(soft_reset_tx_in, 
  dont_reset_on_data_error_in, q3_clk0_gtrefclk_pad_n_in, q3_clk0_gtrefclk_pad_p_in, 
  gt0_tx_mmcm_lock_out, gt0_tx_fsm_reset_done_out, gt0_rx_fsm_reset_done_out, 
  gt0_data_valid_in, gt0_txusrclk_out, gt0_txusrclk2_out, gt0_drpaddr_in, gt0_drpdi_in, 
  gt0_drpdo_out, gt0_drpen_in, gt0_drprdy_out, gt0_drpwe_in, gt0_eyescanreset_in, 
  gt0_eyescandataerror_out, gt0_eyescantrigger_in, gt0_dmonitorout_out, 
  gt0_rxmonitorout_out, gt0_rxmonitorsel_in, gt0_gtrxreset_in, gt0_gttxreset_in, 
  gt0_txuserrdy_in, gt0_txdata_in, gt0_gthtxn_out, gt0_gthtxp_out, gt0_txoutclkfabric_out, 
  gt0_txoutclkpcs_out, gt0_txresetdone_out, gt0_txcharisk_in, gt0_qplllock_out, 
  gt0_qpllrefclklost_out, gt0_qplloutclk_out, gt0_qplloutrefclk_out, sysclk_in)
/* synthesis syn_black_box black_box_pad_pin="soft_reset_tx_in,dont_reset_on_data_error_in,q3_clk0_gtrefclk_pad_n_in,q3_clk0_gtrefclk_pad_p_in,gt0_tx_mmcm_lock_out,gt0_tx_fsm_reset_done_out,gt0_rx_fsm_reset_done_out,gt0_data_valid_in,gt0_txusrclk_out,gt0_txusrclk2_out,gt0_drpaddr_in[8:0],gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_eyescanreset_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_dmonitorout_out[14:0],gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_gtrxreset_in,gt0_gttxreset_in,gt0_txuserrdy_in,gt0_txdata_in[31:0],gt0_gthtxn_out,gt0_gthtxp_out,gt0_txoutclkfabric_out,gt0_txoutclkpcs_out,gt0_txresetdone_out,gt0_txcharisk_in[3:0],gt0_qplllock_out,gt0_qpllrefclklost_out,gt0_qplloutclk_out,gt0_qplloutrefclk_out,sysclk_in" */;
  input soft_reset_tx_in;
  input dont_reset_on_data_error_in;
  input q3_clk0_gtrefclk_pad_n_in;
  input q3_clk0_gtrefclk_pad_p_in;
  output gt0_tx_mmcm_lock_out;
  output gt0_tx_fsm_reset_done_out;
  output gt0_rx_fsm_reset_done_out;
  input gt0_data_valid_in;
  output gt0_txusrclk_out;
  output gt0_txusrclk2_out;
  input [8:0]gt0_drpaddr_in;
  input [15:0]gt0_drpdi_in;
  output [15:0]gt0_drpdo_out;
  input gt0_drpen_in;
  output gt0_drprdy_out;
  input gt0_drpwe_in;
  input gt0_eyescanreset_in;
  output gt0_eyescandataerror_out;
  input gt0_eyescantrigger_in;
  output [14:0]gt0_dmonitorout_out;
  output [6:0]gt0_rxmonitorout_out;
  input [1:0]gt0_rxmonitorsel_in;
  input gt0_gtrxreset_in;
  input gt0_gttxreset_in;
  input gt0_txuserrdy_in;
  input [31:0]gt0_txdata_in;
  output gt0_gthtxn_out;
  output gt0_gthtxp_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  output gt0_txresetdone_out;
  input [3:0]gt0_txcharisk_in;
  output gt0_qplllock_out;
  output gt0_qpllrefclklost_out;
  output gt0_qplloutclk_out;
  output gt0_qplloutrefclk_out;
  input sysclk_in;
endmodule
