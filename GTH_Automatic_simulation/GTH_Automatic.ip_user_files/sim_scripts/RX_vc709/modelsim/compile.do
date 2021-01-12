vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -sv \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709_common_reset.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/support/rx_vc709_clock_module.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709_common.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709_gt_usrclk_source.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709_support.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/rx_vc709_auto_phase_align.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/rx_vc709_tx_startup_fsm.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/rx_vc709_rx_startup_fsm.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709_init.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709_gt.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709_multi_gt.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/rx_vc709_gtrxreset_seq.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/rx_vc709_rxpmarst_seq.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/rx_vc709_rxrate_seq.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/RX_vc709/example_design/rx_vc709_sync_block.v" \
"../../../../GTH_Automatic.srcs/sources_1/ip/RX_vc709/rx_vc709.v" \

vlog -work xil_defaultlib \
"glbl.v"

