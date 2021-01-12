-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2700185 Thu Oct 24 18:46:05 MDT 2019
-- Date        : Tue Oct 27 16:53:58 2020
-- Host        : DiegoArandaPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {C:/Users/Diego/Documents/Fiuna/LME/Link
--               test/AC701/sfp_test_simple/sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_stub.vhdl}
-- Design      : gtwizard_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gtwizard_0 is
  Port ( 
    soft_reset_tx_in : in STD_LOGIC;
    dont_reset_on_data_error_in : in STD_LOGIC;
    q0_clk0_gtrefclk_pad_n_in : in STD_LOGIC;
    q0_clk0_gtrefclk_pad_p_in : in STD_LOGIC;
    gt0_tx_mmcm_lock_out : out STD_LOGIC;
    gt0_tx_fsm_reset_done_out : out STD_LOGIC;
    gt0_rx_fsm_reset_done_out : out STD_LOGIC;
    gt0_data_valid_in : in STD_LOGIC;
    gt0_txusrclk_out : out STD_LOGIC;
    gt0_txusrclk2_out : out STD_LOGIC;
    gt0_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt0_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpen_in : in STD_LOGIC;
    gt0_drprdy_out : out STD_LOGIC;
    gt0_drpwe_in : in STD_LOGIC;
    gt0_eyescanreset_in : in STD_LOGIC;
    gt0_eyescandataerror_out : out STD_LOGIC;
    gt0_eyescantrigger_in : in STD_LOGIC;
    gt0_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt0_gtrxreset_in : in STD_LOGIC;
    gt0_rxlpmreset_in : in STD_LOGIC;
    gt0_gttxreset_in : in STD_LOGIC;
    gt0_txuserrdy_in : in STD_LOGIC;
    gt0_txdata_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt0_txcharisk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_gtptxn_out : out STD_LOGIC;
    gt0_gtptxp_out : out STD_LOGIC;
    gt0_txoutclkfabric_out : out STD_LOGIC;
    gt0_txoutclkpcs_out : out STD_LOGIC;
    gt0_txresetdone_out : out STD_LOGIC;
    gt0_pll0outclk_out : out STD_LOGIC;
    gt0_pll0outrefclk_out : out STD_LOGIC;
    gt0_pll0lock_out : out STD_LOGIC;
    gt0_pll0refclklost_out : out STD_LOGIC;
    gt0_pll1outclk_out : out STD_LOGIC;
    gt0_pll1outrefclk_out : out STD_LOGIC;
    sysclk_in : in STD_LOGIC
  );

end gtwizard_0;

architecture stub of gtwizard_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "soft_reset_tx_in,dont_reset_on_data_error_in,q0_clk0_gtrefclk_pad_n_in,q0_clk0_gtrefclk_pad_p_in,gt0_tx_mmcm_lock_out,gt0_tx_fsm_reset_done_out,gt0_rx_fsm_reset_done_out,gt0_data_valid_in,gt0_txusrclk_out,gt0_txusrclk2_out,gt0_drpaddr_in[8:0],gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_eyescanreset_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_dmonitorout_out[14:0],gt0_gtrxreset_in,gt0_rxlpmreset_in,gt0_gttxreset_in,gt0_txuserrdy_in,gt0_txdata_in[31:0],gt0_txcharisk_in[3:0],gt0_gtptxn_out,gt0_gtptxp_out,gt0_txoutclkfabric_out,gt0_txoutclkpcs_out,gt0_txresetdone_out,gt0_pll0outclk_out,gt0_pll0outrefclk_out,gt0_pll0lock_out,gt0_pll0refclklost_out,gt0_pll1outclk_out,gt0_pll1outrefclk_out,sysclk_in";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "gtwizard_0,gtwizard_v3_6_11,{protocol_file=Start_from_scratch}";
begin
end;
