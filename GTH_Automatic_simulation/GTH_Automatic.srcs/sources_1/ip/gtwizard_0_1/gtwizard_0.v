///////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version : 3.6
//  \   \         Application : 7 Series FPGAs Transceivers Wizard
//  /   /         Filename : gtwizard_0.v
// /___/   /\     
// \   \  /  \ 
//  \___\/\___\
//
//
// Module gtwizard_0 (a Core Top)
// Generated by Xilinx 7 Series FPGAs Transceivers Wizard
// 
// 
// (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


`default_nettype wire

`timescale 1ns / 1ps
`define DLY #1

//***************************** Entity Declaration ****************************
(* DowngradeIPIdentifiedWarnings="yes" *)
(* X_CORE_INFO = "gtwizard_0,gtwizard_v3_6_11,{protocol_file=Start_from_scratch}" *) 
(* CORE_GENERATION_INFO = "gtwizard_0,gtwizard_v3_6_11,{protocol_file=Start_from_scratch}" *)module gtwizard_0 
(
input           soft_reset_rx_in,
input           dont_reset_on_data_error_in,
    input  q3_clk0_gtrefclk_pad_n_in,
    input  q3_clk0_gtrefclk_pad_p_in,
output          gt0_rx_mmcm_lock_out,
output          gt0_tx_fsm_reset_done_out,
output          gt0_rx_fsm_reset_done_out,
input           gt0_data_valid_in,
 
    output   gt0_rxusrclk_out,
    output   gt0_rxusrclk2_out,

    //_________________________________________________________________________
    //GT0  (X1Y12)
    //____________________________CHANNEL PORTS________________________________
    //-------------------------- Channel - DRP Ports  --------------------------
    input   [8:0]   gt0_drpaddr_in,
    input   [15:0]  gt0_drpdi_in,
    output  [15:0]  gt0_drpdo_out,
    input           gt0_drpen_in,
    output          gt0_drprdy_out,
    input           gt0_drpwe_in,
    //------------------- RX Initialization and Reset Ports --------------------
    input           gt0_eyescanreset_in,
    input           gt0_rxuserrdy_in,
    //------------------------ RX Margin Analysis Ports ------------------------
    output          gt0_eyescandataerror_out,
    input           gt0_eyescantrigger_in,
    //----------------- Receive Ports - Digital Monitor Ports ------------------
    output  [14:0]  gt0_dmonitorout_out,
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
    output  [31:0]  gt0_rxdata_out,
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
    output  [3:0]   gt0_rxdisperr_out,
    output  [3:0]   gt0_rxnotintable_out,
    //---------------------- Receive Ports - RX AFE Ports ----------------------
    input           gt0_gthrxn_in,
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
    output  [4:0]   gt0_rxphmonitor_out,
    output  [4:0]   gt0_rxphslipmonitor_out,
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
    output          gt0_rxbyteisaligned_out,
    output          gt0_rxcommadet_out,
    input           gt0_rxmcommaalignen_in,
    input           gt0_rxpcommaalignen_in,
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    output  [6:0]   gt0_rxmonitorout_out,
    input   [1:0]   gt0_rxmonitorsel_in,
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
    output          gt0_rxoutclkfabric_out,
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    input           gt0_gtrxreset_in,
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    output  [3:0]   gt0_rxcharisk_out,
    //---------------------- Receive Ports -RX AFE Ports -----------------------
    input           gt0_gthrxp_in,
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
    output          gt0_rxresetdone_out,
    //------------------- TX Initialization and Reset Ports --------------------
    input           gt0_gttxreset_in,

    //____________________________COMMON PORTS________________________________
    output      gt0_qplllock_out,
    output      gt0_qpllrefclklost_out,
    output     gt0_qpllreset_out,
    output      gt0_qplloutclk_out,
    output      gt0_qplloutrefclk_out,
    input           sysclk_in

);

//-----------------------Support Wrapper Instatiation--------------------
    gtwizard_0_support #
    (
        .EXAMPLE_SIM_GTRESET_SPEEDUP    ("FALSE"),
        .STABLE_CLOCK_PERIOD            (25)
    )
    inst
    (
     .soft_reset_rx_in(soft_reset_rx_in),
     .dont_reset_on_data_error_in(dont_reset_on_data_error_in),
    .q3_clk0_gtrefclk_pad_n_in(q3_clk0_gtrefclk_pad_n_in),
    .q3_clk0_gtrefclk_pad_p_in(q3_clk0_gtrefclk_pad_p_in),
     .gt0_rx_mmcm_lock_out(gt0_rx_mmcm_lock_out),
     .gt0_tx_fsm_reset_done_out(gt0_tx_fsm_reset_done_out),
     .gt0_rx_fsm_reset_done_out(gt0_rx_fsm_reset_done_out),
     .gt0_data_valid_in(gt0_data_valid_in),
 
    .gt0_rxusrclk_out(gt0_rxusrclk_out),
    .gt0_rxusrclk2_out(gt0_rxusrclk2_out),
    //_________________________________________________________________________
    //GT0  (X1Y12)
    //____________________________CHANNEL PORTS________________________________
    //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt0_drpaddr_in), // input wire [8:0] gt0_drpaddr_in
        .gt0_drpdi_in                   (gt0_drpdi_in), // input wire [15:0] gt0_drpdi_in
        .gt0_drpdo_out                  (gt0_drpdo_out), // output wire [15:0] gt0_drpdo_out
        .gt0_drpen_in                   (gt0_drpen_in), // input wire gt0_drpen_in
        .gt0_drprdy_out                 (gt0_drprdy_out), // output wire gt0_drprdy_out
        .gt0_drpwe_in                   (gt0_drpwe_in), // input wire gt0_drpwe_in
    //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (gt0_eyescanreset_in), // input wire gt0_eyescanreset_in
        .gt0_rxuserrdy_in               (gt0_rxuserrdy_in), // input wire gt0_rxuserrdy_in
    //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_out), // output wire gt0_eyescandataerror_out
        .gt0_eyescantrigger_in          (gt0_eyescantrigger_in), // input wire gt0_eyescantrigger_in
    //----------------- Receive Ports - Digital Monitor Ports ------------------
        .gt0_dmonitorout_out            (gt0_dmonitorout_out), // output wire [14:0] gt0_dmonitorout_out
    //---------------- Receive Ports - FPGA RX interface Ports -----------------
        .gt0_rxdata_out                 (gt0_rxdata_out), // output wire [31:0] gt0_rxdata_out
    //---------------- Receive Ports - RX 8B/10B Decoder Ports -----------------
        .gt0_rxdisperr_out              (gt0_rxdisperr_out), // output wire [3:0] gt0_rxdisperr_out
        .gt0_rxnotintable_out           (gt0_rxnotintable_out), // output wire [3:0] gt0_rxnotintable_out
    //---------------------- Receive Ports - RX AFE Ports ----------------------
        .gt0_gthrxn_in                  (gt0_gthrxn_in), // input wire gt0_gthrxn_in
    //----------------- Receive Ports - RX Buffer Bypass Ports -----------------
        .gt0_rxphmonitor_out            (gt0_rxphmonitor_out), // output wire [4:0] gt0_rxphmonitor_out
        .gt0_rxphslipmonitor_out        (gt0_rxphslipmonitor_out), // output wire [4:0] gt0_rxphslipmonitor_out
    //------------ Receive Ports - RX Byte and Word Alignment Ports ------------
        .gt0_rxbyteisaligned_out        (gt0_rxbyteisaligned_out), // output wire gt0_rxbyteisaligned_out
        .gt0_rxcommadet_out             (gt0_rxcommadet_out), // output wire gt0_rxcommadet_out
        .gt0_rxmcommaalignen_in         (gt0_rxmcommaalignen_in), // input wire gt0_rxmcommaalignen_in
        .gt0_rxpcommaalignen_in         (gt0_rxpcommaalignen_in), // input wire gt0_rxpcommaalignen_in
    //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_out), // output wire [6:0] gt0_rxmonitorout_out
        .gt0_rxmonitorsel_in            (gt0_rxmonitorsel_in), // input wire [1:0] gt0_rxmonitorsel_in
    //------------- Receive Ports - RX Fabric Output Control Ports -------------
        .gt0_rxoutclkfabric_out         (gt0_rxoutclkfabric_out), // output wire gt0_rxoutclkfabric_out
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (gt0_gtrxreset_in), // input wire gt0_gtrxreset_in
    //----------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        .gt0_rxcharisk_out              (gt0_rxcharisk_out), // output wire [3:0] gt0_rxcharisk_out
    //---------------------- Receive Ports -RX AFE Ports -----------------------
        .gt0_gthrxp_in                  (gt0_gthrxp_in), // input wire gt0_gthrxp_in
    //------------ Receive Ports -RX Initialization and Reset Ports ------------
        .gt0_rxresetdone_out            (gt0_rxresetdone_out), // output wire gt0_rxresetdone_out
    //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (gt0_gttxreset_in), // input wire gt0_gttxreset_in

    //____________________________COMMON PORTS________________________________
    .gt0_qplllock_out(gt0_qplllock_out),
    .gt0_qpllrefclklost_out(gt0_qpllrefclklost_out),
    .gt0_qpllreset_out(gt0_qpllreset_out),
    .gt0_qplloutclk_out(gt0_qplloutclk_out),
    .gt0_qplloutrefclk_out(gt0_qplloutrefclk_out),
     .sysclk_in(sysclk_in)

);
endmodule

