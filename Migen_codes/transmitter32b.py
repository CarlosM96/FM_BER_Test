#Modulo encargado de controlar las transiciones de estado para el envio de 
#una palabra de 32 bits dividiendola en 4 bytes
from migen import *
import sys
from tx_uart import *
class Transmitter32b(Module):
	def __init__(self):
		self.data_in=Signal(32) 
		self.trans_en=Signal() 
		self.tx_serial=Signal()
		self.tx_32bdone=Signal() 
		self.fifoEmpty=Signal()
		#  #  #
		self.submodules.trans_fsm=FSM(reset_state="IDLE")
		transmitter=tx(freq=120000000, baud_rate=115200, n_bits=8)
		self.byte_cnt=Signal(4) 
		self.submodules+=transmitter
		self.comb+=self.tx_serial.eq(transmitter.tx_serial)
		self.trans_fsm.act("IDLE",
			If( (self.trans_en)&(~transmitter.tx_done)&(~self.fifoEmpty),
				NextState("SENDING_BYTE"),
				NextValue(transmitter.tx_ready,1),
				NextValue(transmitter.tx_data,self.data_in[:8])
			).Else(
				NextState("IDLE"),
				NextValue(transmitter.tx_ready,0)
			),
			NextValue(self.tx_32bdone,0)
			
		)
		
		self.trans_fsm.act("SENDING_BYTE",
			If(transmitter.tx_done,
				NextValue(self.byte_cnt,self.byte_cnt+1),
				If(self.byte_cnt<3, 
					NextValue(transmitter.tx_ready,1),
					NextState("WAITING")
				).Else(
					NextState("IDLE"),
					NextValue(self.tx_32bdone,1),
					NextValue(transmitter.tx_ready,0),
					NextValue(self.byte_cnt,0)
				)
			)
		)
		
		self.trans_fsm.act("WAITING",
			Case(self.byte_cnt,{
					1:	NextValue(transmitter.tx_data,self.data_in[8:16]),
					2:	NextValue(transmitter.tx_data,self.data_in[16:24]),
					3:	NextValue(transmitter.tx_data,self.data_in[24:])
				}),
			If(~transmitter.tx_done,
				NextState("SENDING_BYTE")
			)
		)