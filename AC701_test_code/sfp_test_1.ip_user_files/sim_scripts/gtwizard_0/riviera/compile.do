vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 \
"C:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_common_reset.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0/example_design/support/gtwizard_0_clock_module.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_common.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_gt_usrclk_source.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_support.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_cpll_railing.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0/example_design/gtwizard_0_tx_startup_fsm.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0/example_design/gtwizard_0_rx_startup_fsm.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_init.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_gt.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0_multi_gt.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0/example_design/gtwizard_0_sync_block.v" \
"../../../../sfp_test_simple.srcs/sources_1/ip/gtwizard_0/gtwizard_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

