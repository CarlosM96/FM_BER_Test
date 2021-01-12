onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib TX_GTH_opt

do {wave.do}

view wave
view structure
view signals

do {TX_GTH.udo}

run -all

quit -force
