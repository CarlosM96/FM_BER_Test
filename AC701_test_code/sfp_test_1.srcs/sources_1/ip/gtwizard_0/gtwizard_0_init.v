//------------------------------------------------------------------------------
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version : 3.6
//  \   \         Application : 7 Series FPGAs Transceivers Wizard 
//  /   /         Filename : gtwizard_0_init.v
// /___/   /\      
// \   \  /  \ 
//  \___\/\___\
//
//  Description : This module instantiates the modules required for
//                reset and initialisation of the Transceiver
//
// Module gtwizard_0_init
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


`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration************************
(* DowngradeIPIdentifiedWarnings="yes" *)
module gtwizard_0_init #
(
    parameter EXAMPLE_SIM_GTRESET_SPEEDUP            = "TRUE",     // Simulation setting for GT SecureIP model
    parameter EXAMPLE_SIMULATION                     =  0,         // Set to 1 for simulation
    parameter STABLE_CLOCK_PERIOD                    = 25,         //Period of the stable clock driving this state-machine, unit is [ns]
    parameter EXAMPLE_USE_CHIPSCOPE                  =  0          // Set to 1 to use Chipscope to drive resets

)
(
input           sysclk_in,
input           soft_reset_tx_in,
input           dont_reset_on_data_error_in,
output          gt0_tx_fsm_reset_done_out,
output          gt0_rx_fsm_reset_done_out,
input           gt0_data_valid_in,
input           gt0_tx_mmcm_lock_in,
output          gt0_tx_mmcm_reset_out,

    //_________________________________________________________________________
    //GT0  (X0Y0)
    //____________________________CHANNEL PORTS________________________________
    //-------------------------- Channel - DRP Ports  --------------------------
    input   [8:0]   gt0_drpaddr_in,
    input           gt0_drpclk_in,
    input   [15:0]  gt0_drpdi_in,
    output  [15:0]  gt0_drpdo_out,
    input           gt0_drpen_in,
    output          gt0_drprdy_out,
    input           gt0_drpwe_in,
    //------------------- RX Initialization and Reset Ports --------------------
    input           gt0_eyescanreset_in,
    //------------------------ RX Margin Analysis Ports ------------------------
    output          gt0_eyescandataerror_out,
    input           gt0_eyescantrigger_in,
    //---------- Receive Ports - RX Decision Feedback Equalizer(DFE) -----------
    output  [14:0]  gt0_dmonitorout_out,
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    input           gt0_gtrxreset_in,
    input           gt0_rxlpmreset_in,
    //------------------- TX Initialization and Reset Ports --------------------
    input           gt0_gttxreset_in,
    input           gt0_txuserrdy_in,
    //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
    input   [31:0]  gt0_txdata_in,
    input           gt0_txusrclk_in,
    input           gt0_txusrclk2_in,
    //---------------- Transmit Ports - TX 8B/10B Encoder Ports ----------------
    input   [3:0]   gt0_txcharisk_in,
    //------------- Transmit Ports - TX Configurable Driver Ports --------------
    output          gt0_gtptxn_out,
    output          gt0_gtptxp_out,
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    output          gt0_txoutclk_out,
    output          gt0_txoutclkfabric_out,
    output          gt0_txoutclkpcs_out,
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    output          gt0_txresetdone_out,


    //____________________________COMMON PORTS________________________________
   output     gt0_pll0reset_out,
    input          gt0_pll0outclk_in,
    input          gt0_pll0outrefclk_in,
    input          gt0_pll0lock_in,
    input          gt0_pll0refclklost_in,    
    input          gt0_pll1outclk_in,
    input          gt0_pll1outrefclk_in

);



//***********************************Parameter Declarations********************


    //Typical CDRLOCK Time is 50,000UI, as per DS183
    localparam RX_CDRLOCK_TIME      = (EXAMPLE_SIMULATION == 1) ? 1000 : 100000/4.8;
       
    localparam integer   WAIT_TIME_CDRLOCK    = RX_CDRLOCK_TIME / STABLE_CLOCK_PERIOD;      

//-------------------------- GT Wrapper Wires ------------------------------
    wire           gt0_rxpmaresetdone_i;
    wire           gt0_txpmaresetdone_i;
    wire           gt0_txresetdone_i;
    wire           gt0_txresetdone_ii;
    wire           gt0_rxresetdone_i;
    wire           gt0_rxresetdone_ii;
    wire           gt0_gttxreset_i;
    wire           gt0_gttxreset_t;
    wire           gt0_gtrxreset_i;
    wire           gt0_gtrxreset_t;
    wire           gt0_txuserrdy_i;
    wire           gt0_txuserrdy_t;
    wire           gt0_rxuserrdy_i;
    wire           gt0_rxuserrdy_t;




    wire           gt0_pll0reset_i;
    wire           gt0_pll0reset_t;
    wire           gt0_pll0refclklost_i;
    wire           gt0_pll0lock_i;


//------------------------------- Global Signals -----------------------------
    wire          tied_to_ground_i;
    wire          tied_to_vcc_i;

    wire           gt0_txoutclk_i;
    wire           gt0_rxoutclk_i;
    wire           gt0_rxoutclk_i2;
    wire           gt0_txoutclk_i2;
    wire           gt0_recclk_stable_i;
    reg            gt0_rx_cdrlocked;
    integer  gt0_rx_cdrlock_counter= 0;









 


//**************************** Main Body of Code *******************************
    //  Static signal Assigments
assign  tied_to_ground_i                     =  1'b0;
assign  tied_to_vcc_i                        =  1'b1;

//    ----------------------------- The GT Wrapper -----------------------------
    
    // Use the instantiation template in the example directory to add the GT wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.


    gtwizard_0_multi_gt #
    (
        .EXAMPLE_SIMULATION             (EXAMPLE_SIMULATION),
        .WRAPPER_SIM_GTRESET_SPEEDUP    (EXAMPLE_SIM_GTRESET_SPEEDUP)
    )
    gtwizard_0_i
    (
        .gt0_txpmaresetdone_out         (gt0_txpmaresetdone_i),
 
        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT0  (X0Y0)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt0_drpaddr_in), // input wire [8:0] gt0_drpaddr_in
        .gt0_drpclk_in                  (gt0_drpclk_in), // input wire gt0_drpclk_in
        .gt0_drpdi_in                   (gt0_drpdi_in), // input wire [15:0] gt0_drpdi_in
        .gt0_drpdo_out                  (gt0_drpdo_out), // output wire [15:0] gt0_drpdo_out
        .gt0_drpen_in                   (gt0_drpen_in), // input wire gt0_drpen_in
        .gt0_drprdy_out                 (gt0_drprdy_out), // output wire gt0_drprdy_out
        .gt0_drpwe_in                   (gt0_drpwe_in), // input wire gt0_drpwe_in
        //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (gt0_eyescanreset_in), // input wire gt0_eyescanreset_in
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_out), // output wire gt0_eyescandataerror_out
        .gt0_eyescantrigger_in          (gt0_eyescantrigger_in), // input wire gt0_eyescantrigger_in
        //---------- Receive Ports - RX Decision Feedback Equalizer(DFE) -----------
        .gt0_dmonitorout_out            (gt0_dmonitorout_out), // output wire [14:0] gt0_dmonitorout_out
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (gt0_gtrxreset_i), // input wire gt0_gtrxreset_i
        .gt0_rxlpmreset_in              (gt0_rxlpmreset_in), // input wire gt0_rxlpmreset_in
        //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (gt0_gttxreset_i), // input wire gt0_gttxreset_i
        .gt0_txuserrdy_in               (gt0_txuserrdy_i), // input wire gt0_txuserrdy_i
        //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
        .gt0_txdata_in                  (gt0_txdata_in), // input wire [31:0] gt0_txdata_in
        .gt0_txusrclk_in                (gt0_txusrclk_in), // input wire gt0_txusrclk_in
        .gt0_txusrclk2_in               (gt0_txusrclk2_in), // input wire gt0_txusrclk2_in
        //---------------- Transmit Ports - TX 8B/10B Encoder Ports ----------------
        .gt0_txcharisk_in               (gt0_txcharisk_in), // input wire [3:0] gt0_txcharisk_in
        //------------- Transmit Ports - TX Configurable Driver Ports --------------
        .gt0_gtptxn_out                 (gt0_gtptxn_out), // output wire gt0_gtptxn_out
        .gt0_gtptxp_out                 (gt0_gtptxp_out), // output wire gt0_gtptxp_out
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt0_txoutclk_out               (gt0_txoutclk_i), // output wire gt0_txoutclk_i
        .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_out), // output wire gt0_txoutclkfabric_out
        .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_out), // output wire gt0_txoutclkpcs_out
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt0_txresetdone_out            (gt0_txresetdone_i), // output wire gt0_txresetdone_i




    //____________________________COMMON PORTS________________________________
        .gt0_pll0outclk_in              (gt0_pll0outclk_in),
        .gt0_pll0outrefclk_in           (gt0_pll0outrefclk_in),
        .gt0_pll1outclk_in              (gt0_pll1outclk_in),
        .gt0_pll1outrefclk_in           (gt0_pll1outrefclk_in)

    );




assign  gt0_txresetdone_out                  =  gt0_txresetdone_i;
assign  gt0_txoutclk_out                     =  gt0_txoutclk_i;
assign  gt0_pll0reset_out                    =  gt0_pll0reset_t;

generate
if (EXAMPLE_USE_CHIPSCOPE == 1) 
begin : chipscope
assign  gt0_gttxreset_i                      =  gt0_gttxreset_in || gt0_gttxreset_t;
assign  gt0_gtrxreset_i                      =  gt0_gtrxreset_in || gt0_gtrxreset_t;
assign  gt0_txuserrdy_i                      =  gt0_txuserrdy_in && gt0_txuserrdy_t;
end
endgenerate 

generate
if (EXAMPLE_USE_CHIPSCOPE == 0) 
begin : no_chipscope
assign  gt0_gttxreset_i                      =  gt0_gttxreset_t;
assign  gt0_gtrxreset_i                      =  gt0_gtrxreset_t;
assign  gt0_txuserrdy_i                      =  gt0_txuserrdy_t;
assign  gt0_rxuserrdy_i                      =  gt0_rxuserrdy_t;
end
endgenerate 


gtwizard_0_TX_STARTUP_FSM #
          (
           .EXAMPLE_SIMULATION       (EXAMPLE_SIMULATION),
           .STABLE_CLOCK_PERIOD      (STABLE_CLOCK_PERIOD),           // Period of the stable clock driving this state-machine, unit is [ns]
           .RETRY_COUNTER_BITWIDTH   (8), 
           .TX_PLL0_USED             ("TRUE"),                        // the TX and RX Reset FSMs must 
           .RX_PLL0_USED             ("FALSE"),                       // share these two generic values
           .PHASE_ALIGNMENT_MANUAL   ("FALSE")               // Decision if a manual phase-alignment is necessary or the automatic 
                                                                     // is enough. For single-lane applications the automatic alignment is 
                                                                     // sufficient              
             ) 
gt0_txresetfsm_i      
            ( 
        .STABLE_CLOCK                   (sysclk_in),
        .TXUSERCLK                      (gt0_txusrclk_in),
        .SOFT_RESET                     (soft_reset_tx_in),
        .PLL0REFCLKLOST                 (gt0_pll0refclklost_in),
        .PLL0LOCK                       (gt0_pll0lock_in),
        .PLL1REFCLKLOST                 (tied_to_ground_i),
        .PLL1LOCK                       (tied_to_vcc_i),
        .TXRESETDONE                    (gt0_txresetdone_i),
        .MMCM_LOCK                      (gt0_tx_mmcm_lock_in),
        .GTTXRESET                      (gt0_gttxreset_t),
        .MMCM_RESET                     (gt0_tx_mmcm_reset_out),
        .PLL0_RESET                     (gt0_pll0reset_t),
        .PLL1_RESET                     (),
        .TX_FSM_RESET_DONE              (gt0_tx_fsm_reset_done_out),
        .TXUSERRDY                      (gt0_txuserrdy_t),
        .RUN_PHALIGNMENT                (),
        .RESET_PHALIGNMENT              (),
        .PHALIGNMENT_DONE               (tied_to_vcc_i),
        .RETRY_COUNTER                  ()
           );


assign gt0_rxuserrdy_t = tied_to_ground_i;
assign gt0_gtrxreset_t = tied_to_vcc_i;










endmodule


