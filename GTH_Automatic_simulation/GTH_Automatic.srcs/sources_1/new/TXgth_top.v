`timescale 1ns / 1ps
`define DLY #1
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2020 04:38:30 PM
// Design Name: 
// Module Name: TXgth_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

(* DowngradeIPIdentifiedWarnings="yes" *)
//***********************************Entity Declaration************************
(* CORE_GENERATION_INFO = "gtwizard_0,gtwizard_v3_6_11,{protocol_file=Start_from_scratch}" *)
module TXgth_top #
(
    parameter EXAMPLE_CONFIG_INDEPENDENT_LANES     =   1,//configuration for frame gen and check
    parameter EXAMPLE_LANE_WITH_START_CHAR         =   0,         // specifies lane with unique start frame char
    parameter EXAMPLE_WORDS_IN_BRAM                =   512,       // specifies amount of data in BRAM
    parameter EXAMPLE_SIM_GTRESET_SPEEDUP          =   "TRUE",    // simulation setting for GT SecureIP model
    parameter EXAMPLE_USE_CHIPSCOPE                =   0,         // Set to 1 to use Chipscope to drive resets
    parameter STABLE_CLOCK_PERIOD                  = 16

)
(
    input wire  Q3_CLK1_GTREFCLK_PAD_N_IN,
    input wire  Q3_CLK1_GTREFCLK_PAD_P_IN,
    input wire  DRP_CLK_IN1,
    //input wire  DRP_CLK_IN_N,
    input wire [31:0] DATA,
    input wire tx_k,
    input wire  GTTX_RESET_IN,
    input wire lock,
    input wire  GTRX_RESET_IN,
    input wire  CPLL_RESET_IN,
    input wire  QPLL_RESET_IN,
    output wire         TXN_OUT,
    output wire         TXP_OUT,
    output wire txclk,
    output wire txinit
);

    wire soft_reset_i;
    wire soft_reset_vio_i;
  //  wire lock;
//************************** Register Declarations ****************************
    wire            gt_txfsmresetdone_i;
    wire            gt_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt_txfsmresetdone_r2;
    wire            gt0_txfsmresetdone_i;
    wire            gt0_rxfsmresetdone_i;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r;
    (* ASYNC_REG = "TRUE" *)reg             gt0_txfsmresetdone_r2;


