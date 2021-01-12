from migen import *

from migen.fhdl.specials import Memory, READ_FIRST

value_input = [ 
    0x0,
    0xa1a2a3a4,
    0xb1b2b3b4,
    0xc1c2c3c4,
    0xd1d2d3d4,
    0xe1e2e3e4,
    0xf1f2f3f4,
    0x12345678,
    0x0,
    0x11111111,
    0x22222222,
    0x33333333,
    0x44444444,
    
]

value_type = [
        
    0b01,   #SOP
    0b00,
    0b00,
    0b11,   #IGNORED
    0b00,
    0b00,
    0b00,
    0b10,   #EOP
    0b01,   #SOP
    0b00,
    0b00,
    0b00,
    0b10,   #EOP

]


class mem(Module):
    def __init__(self):
        self.n_value=n_value=len(value_input)
        self.index=index=Signal(5)
        self.data_out=Signal(32)
        self.type_out=Signal(2)

        
        n_type=len(value_type)
        assert n_value==n_type

        
        table1 = Memory(32, n_type, init = Array(value_input), name="INPUT") 
        self.specials += table1

        wrport1 = table1.get_port(write_capable=False, mode=READ_FIRST) 
        self.specials += wrport1

        table2 = Memory(2, n_type, init = Array(value_type), name="TYPE") 
        self.specials += table2

        wrport2 = table2.get_port(write_capable=False, mode=READ_FIRST) 
        self.specials += wrport2

        self.comb += [
            wrport1.adr.eq(index),
            wrport2.adr.eq(index),
            self.data_out.eq(wrport1.dat_r),
            self.type_out.eq(wrport2.dat_r),
            
        ]
        