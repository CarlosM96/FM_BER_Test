/* Machine-generated using Migen */
module rx_fullsuma_error_top(
	input [31:0] rx_data,
	input rx_clk,
	input reset,
	input trans_en,
	output reg tx_serial,
	output reg led_3c,
	input aligned,
	input [3:0] rx_k
);

wire rx_clk_1;
wire rx_rst;
reg [7:0] total_error = 8'd0;
reg [10:0] tx_counter = 11'd0;
reg tx_serial1 = 1'd1;
reg [7:0] tx_data = 8'd0;
wire tx_strobe;
reg [2:0] tx_bitn = 3'd0;
reg tx_ready = 1'd0;
reg [7:0] tx_latch = 8'd0;
reg tx_done = 1'd0;
wire [31:0] rx_data1;
reg [4:0] error = 5'd0;
reg enable0 = 1'd0;
reg reset1 = 1'd0;
wire k0;
reg [31:0] o = 32'd0;
wire enable1;
reg [6:0] state = 7'd1;
wire [31:0] i_data_payload;
reg i_data_strobe = 1'd0;
wire [19:0] o_crc;
reg reset2 = 1'd0;
wire [31:0] crc_dat;
reg [19:0] crc_cur = 20'd1048575;
reg [19:0] crc_next;
reg [31:0] data_r = 32'd0;
reg [31:0] error_xor;
reg k0_r = 1'd0;
reg [31:0] rx_data_r = 32'd0;
reg sop = 1'd0;
reg eop = 1'd0;
reg [15:0] wait_1 = 16'd0;
reg error_send_done = 1'd0;
reg aux = 1'd0;
reg [1:0] clockdomainsrenamer0_state = 2'd0;
reg [1:0] clockdomainsrenamer0_next_state;
reg [7:0] tx_latch_clockdomainsrenamer0_t_next_value0;
reg tx_latch_clockdomainsrenamer0_t_next_value_ce0;
reg [10:0] tx_counter_clockdomainsrenamer0_t_next_value1;
reg tx_counter_clockdomainsrenamer0_t_next_value_ce1;
reg tx_serial1_clockdomainsrenamer0_f_next_value;
reg tx_serial1_clockdomainsrenamer0_f_next_value_ce;
reg [2:0] tx_bitn_clockdomainsrenamer0_t_next_value2;
reg tx_bitn_clockdomainsrenamer0_t_next_value_ce2;
reg tx_done_clockdomainsrenamer0_t_next_value3;
reg tx_done_clockdomainsrenamer0_t_next_value_ce3;
reg [1:0] clockdomainsrenamer1_state = 2'd0;
reg [1:0] clockdomainsrenamer1_next_state;
reg i_data_strobe_clockdomainsrenamer1_next_value;
reg i_data_strobe_clockdomainsrenamer1_next_value_ce;
reg [2:0] clockdomainsrenamer2_state = 3'd0;
reg [2:0] clockdomainsrenamer2_next_state;
reg enable0_clockdomainsrenamer2_t_next_value0;
reg enable0_clockdomainsrenamer2_t_next_value_ce0;
reg sop_clockdomainsrenamer2_t_next_value1;
reg sop_clockdomainsrenamer2_t_next_value_ce1;
reg [7:0] total_error_clockdomainsrenamer2_next_value0;
reg total_error_clockdomainsrenamer2_next_value_ce0;
reg aux_clockdomainsrenamer2_next_value1;
reg aux_clockdomainsrenamer2_next_value_ce1;
reg [15:0] wait_clockdomainsrenamer2_next_value2;
reg wait_clockdomainsrenamer2_next_value_ce2;
reg eop_clockdomainsrenamer2_f_next_value;
reg eop_clockdomainsrenamer2_f_next_value_ce;
reg [1:0] clockdomainsrenamer3_state = 2'd0;
reg [1:0] clockdomainsrenamer3_next_state;
reg error_send_done_clockdomainsrenamer3_next_value0;
reg error_send_done_clockdomainsrenamer3_next_value_ce0;
reg [7:0] tx_data_clockdomainsrenamer3_next_value1;
reg tx_data_clockdomainsrenamer3_next_value_ce1;
reg tx_ready_clockdomainsrenamer3_next_value2;
reg tx_ready_clockdomainsrenamer3_next_value_ce2;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign rx_rst = reset;
assign rx_clk_1 = rx_clk;
assign rx_data1 = rx_data;
assign k0 = rx_k[0];

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	tx_serial <= 1'd0;
	tx_serial <= tx_serial1;
	tx_serial <= tx_serial1;
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign tx_strobe = (tx_counter == 1'd0);

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	clockdomainsrenamer0_next_state <= 2'd0;
	tx_latch_clockdomainsrenamer0_t_next_value0 <= 8'd0;
	tx_latch_clockdomainsrenamer0_t_next_value_ce0 <= 1'd0;
	tx_counter_clockdomainsrenamer0_t_next_value1 <= 11'd0;
	tx_counter_clockdomainsrenamer0_t_next_value_ce1 <= 1'd0;
	tx_serial1_clockdomainsrenamer0_f_next_value <= 1'd0;
	tx_serial1_clockdomainsrenamer0_f_next_value_ce <= 1'd0;
	tx_bitn_clockdomainsrenamer0_t_next_value2 <= 3'd0;
	tx_bitn_clockdomainsrenamer0_t_next_value_ce2 <= 1'd0;
	tx_done_clockdomainsrenamer0_t_next_value3 <= 1'd0;
	tx_done_clockdomainsrenamer0_t_next_value_ce3 <= 1'd0;
	clockdomainsrenamer0_next_state <= clockdomainsrenamer0_state;
	case (clockdomainsrenamer0_state)
		1'd1: begin
			if (tx_strobe) begin
				tx_serial1_clockdomainsrenamer0_f_next_value <= 1'd0;
				tx_serial1_clockdomainsrenamer0_f_next_value_ce <= 1'd1;
				clockdomainsrenamer0_next_state <= 2'd2;
			end
		end
		2'd2: begin
			if (tx_strobe) begin
				tx_serial1_clockdomainsrenamer0_f_next_value <= tx_latch[0];
				tx_serial1_clockdomainsrenamer0_f_next_value_ce <= 1'd1;
				tx_latch_clockdomainsrenamer0_t_next_value0 <= {1'd0, tx_latch[7:1]};
				tx_latch_clockdomainsrenamer0_t_next_value_ce0 <= 1'd1;
				tx_bitn_clockdomainsrenamer0_t_next_value2 <= (tx_bitn + 1'd1);
				tx_bitn_clockdomainsrenamer0_t_next_value_ce2 <= 1'd1;
				if ((tx_bitn == 3'd7)) begin
					clockdomainsrenamer0_next_state <= 2'd3;
					tx_bitn_clockdomainsrenamer0_t_next_value2 <= 1'd0;
					tx_bitn_clockdomainsrenamer0_t_next_value_ce2 <= 1'd1;
					tx_done_clockdomainsrenamer0_t_next_value3 <= 1'd1;
					tx_done_clockdomainsrenamer0_t_next_value_ce3 <= 1'd1;
				end
			end
		end
		2'd3: begin
			if (tx_strobe) begin
				tx_serial1_clockdomainsrenamer0_f_next_value <= 1'd1;
				tx_serial1_clockdomainsrenamer0_f_next_value_ce <= 1'd1;
				tx_done_clockdomainsrenamer0_t_next_value3 <= 1'd0;
				tx_done_clockdomainsrenamer0_t_next_value_ce3 <= 1'd1;
				clockdomainsrenamer0_next_state <= 1'd0;
			end
		end
		default: begin
			if (tx_ready) begin
				tx_latch_clockdomainsrenamer0_t_next_value0 <= tx_data;
				tx_latch_clockdomainsrenamer0_t_next_value_ce0 <= 1'd1;
				tx_counter_clockdomainsrenamer0_t_next_value1 <= 11'd1040;
				tx_counter_clockdomainsrenamer0_t_next_value_ce1 <= 1'd1;
				clockdomainsrenamer0_next_state <= 1'd1;
			end else begin
				tx_serial1_clockdomainsrenamer0_f_next_value <= 1'd1;
				tx_serial1_clockdomainsrenamer0_f_next_value_ce <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign enable1 = enable0;
assign i_data_payload = data_r;
assign crc_dat = i_data_payload;
assign o_crc = crc_cur;

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	crc_next <= 20'd151419;
	crc_next[0] <= ((((((((((((((((((((((((((((crc_dat[0] ^ crc_dat[1]) ^ crc_dat[3]) ^ crc_dat[4]) ^ crc_dat[6]) ^ crc_dat[7]) ^ crc_dat[8]) ^ crc_dat[12]) ^ crc_dat[13]) ^ crc_dat[15]) ^ crc_dat[21]) ^ crc_dat[22]) ^ crc_dat[23]) ^ crc_dat[24]) ^ crc_dat[26]) ^ crc_dat[28]) ^ crc_dat[30]) ^ crc_dat[31]) ^ crc_cur[0]) ^ crc_cur[1]) ^ crc_cur[3]) ^ crc_cur[9]) ^ crc_cur[10]) ^ crc_cur[11]) ^ crc_cur[12]) ^ crc_cur[14]) ^ crc_cur[16]) ^ crc_cur[18]) ^ crc_cur[19]);
	crc_next[1] <= (((((((((((((((((((((((((((crc_dat[0] ^ crc_dat[2]) ^ crc_dat[3]) ^ crc_dat[5]) ^ crc_dat[6]) ^ crc_dat[9]) ^ crc_dat[12]) ^ crc_dat[14]) ^ crc_dat[15]) ^ crc_dat[16]) ^ crc_dat[21]) ^ crc_dat[25]) ^ crc_dat[26]) ^ crc_dat[27]) ^ crc_dat[28]) ^ crc_dat[29]) ^ crc_dat[30]) ^ crc_cur[0]) ^ crc_cur[2]) ^ crc_cur[3]) ^ crc_cur[4]) ^ crc_cur[9]) ^ crc_cur[13]) ^ crc_cur[14]) ^ crc_cur[15]) ^ crc_cur[16]) ^ crc_cur[17]) ^ crc_cur[18]);
	crc_next[2] <= ((((((((((((((((((crc_dat[0] ^ crc_dat[8]) ^ crc_dat[10]) ^ crc_dat[12]) ^ crc_dat[16]) ^ crc_dat[17]) ^ crc_dat[21]) ^ crc_dat[23]) ^ crc_dat[24]) ^ crc_dat[27]) ^ crc_dat[29]) ^ crc_cur[0]) ^ crc_cur[4]) ^ crc_cur[5]) ^ crc_cur[9]) ^ crc_cur[11]) ^ crc_cur[12]) ^ crc_cur[15]) ^ crc_cur[17]);
	crc_next[3] <= (((((((((((((((((((((((((crc_dat[0] ^ crc_dat[3]) ^ crc_dat[4]) ^ crc_dat[6]) ^ crc_dat[7]) ^ crc_dat[8]) ^ crc_dat[9]) ^ crc_dat[11]) ^ crc_dat[12]) ^ crc_dat[15]) ^ crc_dat[17]) ^ crc_dat[18]) ^ crc_dat[21]) ^ crc_dat[23]) ^ crc_dat[25]) ^ crc_dat[26]) ^ crc_dat[31]) ^ crc_cur[0]) ^ crc_cur[3]) ^ crc_cur[5]) ^ crc_cur[6]) ^ crc_cur[9]) ^ crc_cur[11]) ^ crc_cur[13]) ^ crc_cur[14]) ^ crc_cur[19]);
	crc_next[4] <= ((((((((((((((((((((((((crc_dat[1] ^ crc_dat[4]) ^ crc_dat[5]) ^ crc_dat[7]) ^ crc_dat[8]) ^ crc_dat[9]) ^ crc_dat[10]) ^ crc_dat[12]) ^ crc_dat[13]) ^ crc_dat[16]) ^ crc_dat[18]) ^ crc_dat[19]) ^ crc_dat[22]) ^ crc_dat[24]) ^ crc_dat[26]) ^ crc_dat[27]) ^ crc_cur[0]) ^ crc_cur[1]) ^ crc_cur[4]) ^ crc_cur[6]) ^ crc_cur[7]) ^ crc_cur[10]) ^ crc_cur[12]) ^ crc_cur[14]) ^ crc_cur[15]);
	crc_next[5] <= ((((((((((((((((((((((((crc_dat[2] ^ crc_dat[5]) ^ crc_dat[6]) ^ crc_dat[8]) ^ crc_dat[9]) ^ crc_dat[10]) ^ crc_dat[11]) ^ crc_dat[13]) ^ crc_dat[14]) ^ crc_dat[17]) ^ crc_dat[19]) ^ crc_dat[20]) ^ crc_dat[23]) ^ crc_dat[25]) ^ crc_dat[27]) ^ crc_dat[28]) ^ crc_cur[1]) ^ crc_cur[2]) ^ crc_cur[5]) ^ crc_cur[7]) ^ crc_cur[8]) ^ crc_cur[11]) ^ crc_cur[13]) ^ crc_cur[15]) ^ crc_cur[16]);
	crc_next[6] <= ((((((((((((((((((((((((crc_dat[0] ^ crc_dat[1]) ^ crc_dat[4]) ^ crc_dat[8]) ^ crc_dat[9]) ^ crc_dat[10]) ^ crc_dat[11]) ^ crc_dat[13]) ^ crc_dat[14]) ^ crc_dat[18]) ^ crc_dat[20]) ^ crc_dat[22]) ^ crc_dat[23]) ^ crc_dat[29]) ^ crc_dat[30]) ^ crc_dat[31]) ^ crc_cur[1]) ^ crc_cur[2]) ^ crc_cur[6]) ^ crc_cur[8]) ^ crc_cur[10]) ^ crc_cur[11]) ^ crc_cur[17]) ^ crc_cur[18]) ^ crc_cur[19]);
	crc_next[7] <= ((((((((((((((((((((((crc_dat[0] ^ crc_dat[2]) ^ crc_dat[3]) ^ crc_dat[4]) ^ crc_dat[5]) ^ crc_dat[6]) ^ crc_dat[7]) ^ crc_dat[8]) ^ crc_dat[9]) ^ crc_dat[10]) ^ crc_dat[11]) ^ crc_dat[13]) ^ crc_dat[14]) ^ crc_dat[19]) ^ crc_dat[22]) ^ crc_dat[26]) ^ crc_dat[28]) ^ crc_cur[1]) ^ crc_cur[2]) ^ crc_cur[7]) ^ crc_cur[10]) ^ crc_cur[14]) ^ crc_cur[16]);
	crc_next[8] <= (((((((((((((((((((((((crc_dat[1] ^ crc_dat[3]) ^ crc_dat[4]) ^ crc_dat[5]) ^ crc_dat[6]) ^ crc_dat[7]) ^ crc_dat[8]) ^ crc_dat[9]) ^ crc_dat[10]) ^ crc_dat[11]) ^ crc_dat[12]) ^ crc_dat[14]) ^ crc_dat[15]) ^ crc_dat[20]) ^ crc_dat[23]) ^ crc_dat[27]) ^ crc_dat[29]) ^ crc_cur[0]) ^ crc_cur[2]) ^ crc_cur[3]) ^ crc_cur[8]) ^ crc_cur[11]) ^ crc_cur[15]) ^ crc_cur[17]);
	crc_next[9] <= (((((((((((((((((crc_dat[0] ^ crc_dat[1]) ^ crc_dat[2]) ^ crc_dat[3]) ^ crc_dat[5]) ^ crc_dat[9]) ^ crc_dat[10]) ^ crc_dat[11]) ^ crc_dat[16]) ^ crc_dat[22]) ^ crc_dat[23]) ^ crc_dat[26]) ^ crc_dat[31]) ^ crc_cur[4]) ^ crc_cur[10]) ^ crc_cur[11]) ^ crc_cur[14]) ^ crc_cur[19]);
	crc_next[10] <= ((((((((((((((((crc_dat[1] ^ crc_dat[2]) ^ crc_dat[3]) ^ crc_dat[4]) ^ crc_dat[6]) ^ crc_dat[10]) ^ crc_dat[11]) ^ crc_dat[12]) ^ crc_dat[17]) ^ crc_dat[23]) ^ crc_dat[24]) ^ crc_dat[27]) ^ crc_cur[0]) ^ crc_cur[5]) ^ crc_cur[11]) ^ crc_cur[12]) ^ crc_cur[15]);
	crc_next[11] <= ((((((((((((((((((((((((crc_dat[0] ^ crc_dat[1]) ^ crc_dat[2]) ^ crc_dat[5]) ^ crc_dat[6]) ^ crc_dat[8]) ^ crc_dat[11]) ^ crc_dat[15]) ^ crc_dat[18]) ^ crc_dat[21]) ^ crc_dat[22]) ^ crc_dat[23]) ^ crc_dat[25]) ^ crc_dat[26]) ^ crc_dat[30]) ^ crc_dat[31]) ^ crc_cur[3]) ^ crc_cur[6]) ^ crc_cur[9]) ^ crc_cur[10]) ^ crc_cur[11]) ^ crc_cur[13]) ^ crc_cur[14]) ^ crc_cur[18]) ^ crc_cur[19]);
	crc_next[12] <= ((((((((((((((((((((crc_dat[0] ^ crc_dat[2]) ^ crc_dat[4]) ^ crc_dat[8]) ^ crc_dat[9]) ^ crc_dat[13]) ^ crc_dat[15]) ^ crc_dat[16]) ^ crc_dat[19]) ^ crc_dat[21]) ^ crc_dat[27]) ^ crc_dat[28]) ^ crc_dat[30]) ^ crc_cur[1]) ^ crc_cur[3]) ^ crc_cur[4]) ^ crc_cur[7]) ^ crc_cur[9]) ^ crc_cur[15]) ^ crc_cur[16]) ^ crc_cur[18]);
	crc_next[13] <= ((((((((((((((((((((crc_dat[1] ^ crc_dat[3]) ^ crc_dat[5]) ^ crc_dat[9]) ^ crc_dat[10]) ^ crc_dat[14]) ^ crc_dat[16]) ^ crc_dat[17]) ^ crc_dat[20]) ^ crc_dat[22]) ^ crc_dat[28]) ^ crc_dat[29]) ^ crc_dat[31]) ^ crc_cur[2]) ^ crc_cur[4]) ^ crc_cur[5]) ^ crc_cur[8]) ^ crc_cur[10]) ^ crc_cur[16]) ^ crc_cur[17]) ^ crc_cur[19]);
	crc_next[14] <= ((((((((((((((((((crc_dat[2] ^ crc_dat[4]) ^ crc_dat[6]) ^ crc_dat[10]) ^ crc_dat[11]) ^ crc_dat[15]) ^ crc_dat[17]) ^ crc_dat[18]) ^ crc_dat[21]) ^ crc_dat[23]) ^ crc_dat[29]) ^ crc_dat[30]) ^ crc_cur[3]) ^ crc_cur[5]) ^ crc_cur[6]) ^ crc_cur[9]) ^ crc_cur[11]) ^ crc_cur[17]) ^ crc_cur[18]);
	crc_next[15] <= (((((((((((((((((((crc_dat[3] ^ crc_dat[5]) ^ crc_dat[7]) ^ crc_dat[11]) ^ crc_dat[12]) ^ crc_dat[16]) ^ crc_dat[18]) ^ crc_dat[19]) ^ crc_dat[22]) ^ crc_dat[24]) ^ crc_dat[30]) ^ crc_dat[31]) ^ crc_cur[0]) ^ crc_cur[4]) ^ crc_cur[6]) ^ crc_cur[7]) ^ crc_cur[10]) ^ crc_cur[12]) ^ crc_cur[18]) ^ crc_cur[19]);
	crc_next[16] <= ((((((((((((((((((crc_dat[4] ^ crc_dat[6]) ^ crc_dat[8]) ^ crc_dat[12]) ^ crc_dat[13]) ^ crc_dat[17]) ^ crc_dat[19]) ^ crc_dat[20]) ^ crc_dat[23]) ^ crc_dat[25]) ^ crc_dat[31]) ^ crc_cur[0]) ^ crc_cur[1]) ^ crc_cur[5]) ^ crc_cur[7]) ^ crc_cur[8]) ^ crc_cur[11]) ^ crc_cur[13]) ^ crc_cur[19]);
	crc_next[17] <= ((((((((((((((((crc_dat[5] ^ crc_dat[7]) ^ crc_dat[9]) ^ crc_dat[13]) ^ crc_dat[14]) ^ crc_dat[18]) ^ crc_dat[20]) ^ crc_dat[21]) ^ crc_dat[24]) ^ crc_dat[26]) ^ crc_cur[1]) ^ crc_cur[2]) ^ crc_cur[6]) ^ crc_cur[8]) ^ crc_cur[9]) ^ crc_cur[12]) ^ crc_cur[14]);
	crc_next[18] <= (((((((((((((((((((((((((((((crc_dat[0] ^ crc_dat[1]) ^ crc_dat[3]) ^ crc_dat[4]) ^ crc_dat[7]) ^ crc_dat[10]) ^ crc_dat[12]) ^ crc_dat[13]) ^ crc_dat[14]) ^ crc_dat[19]) ^ crc_dat[23]) ^ crc_dat[24]) ^ crc_dat[25]) ^ crc_dat[26]) ^ crc_dat[27]) ^ crc_dat[28]) ^ crc_dat[30]) ^ crc_dat[31]) ^ crc_cur[0]) ^ crc_cur[1]) ^ crc_cur[2]) ^ crc_cur[7]) ^ crc_cur[11]) ^ crc_cur[12]) ^ crc_cur[13]) ^ crc_cur[14]) ^ crc_cur[15]) ^ crc_cur[16]) ^ crc_cur[18]) ^ crc_cur[19]);
	crc_next[19] <= ((((((((((((((((((((((((((crc_dat[0] ^ crc_dat[2]) ^ crc_dat[3]) ^ crc_dat[5]) ^ crc_dat[6]) ^ crc_dat[7]) ^ crc_dat[11]) ^ crc_dat[12]) ^ crc_dat[14]) ^ crc_dat[20]) ^ crc_dat[21]) ^ crc_dat[22]) ^ crc_dat[23]) ^ crc_dat[25]) ^ crc_dat[27]) ^ crc_dat[29]) ^ crc_dat[30]) ^ crc_cur[0]) ^ crc_cur[2]) ^ crc_cur[8]) ^ crc_cur[9]) ^ crc_cur[10]) ^ crc_cur[11]) ^ crc_cur[13]) ^ crc_cur[15]) ^ crc_cur[17]) ^ crc_cur[18]);
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	error_xor <= 32'd0;
	clockdomainsrenamer1_next_state <= 2'd0;
	i_data_strobe_clockdomainsrenamer1_next_value <= 1'd0;
	i_data_strobe_clockdomainsrenamer1_next_value_ce <= 1'd0;
	clockdomainsrenamer1_next_state <= clockdomainsrenamer1_state;
	case (clockdomainsrenamer1_state)
		1'd1: begin
			if (enable0) begin
				clockdomainsrenamer1_next_state <= 2'd2;
				i_data_strobe_clockdomainsrenamer1_next_value <= 1'd1;
				i_data_strobe_clockdomainsrenamer1_next_value_ce <= 1'd1;
			end
		end
		2'd2: begin
			if ((data_r[7:0] != 8'd220)) begin
				error_xor <= (data_r ^ o);
				clockdomainsrenamer1_next_state <= 2'd2;
			end else begin
				if (((data_r[7:0] == 8'd220) & k0_r)) begin
					error_xor <= (o_crc ^ data_r[27:8]);
					i_data_strobe_clockdomainsrenamer1_next_value <= 1'd0;
					i_data_strobe_clockdomainsrenamer1_next_value_ce <= 1'd1;
					clockdomainsrenamer1_next_state <= 1'd1;
				end
			end
		end
		default: begin
			if ((~reset1)) begin
				clockdomainsrenamer1_next_state <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	clockdomainsrenamer2_next_state <= 3'd0;
	enable0_clockdomainsrenamer2_t_next_value0 <= 1'd0;
	enable0_clockdomainsrenamer2_t_next_value_ce0 <= 1'd0;
	sop_clockdomainsrenamer2_t_next_value1 <= 1'd0;
	sop_clockdomainsrenamer2_t_next_value_ce1 <= 1'd0;
	total_error_clockdomainsrenamer2_next_value0 <= 8'd0;
	total_error_clockdomainsrenamer2_next_value_ce0 <= 1'd0;
	aux_clockdomainsrenamer2_next_value1 <= 1'd0;
	aux_clockdomainsrenamer2_next_value_ce1 <= 1'd0;
	wait_clockdomainsrenamer2_next_value2 <= 16'd0;
	wait_clockdomainsrenamer2_next_value_ce2 <= 1'd0;
	eop_clockdomainsrenamer2_f_next_value <= 1'd0;
	eop_clockdomainsrenamer2_f_next_value_ce <= 1'd0;
	clockdomainsrenamer2_next_state <= clockdomainsrenamer2_state;
	case (clockdomainsrenamer2_state)
		1'd1: begin
			if (((rx_data[7:0] == 6'd60) & rx_k[0])) begin
			    led_3c<=1'b1; 
				enable0_clockdomainsrenamer2_t_next_value0 <= 1'd1;
				enable0_clockdomainsrenamer2_t_next_value_ce0 <= 1'd1;
				sop_clockdomainsrenamer2_t_next_value1 <= 1'd1;
				sop_clockdomainsrenamer2_t_next_value_ce1 <= 1'd1;
				clockdomainsrenamer2_next_state <= 2'd3;
			end
		end
		2'd2: begin
			clockdomainsrenamer2_next_state <= 2'd3;
		end
		2'd3: begin
			sop_clockdomainsrenamer2_t_next_value1 <= 1'd0;
			sop_clockdomainsrenamer2_t_next_value_ce1 <= 1'd1;
			total_error_clockdomainsrenamer2_next_value0 <= (total_error + error);
			total_error_clockdomainsrenamer2_next_value_ce0 <= 1'd1;
			if (((rx_data[7:0] == 8'd220) & rx_k[0])) begin
				enable0_clockdomainsrenamer2_t_next_value0 <= 1'd0;
				enable0_clockdomainsrenamer2_t_next_value_ce0 <= 1'd1;
				clockdomainsrenamer2_next_state <= 3'd4;
			end else begin
				clockdomainsrenamer2_next_state <= 2'd3;
				enable0_clockdomainsrenamer2_t_next_value0 <= 1'd1;
				enable0_clockdomainsrenamer2_t_next_value_ce0 <= 1'd1;
			end
		end
		3'd4: begin
			total_error_clockdomainsrenamer2_next_value0 <= (total_error + error);
			total_error_clockdomainsrenamer2_next_value_ce0 <= 1'd1;
			aux_clockdomainsrenamer2_next_value1 <= 1'd1;
			aux_clockdomainsrenamer2_next_value_ce1 <= 1'd1;
			if (aux) begin
				clockdomainsrenamer2_next_state <= 3'd5;
			end
		end
		3'd5: begin
			wait_clockdomainsrenamer2_next_value2 <= (wait_1 + 1'd1);
			wait_clockdomainsrenamer2_next_value_ce2 <= 1'd1;
			if ((wait_1 <= 16'd5200)) begin
				if (((rx_data[7:0] == 6'd60) & rx_k[0])) begin
					//enable0_clockdomainsrenamer2_t_next_value0 <= 1'd1;
					//enable0_clockdomainsrenamer2_t_next_value_ce0 <= 1'd1;
					sop_clockdomainsrenamer2_t_next_value1 <= 1'd1;
					sop_clockdomainsrenamer2_t_next_value_ce1 <= 1'd1;
					clockdomainsrenamer2_next_state <= 2'd3;
					wait_clockdomainsrenamer2_next_value2 <= 'd0;
			        wait_clockdomainsrenamer2_next_value_ce2 <= 1'd1;
				end
			end else begin
				clockdomainsrenamer2_next_state <= 3'd6;
				eop_clockdomainsrenamer2_f_next_value <= 1'd1;
				eop_clockdomainsrenamer2_f_next_value_ce <= 1'd1;
				wait_clockdomainsrenamer2_next_value2 <= 'd0;
				wait_clockdomainsrenamer2_next_value_ce2 <= 1'd1;
			end
		end
		3'd6: begin
			if (error_send_done) begin
				eop_clockdomainsrenamer2_f_next_value <= 1'd0;
				eop_clockdomainsrenamer2_f_next_value_ce <= 1'd1;
				clockdomainsrenamer2_next_state <= 1'd1;
				total_error_clockdomainsrenamer2_next_value0 <= 1'd0;
				total_error_clockdomainsrenamer2_next_value_ce0 <= 1'd1;
			end
		end
		default: begin
			if ((~reset)) begin
				clockdomainsrenamer2_next_state <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	clockdomainsrenamer3_next_state <= 2'd0;
	error_send_done_clockdomainsrenamer3_next_value0 <= 1'd0;
	error_send_done_clockdomainsrenamer3_next_value_ce0 <= 1'd0;
	tx_data_clockdomainsrenamer3_next_value1 <= 8'd0;
	tx_data_clockdomainsrenamer3_next_value_ce1 <= 1'd0;
	tx_ready_clockdomainsrenamer3_next_value2 <= 1'd0;
	tx_ready_clockdomainsrenamer3_next_value_ce2 <= 1'd0;
	clockdomainsrenamer3_next_state <= clockdomainsrenamer3_state;
	case (clockdomainsrenamer3_state)
		1'd1: begin
			tx_ready_clockdomainsrenamer3_next_value2 <= 1'd0;
			tx_ready_clockdomainsrenamer3_next_value_ce2 <= 1'd1;
			if (tx_done) begin
				clockdomainsrenamer3_next_state <= 2'd2;
				tx_data_clockdomainsrenamer3_next_value1 <= total_error;
				tx_data_clockdomainsrenamer3_next_value_ce1 <= 1'd1;
			end
		end
		2'd2: begin
			tx_data_clockdomainsrenamer3_next_value1 <= total_error;
			tx_data_clockdomainsrenamer3_next_value_ce1 <= 1'd1;
			if (eop) begin
				if ((~tx_done)) begin
					tx_ready_clockdomainsrenamer3_next_value2 <= 1'd1;
					tx_ready_clockdomainsrenamer3_next_value_ce2 <= 1'd1;
					clockdomainsrenamer3_next_state <= 2'd3;
				end
			end else begin
				tx_ready_clockdomainsrenamer3_next_value2 <= 1'd0;
				tx_ready_clockdomainsrenamer3_next_value_ce2 <= 1'd1;
			end
		end
		2'd3: begin
			if (tx_done) begin
				clockdomainsrenamer3_next_state <= 1'd0;
				error_send_done_clockdomainsrenamer3_next_value0 <= 1'd1;
				error_send_done_clockdomainsrenamer3_next_value_ce0 <= 1'd1;
				tx_ready_clockdomainsrenamer3_next_value2 <= 1'd0;
				tx_ready_clockdomainsrenamer3_next_value_ce2 <= 1'd1;
			end
		end
		default: begin
			error_send_done_clockdomainsrenamer3_next_value0 <= 1'd0;
			error_send_done_clockdomainsrenamer3_next_value_ce0 <= 1'd1;
			if (sop) begin
				tx_data_clockdomainsrenamer3_next_value1 <= 6'd60;
				tx_data_clockdomainsrenamer3_next_value_ce1 <= 1'd1;
				tx_ready_clockdomainsrenamer3_next_value2 <= 1'd1;
				tx_ready_clockdomainsrenamer3_next_value_ce2 <= 1'd1;
				clockdomainsrenamer3_next_state <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end

always @(posedge rx_clk_1) begin
	rx_data_r <= rx_data;
	if ((tx_counter == 1'd0)) begin
		tx_counter <= 11'd1040;
	end else begin
		tx_counter <= (tx_counter - 1'd1);
	end
	clockdomainsrenamer0_state <= clockdomainsrenamer0_next_state;
	if (tx_latch_clockdomainsrenamer0_t_next_value_ce0) begin
		tx_latch <= tx_latch_clockdomainsrenamer0_t_next_value0;
	end
	if (tx_counter_clockdomainsrenamer0_t_next_value_ce1) begin
		tx_counter <= tx_counter_clockdomainsrenamer0_t_next_value1;
	end
	if (tx_serial1_clockdomainsrenamer0_f_next_value_ce) begin
		tx_serial1 <= tx_serial1_clockdomainsrenamer0_f_next_value;
	end
	if (tx_bitn_clockdomainsrenamer0_t_next_value_ce2) begin
		tx_bitn <= tx_bitn_clockdomainsrenamer0_t_next_value2;
	end
	if (tx_done_clockdomainsrenamer0_t_next_value_ce3) begin
		tx_done <= tx_done_clockdomainsrenamer0_t_next_value3;
	end
	k0_r <= k0;
	error <= (((((((((((((((((((((((((((((((error_xor[0] + error_xor[1]) + error_xor[2]) + error_xor[3]) + error_xor[4]) + error_xor[5]) + error_xor[6]) + error_xor[7]) + error_xor[8]) + error_xor[9]) + error_xor[10]) + error_xor[11]) + error_xor[12]) + error_xor[13]) + error_xor[14]) + error_xor[15]) + error_xor[16]) + error_xor[17]) + error_xor[18]) + error_xor[19]) + error_xor[20]) + error_xor[21]) + error_xor[22]) + error_xor[23]) + error_xor[24]) + error_xor[25]) + error_xor[26]) + error_xor[27]) + error_xor[28]) + error_xor[29]) + error_xor[30]) + error_xor[31]);
	data_r <= rx_data1;
	if (enable1) begin
		state <= {(((((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])) ^ (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1]))) ^ ((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2])))), (((((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))) ^ (((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0]))) ^ ((((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])) ^ (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])))), (((((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))) ^ (((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6])))) ^ ((((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))) ^ (((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])))), (((((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))) ^ (((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5])))) ^ ((((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))) ^ (((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))))), (((((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3]))) ^ (((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4])))) ^ ((((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))) ^ (((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))))), ((((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2]))) ^ (((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3])))) ^ ((((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3]))) ^ (((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))))), ((((((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])) ^ (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1]))) ^ ((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2])))) ^ (((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2]))) ^ (((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3])))))};
		o <= {(state[5] ^ state[6]), (state[4] ^ state[5]), (state[3] ^ state[4]), (state[2] ^ state[3]), (state[1] ^ state[2]), (state[0] ^ state[1]), ((state[5] ^ state[6]) ^ state[0]), ((state[4] ^ state[5]) ^ (state[5] ^ state[6])), ((state[3] ^ state[4]) ^ (state[4] ^ state[5])), ((state[2] ^ state[3]) ^ (state[3] ^ state[4])), ((state[1] ^ state[2]) ^ (state[2] ^ state[3])), ((state[0] ^ state[1]) ^ (state[1] ^ state[2])), (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])), (((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])), (((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))), (((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))), (((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))), (((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3]))), ((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2]))), ((((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])) ^ (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1]))), ((((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))) ^ (((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0]))), ((((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))) ^ (((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6])))), ((((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))) ^ (((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5])))), ((((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3]))) ^ (((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4])))), (((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2]))) ^ (((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3])))), (((((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])) ^ (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1]))) ^ ((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2])))), (((((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))) ^ (((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0]))) ^ ((((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])) ^ (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])))), (((((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))) ^ (((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6])))) ^ ((((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))) ^ (((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])))), (((((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))) ^ (((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5])))) ^ ((((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))) ^ (((state[3] ^ state[4]) ^ (state[4] ^ state[5])) ^ ((state[4] ^ state[5]) ^ (state[5] ^ state[6]))))), (((((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3]))) ^ (((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4])))) ^ ((((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))) ^ (((state[2] ^ state[3]) ^ (state[3] ^ state[4])) ^ ((state[3] ^ state[4]) ^ (state[4] ^ state[5]))))), ((((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2]))) ^ (((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3])))) ^ ((((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3]))) ^ (((state[1] ^ state[2]) ^ (state[2] ^ state[3])) ^ ((state[2] ^ state[3]) ^ (state[3] ^ state[4]))))), ((((((state[4] ^ state[5]) ^ (state[5] ^ state[6])) ^ ((state[5] ^ state[6]) ^ state[0])) ^ (((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1]))) ^ ((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2])))) ^ (((((state[5] ^ state[6]) ^ state[0]) ^ (state[0] ^ state[1])) ^ ((state[0] ^ state[1]) ^ (state[1] ^ state[2]))) ^ (((state[0] ^ state[1]) ^ (state[1] ^ state[2])) ^ ((state[1] ^ state[2]) ^ (state[2] ^ state[3])))))};
	end
	if (i_data_strobe) begin
		crc_cur <= crc_next;
	end
	if (reset2) begin
		crc_cur <= 20'd1048575;
	end
	clockdomainsrenamer1_state <= clockdomainsrenamer1_next_state;
	if (i_data_strobe_clockdomainsrenamer1_next_value_ce) begin
		i_data_strobe <= i_data_strobe_clockdomainsrenamer1_next_value;
	end
	clockdomainsrenamer2_state <= clockdomainsrenamer2_next_state;
	if (enable0_clockdomainsrenamer2_t_next_value_ce0) begin
		enable0 <= enable0_clockdomainsrenamer2_t_next_value0;
	end
	if (sop_clockdomainsrenamer2_t_next_value_ce1) begin
		sop <= sop_clockdomainsrenamer2_t_next_value1;
	end
	if (total_error_clockdomainsrenamer2_next_value_ce0) begin
		total_error <= total_error_clockdomainsrenamer2_next_value0;
	end
	if (aux_clockdomainsrenamer2_next_value_ce1) begin
		aux <= aux_clockdomainsrenamer2_next_value1;
	end
	if (wait_clockdomainsrenamer2_next_value_ce2) begin
		wait_1 <= wait_clockdomainsrenamer2_next_value2;
	end
	if (eop_clockdomainsrenamer2_f_next_value_ce) begin
		eop <= eop_clockdomainsrenamer2_f_next_value;
	end
	clockdomainsrenamer3_state <= clockdomainsrenamer3_next_state;
	if (error_send_done_clockdomainsrenamer3_next_value_ce0) begin
		error_send_done <= error_send_done_clockdomainsrenamer3_next_value0;
	end
	if (tx_data_clockdomainsrenamer3_next_value_ce1) begin
		tx_data <= tx_data_clockdomainsrenamer3_next_value1;
	end
	if (tx_ready_clockdomainsrenamer3_next_value_ce2) begin
		tx_ready <= tx_ready_clockdomainsrenamer3_next_value2;
	end
	if (rx_rst) begin
		total_error <= 8'd0;
		tx_counter <= 11'd0;
		tx_serial1 <= 1'd1;
		tx_data <= 8'd0;
		tx_bitn <= 3'd0;
		tx_ready <= 1'd0;
		tx_latch <= 8'd0;
		tx_done <= 1'd0;
		error <= 5'd0;
		enable0 <= 1'd0;
		o <= 32'd0;
		state <= 7'd1;
		i_data_strobe <= 1'd0;
		crc_cur <= 20'd1048575;
		data_r <= 32'd0;
		k0_r <= 1'd0;
		rx_data_r <= 32'd0;
		sop <= 1'd0;
		eop <= 1'd0;
		wait_1 <= 16'd0;
		error_send_done <= 1'd0;
		aux <= 1'd0;
		clockdomainsrenamer0_state <= 2'd0;
		clockdomainsrenamer1_state <= 2'd0;
		clockdomainsrenamer2_state <= 3'd0;
		clockdomainsrenamer3_state <= 2'd0;
	end
end

endmodule