//**************************** Wire Declarations ******************************//
    //------------------------ GT Wrapper Wires ------------------------------
    //________________________________________________________________________
    //________________________________________________________________________
    //GT0  (X1Y13)
    //-------------------------- Channel - DRP Ports  --------------------------
    wire    [8:0]   gt0_drpaddr_i;
    wire    [15:0]  gt0_drpdi_i;
    wire    [15:0]  gt0_drpdo_i;
    wire            gt0_drpen_i;
    wire            gt0_drprdy_i;
    wire            gt0_drpwe_i;
    //------------------- RX Initialization and Reset Ports --------------------
    wire            gt0_eyescanreset_i;
    //------------------------ RX Margin Analysis Ports ------------------------
    wire            gt0_eyescandataerror_i;
    wire            gt0_eyescantrigger_i;
    //----------------- Receive Ports - Digital Monitor Ports ------------------
    wire    [14:0]  gt0_dmonitorout_i;
    //------------------- Receive Ports - RX Equalizer Ports -------------------
    wire    [6:0]   gt0_rxmonitorout_i;
    wire    [1:0]   gt0_rxmonitorsel_i;
    //----------- Receive Ports - RX Initialization and Reset Ports ------------
    wire            gt0_gtrxreset_i;
    //------------------- TX Initialization and Reset Ports --------------------
    wire            gt0_gttxreset_i;
    wire            gt0_txuserrdy_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [31:0]  gt0_txdata_i;
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    wire            gt0_gthtxn_i;
    wire            gt0_gthtxp_i;
    //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    wire            gt0_txoutclk_i;
    wire            gt0_txoutclkfabric_i;
    wire            gt0_txoutclkpcs_i;
    //----------- Transmit Ports - TX Initialization and Reset Ports -----------
    wire            gt0_txresetdone_i;
    //--------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    wire    [3:0]   gt0_txcharisk_i;
    
     assign gt0_txcharisk_i[0] = tx_k;
    

    //____________________________COMMON PORTS________________________________
    //-------------------- Common Block  - Ref Clock Ports ---------------------
    wire            gt0_gtrefclk1_common_i;
    //----------------------- Common Block - QPLL Ports ------------------------
    wire            gt0_qplllock_i;
    wire            gt0_qpllrefclklost_i;
    wire            gt0_qpllreset_i;


    //----------------------------- Global Signals -----------------------------

    wire            drpclk_in_i;
    wire            DRPCLK_IN;
    wire            gt0_tx_system_reset_c;
    wire            gt0_rx_system_reset_c;
    wire            tied_to_ground_i;
    wire    [63:0]  tied_to_ground_vec_i;
    wire            tied_to_vcc_i;
    wire    [7:0]   tied_to_vcc_vec_i;
    wire            GTTXRESET_IN;
    wire            GTRXRESET_IN;
    wire            QPLLRESET_IN;

     //--------------------------- User Clocks ---------------------------------
     wire            gt0_txusrclk_i; 
     wire            gt0_txusrclk2_i; 
     wire            gt0_rxusrclk_i; 
     wire            gt0_rxusrclk2_i; 
    wire            gt0_txmmcm_lock_i;
    wire            gt0_txmmcm_reset_i;
 
    //--------------------------- Reference Clocks ----------------------------
    wire            q3_clk1_refclk_i;

    //--------------------- Frame check/gen Module Signals --------------------
    wire            gt0_matchn_i;
    wire    [3:0]   gt0_txcharisk_float_i;
    wire    [15:0]  gt0_txdata_float16_i;
    wire    [31:0]  gt0_txdata_float_i;
    wire            gt0_block_sync_i;
    wire            gt0_track_data_i;
    wire    [7:0]   gt0_error_count_i;
    wire            gt0_frame_check_reset_i;
    wire            gt0_inc_in_i;
    wire            gt0_inc_out_i;
    wire    [19:0]  gt0_unscrambled_data_i;

    wire            reset_on_data_error_i;
    wire            track_data_out_i;

    //--------------------- Chipscope Signals ---------------------------------

    wire    [35:0]  tx_data_vio_control_i;
    wire    [35:0]  rx_data_vio_control_i;
    wire    [35:0]  shared_vio_control_i;
    wire    [35:0]  ila_control_i;
    wire    [35:0]  channel_drp_vio_control_i;
    wire    [35:0]  common_drp_vio_control_i;
    wire    [31:0]  tx_data_vio_async_in_i;
    wire    [31:0]  tx_data_vio_sync_in_i;
    wire    [31:0]  tx_data_vio_async_out_i;
    wire    [31:0]  tx_data_vio_sync_out_i;
    wire    [31:0]  rx_data_vio_async_in_i;
    wire    [31:0]  rx_data_vio_sync_in_i;
    wire    [31:0]  rx_data_vio_async_out_i;
    wire    [31:0]  rx_data_vio_sync_out_i;
    wire    [31:0]  shared_vio_in_i;
    wire    [31:0]  shared_vio_out_i;
    wire    [163:0] ila_in_i;
    wire    [31:0]  channel_drp_vio_async_in_i;
    wire    [31:0]  channel_drp_vio_sync_in_i;
    wire    [31:0]  channel_drp_vio_async_out_i;
    wire    [31:0]  channel_drp_vio_sync_out_i;
    wire    [31:0]  common_drp_vio_async_in_i;
    wire    [31:0]  common_drp_vio_sync_in_i;
    wire    [31:0]  common_drp_vio_async_out_i;
    wire    [31:0]  common_drp_vio_sync_out_i;

    wire    [31:0]  gt0_tx_data_vio_async_in_i;
    wire    [31:0]  gt0_tx_data_vio_sync_in_i;
    wire    [31:0]  gt0_tx_data_vio_async_out_i;
    wire    [31:0]  gt0_tx_data_vio_sync_out_i;
    wire    [31:0]  gt0_rx_data_vio_async_in_i;
    wire    [31:0]  gt0_rx_data_vio_sync_in_i;
    wire    [31:0]  gt0_rx_data_vio_async_out_i;
    wire    [31:0]  gt0_rx_data_vio_sync_out_i;
    wire    [163:0] gt0_ila_in_i;
    wire    [31:0]  gt0_channel_drp_vio_async_in_i;
    wire    [31:0]  gt0_channel_drp_vio_sync_in_i;
    wire    [31:0]  gt0_channel_drp_vio_async_out_i;
    wire    [31:0]  gt0_channel_drp_vio_sync_out_i;
    wire    [31:0]  gt0_common_drp_vio_async_in_i;
    wire    [31:0]  gt0_common_drp_vio_sync_in_i;
    wire    [31:0]  gt0_common_drp_vio_async_out_i;
    wire    [31:0]  gt0_common_drp_vio_sync_out_i;


    wire            gttxreset_i;
    wire            gtrxreset_i;

    wire            user_tx_reset_i;
    wire            user_rx_reset_i;
    wire            tx_vio_clk_i;
    wire            tx_vio_clk_mux_out_i;    
    wire            rx_vio_ila_clk_i;
    wire            rx_vio_ila_clk_mux_out_i;

    wire            qpllreset_i;


  wire [(80 -20) -1:0] zero_vector_rx_80 ;
  wire [(8 -2) -1:0] zero_vector_rx_8 ;
  wire [79:0] gt0_rxdata_ila ;
  wire [1:0]  gt0_rxdatavalid_ila; 
  wire [7:0]  gt0_rxcharisk_ila ;
  wire gt0_txmmcm_lock_ila ;
  wire gt0_rxmmcm_lock_ila ;
  wire gt0_rxresetdone_ila ;
  wire gt0_txresetdone_ila ;

