`timescale 1ns / 1ps
//`define DLY #100
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 03:06:06 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top
  
   (
    input wire clk_p,
	input wire clk_n,
	input wire USER_CLK_P,
	input wire USER_CLK_N,
	output wire clk_si5324_240_out_p,
	output wire clk_si5324_240_out_n,
	input wire rx_p,
	input wire rx_n,
	input wire transerial,
	input wire we,
	output wire txp,
	output wire txn,
	output wire rxinit,
	output wire txinit,
	output wire commadet,
	output wire data_serial2,
	inout wire         SDA,
	inout wire         SCL,
	output wire        si5324_resetn,
	output wire        i2cmux_rst
    );


	 
	 wire [10:0] addr;
	 wire [31:0] rx_data_, data, data_fifo; 
	 wire ion, iop;
	 wire dataserialout, data_s;
	 wire clk_in150, clk_in400, clk_buff;
	 wire gtx0_txoutclk_i, gtx0_txusrclk_i, gtx0_txusrclk2_i, txoutclk_mmcm0_locked_i;
	 wire txoutclk_mmcm0_reset_i, tx_pll_lock, tx_reset_done;
	 wire gtx0_rxoutclk_i, gtx0_rxusrclk_i, gtx0_rxusrclk2_i, rxoutclk_mmcm0_locked_i;
	 wire rxoutclk_mmcm0_reset_i, rx_pll_lock;
	 wire txoutclk, rxoutclk;
	 wire [1:0] datatype;
	 wire [31:0] datain;
	 wire wereg;
	 wire txk;
	 wire tx_int, rx_init, lock1, lock2, TXlock, RXlock, act;
	 wire gtx0_txusrclk2_o;
	 wire [39:0] din, dout, data_al;
	 wire aligned, correction_done, comaddet_i;
	 reg reset;
	wire clk_240_w;
    wire locked_240_w;
    wire clk40_w;
    wire clk300_w;



wire drpclk_in_i;
wire lock;



//#### MODULES FOR SIMULATION #####///

TXgth_top TXgth_top 
    (
    .Q3_CLK1_GTREFCLK_PAD_N_IN(clk_n),
    .Q3_CLK1_GTREFCLK_PAD_P_IN(clk_p),
    .DRP_CLK_IN1(clk40_w),
    .lock(locked_240_w),
    .GTTX_RESET_IN(1'b0),
    .GTRX_RESET_IN(1'b0),
    .CPLL_RESET_IN(1'b0),
    .QPLL_RESET_IN(1'b0),
    .TXN_OUT(ion),
    .TXP_OUT(iop),
    .txinit(tx_reset_done),
    .DATA(data),
    .txclk(gtx0_txusrclk2_o),
    .tx_k(txk)
    );


wire [3:0] ka;


top_logic_n_packs top_logic_n_packs(
	//.link_ready    (rx_reset_done),
	.we            (we),
	//.led0          (led0),
	//.led2          (led2),
	//.led3          (led3),
	.reset         (!tx_reset_done),
	.tx_clk        (gtx0_txusrclk2_o),
	.txinit_done   (tx_reset_done),
	.tx_data       (data),
	.tx_k          (txk)
	);

rx_fullsuma_error_top rx_fullsuma_error_top(
    .rx_data(data_fifo),
	.rx_clk(gt0_rxusrclk2_out),
	.reset(~rx_reset_done),
	.trans_en(1'b1),
	.tx_serial(data_s),
	.aligned(1'b1),
	.rx_k(ka)
);

wire [7:0] Din_w;
wire [7:0] Dout_w;
wire ack_in_w;
wire ack_out_w;

wire clk_w;
wire cmd_ack_w;
wire ena_w;
wire nReset_w;
wire read_w;
wire start_w;
wire stop_w;
wire write_w;
si5324_init si5324_init(
    .Din      (Din_w),
    .Dout     (Dout_w),
    .LOL_READ (),
    .LOS_READ (),
    .RST      (!locked_240_w),
    .ack_in   (ack_in_w),
    .ack_out  (ack_out_w),
    .clk      (clk_w),
    .clk40    (clk40_w),
    .cmd_ack  (cmd_ack_w),
    .ena      (ena_w),
    .nReset   (nReset_w),
    .read     (read_w),
    .start    (start_w),
    .stop     (stop_w),
    .write    (write_w)
);

simple_i2c simple_i2c (
	    .clk       (clk_w),
		.ena       (ena_w),
		.nReset    (nReset_w),
		.clk_cnt   (8'b11111111), 
		.start     (start_w),
		.stop      (stop_w),
		.read       (read_w),
		.write      (write_w),
		.ack_in     (ack_in_w),
		.Din        (Din_w),
		.cmd_ack    (cmd_ack_w),
		.ack_out    (ack_out_w),
		.Dout       (Dout_w),
		//i2c signals
		.SCL         (SCL),
		.SDA         (SDA)
);



clk_wiz_0 clk_wiz_0 (
  // Clock out ports
  .clk_240      (clk_240_w),
  .clk_40       (clk40_w),

  // Status and control signals
  .reset        (1'b0),
  .locked       (locked_240_w),
 // Clock in ports
  .clk_in1_p   (USER_CLK_P),
  .clk_in1_n   (USER_CLK_N)
  
);

OBUFDS OBUFDS(
   .I       (clk_240_w),
   .O       (clk_si5324_240_out_p),
   .OB      (clk_si5324_240_out_n)
);


RX_TOP RX_TOP(
    .Q3_CLK0_GTREFCLK_PAD_N_IN(clk_n),
    .Q3_CLK0_GTREFCLK_PAD_P_IN(clk_p),
    .DRP_CLK_IN1(clk40_w),
    .lock(locked_240_w),
   // input wire  DRP_CLK_IN_P,
   // input wire  DRP_CLK_IN_N,
    
    .RX_DATA_OUT(data_fifo),
    .RXN_IN(rx_n),
    .RXP_IN(rx_p),
    .RXUSR_CLK(gt0_rxusrclk2_out),
    .RX_initDone(rx_reset_done),
    .commadet(commadet_i),
    .k_out(ka)
    );
	

	assign data_serial2 = data_s;
	assign commadet = commadet_i;
	assign rxinit = rx_reset_done;
	assign si5324_resetn = !( 1'b0 | !locked_240_w);
    assign i2cmux_rst = !( 1'b0  | !locked_240_w);
	assign txp = iop;
	assign txn = ion;
    assign txinit = tx_reset_done;
	
	

endmodule

