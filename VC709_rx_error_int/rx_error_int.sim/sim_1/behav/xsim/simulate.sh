#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Fri Dec 04 20:52:01 -03 2020
# SW Build 2902540 on Wed May 27 19:54:35 MDT 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim rx_sim_top_behav -key {Behavioral:sim_1:Functional:rx_sim_top} -tclbatch rx_sim_top.tcl -view /home/daphnelme/Desktop/GTH_RX_SIM_Folder_diego/GTH_Error_test/GTH_Automatic/rx_sim_top_behav.wcfg -log simulate.log"
xsim rx_sim_top_behav -key {Behavioral:sim_1:Functional:rx_sim_top} -tclbatch rx_sim_top.tcl -view /home/daphnelme/Desktop/GTH_RX_SIM_Folder_diego/GTH_Error_test/GTH_Automatic/rx_sim_top_behav.wcfg -log simulate.log

