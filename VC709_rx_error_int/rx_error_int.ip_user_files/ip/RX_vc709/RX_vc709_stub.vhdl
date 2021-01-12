-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Wed Dec  9 15:05:06 2020
-- Host        : localhost.localdomain running 64-bit Scientific Linux release 7.7 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/daphnelme/Desktop/GTH_RX_SIM_Folder_diego/RX_error_int/rx_error_int/rx_error_int.srcs/sources_1/ip/RX_vc709/RX_vc709_stub.vhdl
-- Design      : RX_vc709
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RX_vc709 is
  Port ( 
    soft_reset_rx_in : in STD_LOGIC;
    dont_reset_on_data_error_in : in STD_LOGIC;
    q3_clk0_gtrefclk_pad_n_in : in STD_LOGIC;
    q3_clk0_gtrefclk_pad_p_in : in STD_LOGIC;
    gt0_rx_mmcm_lock_out : out STD_LOGIC;
    gt0_tx_fsm_reset_done_out : out STD_LOGIC;
    gt0_rx_fsm_reset_done_out : out STD_LOGIC;
    gt0_data_valid_in : in STD_LOGIC;
    gt0_rxusrclk_out : out STD_LOGIC;
    gt0_rxusrclk2_out : out STD_LOGIC;
    gt0_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt0_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpen_in : in STD_LOGIC;
    gt0_drprdy_out : out STD_LOGIC;
    gt0_drpwe_in : in STD_LOGIC;
    gt0_eyescanreset_in : in STD_LOGIC;
    gt0_rxuserrdy_in : in STD_LOGIC;
    gt0_eyescandataerror_out : out STD_LOGIC;
    gt0_eyescantrigger_in : in STD_LOGIC;
    gt0_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt0_rxdata_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt0_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_gthrxn_in : in STD_LOGIC;
    gt0_rxphmonitor_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    gt0_rxphslipmonitor_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    gt0_rxbyteisaligned_out : out STD_LOGIC;
    gt0_rxcommadet_out : out STD_LOGIC;
    gt0_rxmcommaalignen_in : in STD_LOGIC;
    gt0_rxpcommaalignen_in : in STD_LOGIC;
    gt0_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt0_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxoutclkfabric_out : out STD_LOGIC;
    gt0_gtrxreset_in : in STD_LOGIC;
    gt0_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_gthrxp_in : in STD_LOGIC;
    gt0_rxresetdone_out : out STD_LOGIC;
    gt0_gttxreset_in : in STD_LOGIC;
    gt0_qplllock_out : out STD_LOGIC;
    gt0_qpllrefclklost_out : out STD_LOGIC;
    gt0_qpllreset_out : out STD_LOGIC;
    gt0_qplloutclk_out : out STD_LOGIC;
    gt0_qplloutrefclk_out : out STD_LOGIC;
    sysclk_in : in STD_LOGIC
  );

end RX_vc709;

architecture stub of RX_vc709 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "soft_reset_rx_in,dont_reset_on_data_error_in,q3_clk0_gtrefclk_pad_n_in,q3_clk0_gtrefclk_pad_p_in,gt0_rx_mmcm_lock_out,gt0_tx_fsm_reset_done_out,gt0_rx_fsm_reset_done_out,gt0_data_valid_in,gt0_rxusrclk_out,gt0_rxusrclk2_out,gt0_drpaddr_in[8:0],gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_eyescanreset_in,gt0_rxuserrdy_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_dmonitorout_out[14:0],gt0_rxdata_out[31:0],gt0_rxdisperr_out[3:0],gt0_rxnotintable_out[3:0],gt0_gthrxn_in,gt0_rxphmonitor_out[4:0],gt0_rxphslipmonitor_out[4:0],gt0_rxbyteisaligned_out,gt0_rxcommadet_out,gt0_rxmcommaalignen_in,gt0_rxpcommaalignen_in,gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_rxoutclkfabric_out,gt0_gtrxreset_in,gt0_rxcharisk_out[3:0],gt0_gthrxp_in,gt0_rxresetdone_out,gt0_gttxreset_in,gt0_qplllock_out,gt0_qpllrefclklost_out,gt0_qpllreset_out,gt0_qplloutclk_out,gt0_qplloutrefclk_out,sysclk_in";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "RX_vc709,gtwizard_v3_6_11,{protocol_file=Start_from_scratch}";
begin
end;
