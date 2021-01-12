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
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0_common_reset.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/support/gtwizard_0_clock_module.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0_common.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0_gt_usrclk_source.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0_support.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_sync_pulse.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_tx_manual_phase_align.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_auto_phase_align.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_tx_startup_fsm.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_rx_startup_fsm.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0_init.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0_gt.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0_multi_gt.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_gtrxreset_seq.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_rxpmarst_seq.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_rxrate_seq.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0/example_design/gtwizard_0_sync_block.v" \
"../../../../GTH_RX_VC709.srcs/sources_1/ip/gtwizard_0_1/gtwizard_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

