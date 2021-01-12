import functools
import operator
import unittest

from migen import *

def cols(rows):
    """
    >>> a = [
    ...  [1, 2],
    ...  ['a', 'b'],
    ...  [4, 5],
    ... ]
    >>> for c in cols(a):
    ...   print(c)
    [1, 'a', 4]
    [2, 'b', 5]
    >>> a = [
    ...  [1, 2, 3],
    ...  ['a', 'b', 'c'],
    ... ]
    >>> for c in cols(a):
    ...   print(c)
    [1, 'a']
    [2, 'b']
    [3, 'c']
    """
    all_c = []
    for ci in range(len(rows[0])):
        all_c.append([])
    for ci in range(len(rows[0])):
        for ri in range(len(rows)):
            assert len(rows[ri]) == len(all_c), "len(%r) != %i" % (rows[ri], len(all_c))
            all_c[ci].append(rows[ri][ci])
    return all_c


def CRC_paralelo(poly, crc_in, data):
    """
    k== num_data_bits
    len(data_cur) == num_data_bits
    >>> for i in range(5):
    ...   l = [0]*5; l[i] = 1
    ...   r = lfsr_serial_shift_crc(
    ...      poly=[0,0,1,0,1], # (5, 2, 0)
    ...      crc_in=l,
    ...      data=[0,0,0,0],
    ...   )
    ...   print("Min[%i] =" % i, r)
    Min[0] = [1, 0, 0, 0, 0]
    Min[1] = [0, 0, 1, 0, 1]
    Min[2] = [0, 1, 0, 1, 0]
    Min[3] = [1, 0, 1, 0, 0]
    Min[4] = [0, 1, 1, 0, 1]
    >>> for i in range(4):
    ...   d = [0]*4; d[i] = 1
    ...   r = lfsr_serial_shift_crc(
    ...      poly=[0,0,1,0,1], # (5, 2, 0)
    ...      crc_in=[0,0,0,0,0],
    ...      data=d,
    ...   )
    ...   print("Nin[%i] =" % i, r)
    Nin[0] = [0, 0, 1, 0, 1]
    Nin[1] = [0, 1, 0, 1, 0]
    Nin[2] = [1, 0, 1, 0, 0]
    Nin[3] = [0, 1, 1, 0, 1]
    """
    poly = poly[::-1] #Primer elemento debe ser el bit menos significativo
    data = data[::-1]

    k=len(data) 
    p=len(poly)
    assert p>1
    assert len(crc_in) == p

    crc_next = list(crc_in)
    for j in range(p):
        crc_upper_bit = crc_next[p-1]
        for i in range(p-1, 0, -1):
            if poly[i]:
                crc_next[i] = crc_next[i-1] ^ crc_upper_bit ^ data[j]
            else:
                crc_next[i] = crc_next[i-1]
        crc_next[0] = crc_upper_bit ^ data[j]
    return list(crc_next[::-1])


def matrices(poly, data_width): 
    #poly: polinomio en bits (lista), bit mas significativo como primer elemento
    #data_width: cantidad de bits de la palabra 

  
    poly_size= len(poly)

    # data_width*polysize matrix == lfsr(0,Nin)
    rows_nin = []

    # (a) calculate the N values when Min=0 and Build NxM matrix
    #  - Each value is one hot encoded (there is only one bit)
    #  - IE N=4, 0x1, 0x2, 0x4, 0x8
    #  - Mout = F(Nin,Min=0)
    #  - Each row contains the results of (a)
    #  - IE row[0] == 0x1, row[1] == 0x2
    #  - Output is M-bit wide (CRC width)
    #  - Each column of the matrix represents an output bit Mout[i] as a function of Nin
    info = []
    for i in range(data_width):
        # crc_in = [0,...,0] = Min
        crc_in = [0,]*poly_size
        # data = [0,..,1,..,0] = Nin
        data = [0,]*data_width
        data[i] = 1
        # Calculate the CRC
        rows_nin.append(CRC_paralelo(poly, crc_in, data))
        info.append("lfsr(%r, %r, %r) = %r" % (poly, crc_in, data, rows_nin[-1]))
    assert len(rows_nin) == data_width
    cols_nin = cols(rows_nin)[::-1]

    # polysize*polysize matrix == lfsr(Min,0)
    info.append("")
    rows_min = []
    for i in range(poly_size):
        # crc_in = [0,..,1,...,0] = Min
        crc_in = [0,]*poly_size
        crc_in[i] = 1
        # data = [0,..,0] = Nin
        data = [0,]*data_width
        # Calculate the crc
        rows_min.append(CRC_paralelo(poly, crc_in, data))
        info.append("lfsr(%r, %r, %r) = %r" % (poly, crc_in, data, rows_min[-1]))
    assert len(rows_min) == poly_size
    cols_min = cols(rows_min)[::-1]

    # (c) Calculate CRC for the M values when Nin=0 and Build MxM matrix
    #  - Each value is one hot encoded
    #  - Mout = F(Nin=0,Min)
    #  - Each row contains results from (7)
    info.append("")
    #for i in range(data_width, -1, -1):
    #    info.append("Mout[%i] = %r %r" % (i, cols_nin[i], cols_min[i]))
    return info, cols_nin, cols_min

