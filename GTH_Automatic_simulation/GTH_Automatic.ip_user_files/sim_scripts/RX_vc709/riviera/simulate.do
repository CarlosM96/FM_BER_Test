onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+RX_vc709 -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.RX_vc709 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {RX_vc709.udo}

run -all

endsim

quit -force
