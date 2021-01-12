from litex.soc.cores.code_8b10b import Decoder
from tx_uart import tx
from alignment_corrector import *
from error_counter import Error_Counter
from migen.genlib.fifo import *
from migen import *
class RX(Module):
	def __init__(self):
		self.rx_data=rx_data=Signal(32)
		self.rx_clk=Signal()
		self.reset = reset = Signal()
		self.trans_en = trans_en = Signal() 
		self.tx_serial= tx_serial = Signal() 
		self.aligned = aligned = Signal()
		self.rx_k = rx_k =Signal(4)
		
		#	#	#
		
		self.clock_domains.cd_rx = ClockDomain()
		self.total_error=total_error=Signal(8)

		tx_uart= tx(freq=120000000, baud_rate=115200, n_bits=8)
		tx_uart=ClockDomainsRenamer("rx")(tx_uart)
		err_counter= Error_Counter()
		err_counter = ClockDomainsRenamer("rx")(err_counter)
		self.submodules+=[tx_uart, err_counter]
		self.comb+=[
            self.cd_rx.rst.eq(reset),
            self.cd_rx.clk.eq(self.rx_clk),
           
            tx_serial.eq(tx_uart.tx_serial),
            err_counter.rx_data.eq(rx_data),
            err_counter.k0.eq(rx_k[0]),
			tx_serial.eq(tx_uart.tx_serial),
        ]    
		
		self.rx_data_r=rx_data_r=Signal(32)
		self.rx_data_r2=rx_data_r2=Signal(32)
		self.sync.rx+=[
		
		
			rx_data_r.eq(rx_data)
		]

		
		self.submodules.fsm=FSM(reset_state="INIT")
		self.fsm=ClockDomainsRenamer("rx")(self.fsm)
		sop=Signal()
		eop=Signal()
		wait=Signal(3)
		error_send_done=Signal()
		
		self.fsm.act("INIT",
			If((~reset),
				NextState("WAITING_SOP")
			)
		)

		self.fsm.act("WAITING_SOP",
			If( (rx_data[:8]==0x3c) & (rx_k[0]) , #SOP 
				NextValue(err_counter.enable,1),
				NextValue(sop,1),				
				NextState("WAITING_EOP")
			)	
		)

		self.fsm.act("DELAY",
			NextState("WAITING_EOP")	
		)

		self.fsm.act("WAITING_EOP",
			NextValue(sop,0),	
			NextValue(total_error, total_error+err_counter.error),
			If(((rx_data[:8]==0xdc) & (rx_k[0])), #EOP
				NextValue(err_counter.enable,0),
				
				NextState("EOP")
			).Else(
				NextState("WAITING_EOP"),
				NextValue(err_counter.enable,1)
			),
			
		)
		aux=Signal()
		self.fsm.act("EOP",
			NextValue(total_error, total_error+err_counter.error),
			#NextValue(err_counter.enable,0),
			NextValue(aux,1),
			If(aux,
				NextState("WAITING_NEXT_PACK"),
				
			),

					
		)
		self.fsm.act("WAITING_NEXT_PACK",
			NextValue(wait,wait+1),
			If(wait<=10,
				If( (rx_data[:8]==0x3c) & (rx_k[0]) , #SOP 
					#NextValue(err_counter.enable,1),
					#NextValue(sop,1),				
					NextState("WAITING_EOP")
				)
			).Else(
				NextState("SENDING_ERROR"),
				NextValue(eop,1),
				NextValue(wait,0)
			)
		)
		self.fsm.act("SENDING_ERROR",
			If(error_send_done,
				NextValue(eop,0),
				NextState("WAITING_SOP"),
				NextValue(total_error, 0),
			)
		)
		######################
		self.submodules.fsm_uart=FSM(reset_state="IDLE")
		self.fsm_uart=ClockDomainsRenamer("rx")(self.fsm_uart)

		self.fsm_uart.act("IDLE",
			NextValue(error_send_done,0),
			If(sop,
				NextValue(tx_uart.tx_data,0x3c),
				NextValue(tx_uart.tx_ready,1),
				NextState("SOP")
			)
		)
		self.fsm_uart.act("SOP",
			NextValue(tx_uart.tx_ready,0),
			If(tx_uart.tx_done,
				NextState("ERROR"),
				NextValue(tx_uart.tx_data,total_error)
				
			)
		)

		self.fsm_uart.act("ERROR",
			NextValue(tx_uart.tx_data,total_error),
			If(eop,
				If(~tx_uart.tx_done,
					NextValue(tx_uart.tx_ready,1),
					NextState("WAITING_TX_DONE")
					
				),
			).Else(
				NextValue(tx_uart.tx_ready,0),
			)
		)
		self.fsm_uart.act("WAITING_TX_DONE",
			If(tx_uart.tx_done,
				NextState("IDLE"),
				NextValue(error_send_done,1),
				NextValue(tx_uart.tx_ready,0),
			)
		)



dut=RX()
verilog.convert(dut, {dut.rx_data, dut.rx_clk, dut.reset, dut.rx_k,
	 dut.aligned, dut.trans_en, dut.tx_serial}).write("rx_fullsuma_error_top.v")
	
"""
dut=RX()
def tb(dut):

	yield dut.rx_k.eq(0b0001)
	yield
	yield dut.rx_data.eq(0x3c)
	yield
	#yield dut.rx_data.eq(0x06147916)
	yield dut.rx_data.eq(0x06147915)
	yield
	yield dut.rx_data.eq(0x753e8712)
	yield
	yield dut.rx_data.eq(0x6d6f634b)
	yield
	yield dut.rx_data.eq(0xb9957f02)
	yield
	yield dut.rx_data.eq(0xb9957fdc)
	yield
	yield dut.rx_k.eq(0b0001)
	yield
	yield dut.rx_data.eq(0xbc)
	yield
	yield dut.rx_k.eq(0b0001)
	yield
	yield dut.rx_data.eq(0x3c)
	yield
	yield dut.rx_data.eq(0x0c28f22c)
	yield
	yield dut.rx_data.eq(0xea7d0e24)
	yield
	yield dut.rx_k.eq(0b0001)
	yield dut.rx_data.eq(0x4d252dc)
	yield	
	yield
	#yield dut.rx_data.eq(0x06147916)
	yield dut.rx_data.eq(0x06147915)
	yield
	yield dut.rx_data.eq(0x753e8712)
	yield
	yield dut.rx_data.eq(0x6d6f634b)
	yield
	yield dut.rx_data.eq(0xb9957f02)
	yield
	yield dut.rx_data.eq(0x0c28f22c)
	yield
	yield dut.rx_data.eq(0xea7d0e24)
	yield
	yield dut.rx_k.eq(0b0001)
	yield dut.rx_data.eq(0x4d252dc)
	for i in range(10):
		yield
run_simulation(dut, tb(dut), vcd_name="error_counter_tb.vcd")
"""