from migen import *
class Fsm(Module):
	def __init__(self):
		#Inputs
		self.link_ready=Signal() 
		self.fifo_empty=Signal() 
		self.data_type=Signal(2)
		self.tx_init_done=Signal() 
		#Outputs
		self.sop=Signal()
		self.eop=Signal()
		self.ign=Signal()
		self.idle=Signal()
		self.intermediate=Signal()
		self.encoder_ready=Signal() 
		self.fifo_re=Signal() 
		self.strobe_crc=Signal()
		self.reset_crc=Signal()
		#	#	#
		aux_ign=Signal()
		self.submodules.fsm=ResetInserter()(FSM(reset_state="INIT"))
		self.fsm.act("INIT", 	#0
			If(self.tx_init_done,	
				If(self.link_ready,
					If(self.link_ready & (~self.fifo_empty) & (self.data_type==1),
						NextState("SOP"),
						NextValue(self.fifo_re,1), 
						NextValue(self.sop,1),
						NextValue(self.idle,0),
					).Else(
						NextState("IDLE"),
						NextValue(self.idle,1)
					)
				).Else(
					NextState("IDLE"),
					NextValue(self.idle,1)
				)
			).Else(NextState("INIT")),
		)
	

		self.fsm.act("IDLE",  	#1
			NextValue(self.encoder_ready,1),
			If(self.fifo_empty,
				NextState("IDLE")
			).Elif(self.link_ready & (self.data_type==1),
				NextState("SOP"),
				NextValue(self.fifo_re,1), 
				NextValue(self.sop,1),
				NextValue(self.idle,0)
			)
		)
		self.fsm.act("SOP", #2
			NextState("INTERMEDIATE"),
			NextValue(self.encoder_ready,1),
			NextValue(self.intermediate,1),
			NextValue(self.fifo_re,1),
			NextValue(self.sop,0),
			NextValue(self.strobe_crc,1)
		)	
		
		self.fsm.act("INTERMEDIATE", #3
			If(self.fifo_empty,
				NextState("INIT")
			).Else(NextValue(self.fifo_re,1)),
			If(~self.fifo_empty,	
				Case(self.data_type,{
					#Intermediate word
					0:[ 
						NextValue(self.encoder_ready,1),
						NextValue(self.intermediate,1),
						NextValue(self.strobe_crc,1),
						NextValue(self.fifo_re,1),
						NextValue(aux_ign,0)
					],
					#SOP (Error)
					1:[
						NextState("SOP"),
						NextValue(self.fifo_re,1), 
						NextValue(self.sop,1),
					],
					#Last word (EOP)
					2:[	
						NextState("EOP"),
						NextValue(self.eop,1),
						NextValue(self.strobe_crc,0),
						NextValue(self.reset_crc,1),
						NextValue(self.intermediate,0),
						NextValue(aux_ign,0)
					],
					#Ignored
					3:[
						NextState("INTERMEDIATE"),
						self.ign.eq(1)
					]
				}),
			)
		)

		self.fsm.act("EOP", #4
			
			NextValue(self.eop,0),
			NextValue(self.reset_crc,0),
			If((~self.fifo_empty) & (self.data_type==1),
				NextState("SOP"),
				NextValue(self.fifo_re,1), 
				NextValue(self.sop,1)
			).Else(
				NextValue(self.idle,1),
				NextValue(self.fifo_re,0),
				NextState("IDLE")
			)		
		)
		