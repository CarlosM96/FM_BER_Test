from migen import *

def _divisor(freq_in, freq_out, max_ppm=None):
    divisor = freq_in // freq_out
    if divisor <= 0:
        raise ArgumentError("output frequency is too high")

    ppm = 1000000 * ((freq_in / divisor) - freq_out) / freq_out
    if max_ppm is not None and ppm > max_ppm:
        raise ArgumentError("output frequency deviation is too high")

    return divisor

class tx(Module):
	def __init__(self,freq, baud_rate, n_bits):
		divisor=_divisor(freq,baud_rate)
		tx_counter=Signal(max=divisor)
		self.tx_serial=tx_serial=Signal(reset=1)
		self.tx_data=tx_data=Signal(n_bits)
		self.tx_strobe=tx_strobe=Signal()
		self.tx_bitn=tx_bitn=Signal(max=n_bits)
		self.tx_ready=tx_ready=Signal()
		self.tx_latch=tx_latch=Signal(n_bits)
		self.tx_done=tx_done=Signal() 
		self.comb+=tx_strobe.eq(tx_counter==0)
		self.sync+=\
			If(tx_counter==0,
				tx_counter.eq(divisor-1)
			).Else(
				tx_counter.eq(tx_counter-1)
			)
		self.submodules.tx_fsm=FSM(reset_state="IDLE")
		self.tx_fsm.act("IDLE",
			If(self.tx_ready,
				NextValue(tx_latch,tx_data),
				NextValue(tx_counter,divisor-1),
				NextState("START")
			).Else(
				NextValue(tx_serial,1)
			)
		)
		self.tx_fsm.act("START",
			If(tx_strobe,
				NextValue(tx_serial,0),
				NextState("DATA")
			)
		)
		self.tx_fsm.act("DATA",
			If(tx_strobe,
				NextValue(tx_serial,tx_latch[0]),
				NextValue(tx_latch,Cat(tx_latch[1:n_bits],0)),
				NextValue(tx_bitn,tx_bitn+1),
				If(tx_bitn==n_bits-1,
					NextState("STOP"),
					NextValue(tx_bitn,0),
					NextValue(tx_done,1),	
				)
			)
		)
		self.tx_fsm.act("STOP",
			If(tx_strobe,
				NextValue(tx_serial,1),
				NextValue(tx_done,0),
				NextState("IDLE")
			)
		)