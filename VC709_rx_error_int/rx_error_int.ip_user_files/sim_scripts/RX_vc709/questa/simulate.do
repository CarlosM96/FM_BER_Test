onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib RX_vc709_opt

do {wave.do}

view wave
view structure
view signals

do {RX_vc709.udo}

run -all

quit -force
