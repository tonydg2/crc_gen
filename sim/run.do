vcom ../hdl/generic_crc.vhd         -work   crc_lib 
vcom ../hdl/tb/generic_crc_tb.vhd   -work   work

vsim -voptargs="+acc" generic_crc_tb

log -r /*

if {[file exists wave.do]} {do wave.do}

run 1us