class TxParallelCrcGenerator(Module):
    """
   
    width : int
        Width of the CRC.
    polynomial : int
        CRC polynomial in integer form.
    initial : int
        Initial value of the CRC register before data starts shifting in.
    Input Ports
    ------------
    i_data_payload : Signal(8)
        Byte wide data to generate CRC for.
    i_data_strobe : Signal(1)
        Strobe signal for the payload.
    Output Ports
    ------------
    o_crc : Signal(width)
        Current CRC value.
    """
    def __init__(self, data_width, crc_width, polynomial, initial=0):
        self.i_data_payload = Signal(data_width)
        self.i_data_strobe = Signal()
        self.reset=Signal()
        self.o_crc = Signal(crc_width)
        
        crc_dat = Signal(data_width)
        crc_cur = Signal(crc_width, reset=initial)
        crc_next = Signal(crc_width, reset_less=True)
     
        
            

        crc_cur_reset_bits = [
            int(i) for i in "{0:0{width}b}".format(
                #crc_cur.reset.value,width=crc_width)[::-1]]
                crc_cur.reset.value,width=crc_width)]

        self.comb += [
            #crc_dat.eq(self.i_data_payload[::-1]),
            crc_dat.eq(self.i_data_payload),
            # FIXME: Is XOR ^ initial actually correct here?
            #self.o_crc.eq(crc_cur[::-1] ^ initial),
            self.o_crc.eq(crc_cur),


        ]

        self.sync += [
            If(self.i_data_strobe,
                crc_cur.eq(crc_next),
            ),
            If(self.reset,
                crc_cur.eq(initial)
            )

        ]

        poly_list = []
        #convierte a binario, bit mas significativo como primer elemento
        for i in range(crc_width):
            poly_list.insert(0, polynomial >> i & 0x1) 
        assert len(poly_list) == crc_width
        

        _, cols_nin, cols_min = matrices(poly_list, data_width)
       
        
        crc_next_reset_bits = list(crc_cur_reset_bits)
        for i in range(crc_width):
            to_xor = []
            crc_next_reset_bit_i = []
            for j, use in enumerate(cols_nin[i]):
                if use:
                    to_xor.append(crc_dat[j])
                    crc_next_reset_bit_i.append(0)
            for j, use in enumerate(cols_min[i]):
                if use:
                    to_xor.append(crc_cur[j])
                    crc_next_reset_bit_i.append(crc_cur_reset_bits[j])

            crc_next_reset_bits[i] = functools.reduce(operator.xor, crc_next_reset_bit_i)

            self.comb += [
                crc_next[i].eq(functools.reduce(operator.xor, to_xor)),
            ]

        crc_next_reset_value = int("0b"+"".join(str(i) for i in crc_next_reset_bits[::-1]), 2)
        crc_next.reset.value = crc_next_reset_value


def tb(dut):
    yield dut.i_data_strobe.eq(1)
    yield dut.i_data_payload.eq(0x1a)
    yield
    yield dut.i_data_payload.eq(0x1b)
    yield
    yield dut.i_data_payload.eq(0x1c)
    yield
    yield dut.i_data_payload.eq(0x1d)
    yield
    yield dut.i_data_payload.eq(0x1f)
    yield
    yield dut.i_data_payload.eq(0x2a)
    yield
    yield dut.i_data_payload.eq(0x2b)
    yield
    yield dut.i_data_payload.eq(0x2c)
    yield 
    yield dut.i_data_strobe.eq(0)
    yield
    yield dut.reset.eq(1)
    yield
    yield dut.reset.eq(0)
    yield
    yield dut.i_data_strobe.eq(1)
    yield dut.i_data_payload.eq(0x1a)
    yield
    yield dut.i_data_payload.eq(0x1b)
    yield
    yield dut.i_data_payload.eq(0x1c)
    yield
    yield dut.i_data_payload.eq(0x1d)
    yield
    yield dut.i_data_payload.eq(0x1f)
    yield
    yield dut.i_data_payload.eq(0x2a)
    yield
    yield dut.i_data_payload.eq(0x2b)
    yield
    yield dut.i_data_payload.eq(0x2c)
    yield 
dut=TxParallelCrcGenerator(data_width=32, crc_width=20, polynomial=0xc1acf,initial=0xfffff)
run_simulation(dut,tb(dut), vcd_name="prueba_crc.vcd")