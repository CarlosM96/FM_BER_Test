from prbs import *
from crc import *
from operator import xor, add
from functools import reduce
from migen import *
from migen.fhdl import verilog
class Error_Counter(Module):
	def __init__(self):
		self.rx_data=rx_data=Signal(32)
		self.error=Signal(5)
		self.enable = enable = Signal()
		self.reset = reset =Signal()
		self.k0 = k0 =Signal()
		#	#	#
		prbs=PRBSGenerator(n_out=32)
		crc= TxParallelCrcGenerator(data_width=32, crc_width=20, polynomial=0xc1acf,initial=0xfffff)
		self.submodules+=[prbs,crc]
		self.data_r=data_r=Signal(32)
		one=Signal()
		error_xor=Signal(32)
		
		self.comb+=[
			prbs.enable.eq(self.enable),
			crc.i_data_payload.eq(data_r)
		]
		curval = [error_xor[i] for i in range(32)]
		for i in range(32):
			bits_error=reduce(add, curval)
		prbs_ready=Signal()
		k0_r=Signal()
		self.sync+=[
			k0_r.eq(k0),
			self.error.eq(bits_error),
			data_r.eq(rx_data)

		]
		self.submodules.fsm=FSM(reset_state="INIT")
		self.fsm.act("INIT",
			If((~reset),
				NextState("IDLE")
			)
		)
		self.fsm.act("IDLE",
			If(self.enable,
				NextState("MIDDLE_WORDS"),
				NextValue(crc.i_data_strobe,1)
			)
		)
		self.fsm.act("MIDDLE_WORDS",
			If(data_r[:8]!=0xdc,
				error_xor.eq(data_r ^ prbs.o),
				NextState("MIDDLE_WORDS")
								
			).Elif((data_r[:8]==0xdc) & (k0_r),
				error_xor.eq(crc.o_crc ^ data_r[8:28]),
				NextValue(crc.i_data_strobe,0),
				NextState("IDLE")
			)
		)

		
"""
dut=error_counter()
def tb(dut):
	yield dut.enable.eq(1)
	yield dut.rx_data.eq(0x11223344)
	for i in range(10):
		yield

run_simulation(dut, tb(dut), vcd_name="error_counter_tb.vcd")
#verilog.convert(dut, {dut.rx_data, dut.error, dut.enable}).write("error_counter.v")
"""