-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Wed Dec  2 13:26:42 2020
-- Host        : localhost.localdomain running 64-bit Scientific Linux release 7.7 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/daphnelme/Desktop/GTH_RX_SIM_Folder_diego/GTH_Error_test/GTH_Automatic/GTH_Automatic.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0_stub.vhdl
-- Design      : clk_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_0 is
  Port ( 
    clk_240 : out STD_LOGIC;
    clk_40 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );

end clk_wiz_0;

architecture stub of clk_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_240,clk_40,reset,locked,clk_in1_p,clk_in1_n";
begin
end;
