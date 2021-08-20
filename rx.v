`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2020 03:03:13 PM
module rx(
	input [31:0] data_in,
	input rx_init_done,
	input pll_lock,
	input trans_en,
	output tx_serial,
	input [3:0] k_in,
	input sys_clk,
	input sys_rst
);

wire [31:0] data_in1;
wire trans_en1;
wire tx_serial1;
reg tx_32bdone = 1'd0;
wire fifoEmpty;
reg [10:0] tx_counter = 11'd0;
reg tx_serial2 = 1'd1;
reg [7:0] tx_data = 8'd0;
wire tx_strobe;
reg [2:0] tx_bitn = 3'd0;
reg tx_ready = 1'd0;
reg [7:0] tx_latch = 8'd0;
reg tx_done = 1'd0;
reg [3:0] byte_cnt = 4'd0;
reg syncfifo_we;
wire syncfifo_writable;
wire syncfifo_re;
wire syncfifo_readable;
wire [31:0] syncfifo_din;
wire [31:0] syncfifo_dout;
reg [14:0] level = 15'd0;
reg replace = 1'd0;
reg [14:0] produce = 15'd0;
reg [14:0] consume = 15'd0;
reg [14:0] wrport_adr;
wire [31:0] wrport_dat_r;
wire wrport_we;
wire [31:0] wrport_dat_w;
wire do_read;
wire [14:0] rdport_adr;
wire [31:0] rdport_dat_r;
reg [1:0] fsm_state = 2'd0;
reg [1:0] fsm_next_state;
reg tx_ready_next_value0;
reg tx_ready_next_value_ce0;
reg [7:0] tx_data_next_value1;
reg tx_data_next_value_ce1;
reg tx_32bdone_next_value2;
reg tx_32bdone_next_value_ce2;
reg [3:0] byte_cnt_next_value3;
reg byte_cnt_next_value_ce3;
reg [1:0] tx_state = 2'd0;
reg [1:0] tx_next_state;
reg [7:0] tx_latch_t_next_value0;
reg tx_latch_t_next_value_ce0;
reg [10:0] tx_counter_t_next_value1;
reg tx_counter_t_next_value_ce1;
reg tx_serial2_f_next_value;
reg tx_serial2_f_next_value_ce;
reg [2:0] tx_bitn_t_next_value2;
reg tx_bitn_t_next_value_ce2;
reg tx_done_t_next_value3;
reg tx_done_t_next_value_ce3;
reg [1:0] state = 2'd0;
reg [1:0] next_state;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign syncfifo_din = data_in;
assign syncfifo_re = tx_32bdone;
assign data_in1 = syncfifo_dout;
assign tx_serial = tx_serial1;
assign trans_en1 = trans_en;
assign fifoEmpty = (~syncfifo_readable);
assign tx_serial1 = tx_serial2;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	fsm_next_state <= 2'd0;
	tx_ready_next_value0 <= 1'd0;
	tx_ready_next_value_ce0 <= 1'd0;
	tx_data_next_value1 <= 8'd0;
	tx_data_next_value_ce1 <= 1'd0;
	tx_32bdone_next_value2 <= 1'd0;
	tx_32bdone_next_value_ce2 <= 1'd0;
	byte_cnt_next_value3 <= 4'd0;
	byte_cnt_next_value_ce3 <= 1'd0;
	fsm_next_state <= fsm_state;
	case (fsm_state)
		1'd1: begin
			if (tx_done) begin
				byte_cnt_next_value3 <= (byte_cnt + 1'd1);
				byte_cnt_next_value_ce3 <= 1'd1;
				if ((byte_cnt < 2'd3)) begin
					tx_ready_next_value0 <= 1'd1;
					tx_ready_next_value_ce0 <= 1'd1;
					fsm_next_state <= 2'd2;
				end else begin
					fsm_next_state <= 1'd0;
					tx_32bdone_next_value2 <= 1'd1;
					tx_32bdone_next_value_ce2 <= 1'd1;
					tx_ready_next_value0 <= 1'd0;
					tx_ready_next_value_ce0 <= 1'd1;
					byte_cnt_next_value3 <= 1'd0;
					byte_cnt_next_value_ce3 <= 1'd1;
				end
			end
		end
		2'd2: begin
			case (byte_cnt)
				1'd1: begin
					tx_data_next_value1 <= data_in1[15:8];
					tx_data_next_value_ce1 <= 1'd1;
				end
				2'd2: begin
					tx_data_next_value1 <= data_in1[23:16];
					tx_data_next_value_ce1 <= 1'd1;
				end
				2'd3: begin
					tx_data_next_value1 <= data_in1[31:24];
					tx_data_next_value_ce1 <= 1'd1;
				end
			endcase
			if ((~tx_done)) begin
				fsm_next_state <= 1'd1;
			end
		end
		default: begin
			if (((trans_en1 & (~tx_done)) & (~fifoEmpty))) begin
				fsm_next_state <= 1'd1;
				tx_ready_next_value0 <= 1'd1;
				tx_ready_next_value_ce0 <= 1'd1;
				tx_data_next_value1 <= data_in1[7:0];
				tx_data_next_value_ce1 <= 1'd1;
			end else begin
				fsm_next_state <= 1'd0;
				tx_ready_next_value0 <= 1'd0;
				tx_ready_next_value_ce0 <= 1'd1;
			end
			tx_32bdone_next_value2 <= 1'd0;
			tx_32bdone_next_value_ce2 <= 1'd1;
		end
	endcase
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign tx_strobe = (tx_counter == 1'd0);

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	tx_next_state <= 2'd0;
	tx_latch_t_next_value0 <= 8'd0;
	tx_latch_t_next_value_ce0 <= 1'd0;
	tx_counter_t_next_value1 <= 11'd0;
	tx_counter_t_next_value_ce1 <= 1'd0;
	tx_serial2_f_next_value <= 1'd0;
	tx_serial2_f_next_value_ce <= 1'd0;
	tx_bitn_t_next_value2 <= 3'd0;
	tx_bitn_t_next_value_ce2 <= 1'd0;
	tx_done_t_next_value3 <= 1'd0;
	tx_done_t_next_value_ce3 <= 1'd0;
	tx_next_state <= tx_state;
	case (tx_state)
		1'd1: begin
			if (tx_strobe) begin
				tx_serial2_f_next_value <= 1'd0;
				tx_serial2_f_next_value_ce <= 1'd1;
				tx_next_state <= 2'd2;
			end
		end
		2'd2: begin
			if (tx_strobe) begin
				tx_serial2_f_next_value <= tx_latch[0];
				tx_serial2_f_next_value_ce <= 1'd1;
				tx_latch_t_next_value0 <= {1'd0, tx_latch[7:1]};
				tx_latch_t_next_value_ce0 <= 1'd1;
				tx_bitn_t_next_value2 <= (tx_bitn + 1'd1);
				tx_bitn_t_next_value_ce2 <= 1'd1;
				if ((tx_bitn == 3'd7)) begin
					tx_next_state <= 2'd3;
					tx_bitn_t_next_value2 <= 1'd0;
					tx_bitn_t_next_value_ce2 <= 1'd1;
					tx_done_t_next_value3 <= 1'd1;
					tx_done_t_next_value_ce3 <= 1'd1;
				end
			end
		end
		2'd3: begin
			if (tx_strobe) begin
				tx_serial2_f_next_value <= 1'd1;
				tx_serial2_f_next_value_ce <= 1'd1;
				tx_done_t_next_value3 <= 1'd0;
				tx_done_t_next_value_ce3 <= 1'd1;
				tx_next_state <= 1'd0;
			end
		end
		default: begin
			if (tx_ready) begin
				tx_latch_t_next_value0 <= tx_data;
				tx_latch_t_next_value_ce0 <= 1'd1;
				tx_counter_t_next_value1 <= 11'd1040;
				tx_counter_t_next_value_ce1 <= 1'd1;
				tx_next_state <= 1'd1;
			end else begin
				tx_serial2_f_next_value <= 1'd1;
				tx_serial2_f_next_value_ce <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	wrport_adr <= 18'd0;
	if (replace) begin
		wrport_adr <= (produce - 1'd1);
	end else begin
		wrport_adr <= produce;
	end
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign wrport_dat_w = syncfifo_din;
assign wrport_we = (syncfifo_we & (syncfifo_writable | replace));
assign do_read = (syncfifo_readable & syncfifo_re);
assign rdport_adr = consume;
assign syncfifo_dout = rdport_dat_r;
assign syncfifo_writable = (level != 15'd17000);
assign syncfifo_readable = (level != 1'd0);

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	syncfifo_we <= 1'd0;
	next_state <= 2'd0;
	next_state <= state;
	case (state)
		1'd1: begin
			if (((data_in[7:0] == 6'd60) & (k_in == 1'd1))) begin
				syncfifo_we <= 1'd1;
				next_state <= 2'd2;
			end
		end
		2'd2: begin
			syncfifo_we <= 1'd1;
			if (((data_in[7:0] == 8'd220) & (k_in == 1'd1))) begin
				next_state <= 1'd1;
			end
		end
		default: begin
			if ((rx_init_done & pll_lock)) begin
				next_state <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	fsm_state <= fsm_next_state;
	if (tx_ready_next_value_ce0) begin
		tx_ready <= tx_ready_next_value0;
	end
	if (tx_data_next_value_ce1) begin
		tx_data <= tx_data_next_value1;
	end
	if (tx_32bdone_next_value_ce2) begin
		tx_32bdone <= tx_32bdone_next_value2;
	end
	if (byte_cnt_next_value_ce3) begin
		byte_cnt <= byte_cnt_next_value3;
	end
	if ((tx_counter == 1'd0)) begin
		tx_counter <= 11'd1040;
	end else begin
		tx_counter <= (tx_counter - 1'd1);
	end
	tx_state <= tx_next_state;
	if (tx_latch_t_next_value_ce0) begin
		tx_latch <= tx_latch_t_next_value0;
	end
	if (tx_counter_t_next_value_ce1) begin
		tx_counter <= tx_counter_t_next_value1;
	end
	if (tx_serial2_f_next_value_ce) begin
		tx_serial2 <= tx_serial2_f_next_value;
	end
	if (tx_bitn_t_next_value_ce2) begin
		tx_bitn <= tx_bitn_t_next_value2;
	end
	if (tx_done_t_next_value_ce3) begin
		tx_done <= tx_done_t_next_value3;
	end
	if (((syncfifo_we & syncfifo_writable) & (~replace))) begin
		if ((produce == 15'd16999)) begin
			produce <= 1'd0;
		end else begin
			produce <= (produce + 1'd1);
		end
	end
	if (do_read) begin
		if ((consume == 15'd16999)) begin
			consume <= 1'd0;
		end else begin
			consume <= (consume + 1'd1);
		end
	end
	if (((syncfifo_we & syncfifo_writable) & (~replace))) begin
		if ((~do_read)) begin
			level <= (level + 1'd1);
		end
	end else begin
		if (do_read) begin
			level <= (level - 1'd1);
		end
	end
	state <= next_state;
	if (sys_rst) begin
		tx_32bdone <= 1'd0;
		tx_counter <= 11'd0;
		tx_serial2 <= 1'd1;
		tx_data <= 8'd0;
		tx_bitn <= 3'd0;
		tx_ready <= 1'd0;
		tx_latch <= 8'd0;
		tx_done <= 1'd0;
		byte_cnt <= 4'd0;
		level <= 15'd0;
		produce <= 15'd0;
		consume <= 15'd0;
		fsm_state <= 2'd0;
		tx_state <= 2'd0;
		state <= 2'd0;
	end
end

reg [31:0] storage[0:16999];
reg [31:0] memdat;
always @(posedge sys_clk) begin
	if (wrport_we)
		storage[wrport_adr] <= wrport_dat_w;
	memdat <= storage[wrport_adr];
end

always @(posedge sys_clk) begin
end

assign wrport_dat_r = memdat;
assign rdport_dat_r = storage[rdport_adr];

endmodule
