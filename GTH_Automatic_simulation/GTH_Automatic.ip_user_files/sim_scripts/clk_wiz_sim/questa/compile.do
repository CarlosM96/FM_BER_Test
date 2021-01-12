vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -sv "+incdir+../../../ipstatic" \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/clk_wiz_sim/clk_wiz_sim_clk_wiz.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/clk_wiz_sim/clk_wiz_sim.v" \

vlog -work xil_defaultlib \
"glbl.v"