//**************************** Main Body of Code *******************************

    //  Static signal Assigments    
    assign tied_to_ground_i      = 1'b0;
    assign tied_to_ground_vec_i  = 64'h0000000000000000;
    assign tied_to_vcc_i         = 1'b1;
    assign tied_to_vcc_vec_i     = 8'hff;

    assign zero_vector_rx_80 = 0;
    assign zero_vector_rx_8 = 0;

    
assign  q3_clk1_refclk_i                     =  1'b0;

    //***********************************************************************//
    //                                                                       //
    //--------------------------- The GT Wrapper ----------------------------//
    //                                                                       //
    //***********************************************************************//
    
    // Use the instantiation template in the example directory to add the GT wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.
    // While connecting the GT TX/RX Reset ports below, please add a delay of
    // minimum 500ns as mentioned in AR 43482.


    TX_GTH TX_GTH_support_i 
    (
        .soft_reset_tx_in               (!lock),
        .dont_reset_on_data_error_in    (tied_to_vcc_i),
    .q3_clk0_gtrefclk_pad_n_in  (Q3_CLK1_GTREFCLK_PAD_N_IN),
    .q3_clk0_gtrefclk_pad_p_in  (Q3_CLK1_GTREFCLK_PAD_P_IN),
        .gt0_tx_fsm_reset_done_out      (gt0_txfsmresetdone_i),
        .gt0_rx_fsm_reset_done_out      (gt0_rxfsmresetdone_i),
        .gt0_data_valid_in              (tied_to_vcc_i),
 
    .gt0_txusrclk_out(gt0_txusrclk_i),
    .gt0_txusrclk2_out(gt0_txusrclk2_i),


        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT0  (X1Y13)

        //-------------------------- Channel - DRP Ports  --------------------------
        .gt0_drpaddr_in                 (gt0_drpaddr_i),
        .gt0_drpdi_in                   (gt0_drpdi_i),
        .gt0_drpdo_out                  (gt0_drpdo_i),
        .gt0_drpen_in                   (gt0_drpen_i),
        .gt0_drprdy_out                 (gt0_drprdy_i),
        .gt0_drpwe_in                   (gt0_drpwe_i),
        //------------------- RX Initialization and Reset Ports --------------------
        .gt0_eyescanreset_in            (tied_to_ground_i),
        //------------------------ RX Margin Analysis Ports ------------------------
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_i),
        .gt0_eyescantrigger_in          (tied_to_ground_i),
        //----------------- Receive Ports - Digital Monitor Ports ------------------
        .gt0_dmonitorout_out            (gt0_dmonitorout_i),
        //------------------- Receive Ports - RX Equalizer Ports -------------------
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_i),
        .gt0_rxmonitorsel_in            (2'b00),
        //----------- Receive Ports - RX Initialization and Reset Ports ------------
        .gt0_gtrxreset_in               (tied_to_ground_i),
        //------------------- TX Initialization and Reset Ports --------------------
        .gt0_gttxreset_in               (!lock),
        .gt0_txuserrdy_in               (tied_to_vcc_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .gt0_txdata_in                  (DATA),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .gt0_gthtxn_out                 (TXN_OUT),
        .gt0_gthtxp_out                 (TXP_OUT),
        //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_i),
        .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_i),
        //----------- Transmit Ports - TX Initialization and Reset Ports -----------
        .gt0_txresetdone_out            (gt0_txresetdone_i),
        //--------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        .gt0_txcharisk_in               (gt0_txcharisk_i),


    //____________________________COMMON PORTS________________________________
    .gt0_qplllock_out(),
    .gt0_qpllrefclklost_out(),
    .gt0_qplloutclk_out(),
    .gt0_qplloutrefclk_out(),
    .sysclk_in(DRP_CLK_IN1)
    );




    //***********************************************************************//
    //                                                                       //
    //--------------------------- User Module Resets-------------------------//
    //                                                                       //
    //***********************************************************************//
    // All the User Modules i.e. FRAME_GEN, FRAME_CHECK and the sync modules
    // are held in reset till the RESETDONE goes high. 
    // The RESETDONE is registered a couple of times on *USRCLK2 and connected 
    // to the reset of the modules
    

always @(posedge  gt0_txusrclk2_i or negedge gt0_txfsmresetdone_i)
    begin
        if (!gt0_txfsmresetdone_i)
        begin
            gt0_txfsmresetdone_r    <=   `DLY 1'b0;
            gt0_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gt0_txfsmresetdone_r    <=   `DLY gt0_txfsmresetdone_i;
            gt0_txfsmresetdone_r2   <=   `DLY gt0_txfsmresetdone_r;
        end
    end


    assign txinit = gt0_txresetdone_i;
    assign txclk = gt0_txusrclk2_i;

    // assign resets for frame_gen modules
    assign  gt0_tx_system_reset_c = !gt0_txfsmresetdone_r2;

    // assign resets for frame_check modules

//-------------------------------------------------------------

assign gt0_drpaddr_i = 9'd0;
assign gt0_drpdi_i = 16'd0;
assign gt0_drpen_i = 1'b0;
assign gt0_drpwe_i = 1'b0;

assign soft_reset_i = tied_to_ground_i;

endmodule
    

