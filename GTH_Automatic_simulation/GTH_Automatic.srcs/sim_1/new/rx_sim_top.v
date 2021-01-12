`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 03:50:36 PM
// Design Name: 
// Module Name: rx_sim_top
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


module rx_sim_top();
    reg clk_p;
	reg clk_n;
	reg USER_CLK_P;
	reg USER_CLK_N;
	//reg reset;
	wire txn;
	wire txp;
	wire rx_n;
	wire rx_p;
	reg transerial;
	//reg tx_ready;
	wire data_serial2;
	reg we;
	initial we = 0;
	//reg link_ready;
	reg link_clk;
	wire rxinit;
	wire txinit;
	

	top top1(
    .clk_p(clk_p), 
    .clk_n(clk_n),
    .USER_CLK_P(USER_CLK_P), 
    .USER_CLK_N(USER_CLK_N),
    //.reset(reset), 
	.rx_n(rx_n), 
    .rx_p(rx_p), 
    .rxinit(rxinit),
    
    //.tx_n(tx_n), 
    //.tx_p(tx_p),
	 .transerial(transerial),
	 .we(we),
	 //.link_ready(link_ready),
	 .data_serial2(data_serial2),
	 .txp(txp),
	 .txn(txn),
	 .txinit(txinit)
    );


	
	initial begin 
		clk_p = 1'b1;
	end

	always begin 
		clk_p = !clk_p; #2.083;
		assign clk_n = !clk_p;
	end
	
	initial begin 
		USER_CLK_P = 1'b1;
	end

	always begin 
		USER_CLK_P = !USER_CLK_P; #(3.6);
		assign USER_CLK_N = !USER_CLK_P;
	end
	
//	initial begin 
//		link_clk = 1'b1;
//	end

//	always begin 
//		link_clk = !link_clk; #(0.104);
//	end
	
	assign rx_p = txp;
	assign rx_n = txn;
	
//	reg [31:0] vector = 32'b00000000000000000000000010111100;
//	reg [4:0] val = 5'b00000;
	
	
	
	initial begin 
	#400000;
	
		we = 1; #90;
	    we = 0;
	    transerial = 0;  #1200;
		transerial = 1; 
	end
	
//	always @ (posedge link_clk) begin
//	  if(rxinit) begin
//	       rx_p = vector[val];
//	       rx_n = !rx_p;
//	       val = val+1; 
//	  end
//	end
	
	
	
endmodule 
