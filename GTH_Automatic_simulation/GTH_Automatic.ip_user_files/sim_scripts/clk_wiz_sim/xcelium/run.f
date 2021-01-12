-makelib xcelium_lib/xpm -sv \
  "/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../GTH_RX_VC709.srcs/sources_1/ip/clk_wiz_sim/clk_wiz_sim_clk_wiz.v" \
  "../../../../GTH_RX_VC709.srcs/sources_1/ip/clk_wiz_sim/clk_wiz_sim.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

