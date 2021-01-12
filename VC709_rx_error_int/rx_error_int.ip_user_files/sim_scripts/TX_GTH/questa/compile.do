vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -sv \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth_common_reset.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/TX_GTH/example_design/support/tx_gth_clock_module.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth_common.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth_gt_usrclk_source.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth_support.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/TX_GTH/example_design/tx_gth_sync_pulse.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/TX_GTH/example_design/tx_gth_tx_manual_phase_align.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/TX_GTH/example_design/tx_gth_tx_startup_fsm.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/TX_GTH/example_design/tx_gth_rx_startup_fsm.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth_init.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth_gt.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth_multi_gt.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/TX_GTH/example_design/tx_gth_sync_block.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/TX_GTH/tx_gth.v" \

vlog -work xil_defaultlib \
"glbl.v"

