from migen import *
from fsm import Fsm
from crc import TxParallelCrcGenerator
from litex.soc.cores.code_8b10b import Encoder
from migen.genlib.cdc import MultiReg
class TX(Module):
	def __init__(self):
		self.link_ready=Signal()
		self.data_in=Signal(32)
		self.data_type_in=Signal(2)
		self.data_out=Signal(32)
		self.fifo_empty=Signal()
		self.fifo_re=Signal()
		self.tx_init_done=Signal()
		self.k=Signal()

		#  #  #
		
		crc_encoder=TxParallelCrcGenerator(data_width=32, crc_width=20, polynomial=0xc1acf,initial=0xfffff)
		stream_controller=Fsm()
		self.submodules+=[crc_encoder, stream_controller]
		
		tx_init_done=Signal()
		fifo_empty=Signal()
		self.specials += [
            MultiReg(self.tx_init_done, tx_init_done),
            MultiReg(self.fifo_empty, fifo_empty)
        ]

		self.comb+=[
			stream_controller.link_ready.eq(self.link_ready),
			stream_controller.fifo_empty.eq(fifo_empty),
			stream_controller.data_type.eq(self.data_type_in),
			stream_controller.tx_init_done.eq(tx_init_done),
			self.fifo_re.eq(stream_controller.fifo_re),
			If(self.data_type_in!=3,
				crc_encoder.i_data_strobe.eq(stream_controller.strobe_crc)
			),
			crc_encoder.reset.eq(stream_controller.reset_crc),
			If(stream_controller.encoder_ready,
				crc_encoder.i_data_payload.eq(self.data_in),
			),
			
		]
		
		self.comb+=[ 
			If(stream_controller.idle,
				self.data_out.eq(0xBC),
				self.k.eq(1)
			),
			If(stream_controller.sop, 
				self.data_out.eq(0x3C),
				self.k.eq(1)
			),
			If((stream_controller.intermediate),
				self.data_out.eq(self.data_in)
			),
			If(stream_controller.ign,
				self.data_out.eq(0x5C),
				self.k.eq(1)
			),
			If(stream_controller.eop,                  
				self.data_out.eq(Cat(0xDC,crc_encoder.o_crc)),
				self.k.eq(1)
			),
			If((~stream_controller.idle)&(~stream_controller.eop)&(~stream_controller.sop)&(~stream_controller.ign),
				self.k.eq(0)	
			),
			
		]		

