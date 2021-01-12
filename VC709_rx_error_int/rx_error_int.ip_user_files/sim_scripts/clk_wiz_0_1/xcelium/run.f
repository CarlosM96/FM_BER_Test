-makelib xcelium_lib/xpm -sv \
  "/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../GTH_Automatic.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0_clk_wiz.v" \
  "../../../../GTH_Automatic.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

