vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"/home/daphnelme/Xilinx/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
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

