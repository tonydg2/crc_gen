vcom ../hdl/generic_crc.vhd         -2008 -work   crc_lib 
vcom ../hdl/tb/crc_tb_pkg.vhd       -2008 -work   crc_lib 
vcom ../hdl/tb/generic_crc_tb.vhd   -2008 -work   work

#vsim -voptargs="+acc" generic_crc_tb
vsim -vopt work.generic_crc_tb -voptargs=+acc

log -r /*

if {[file exists wave.do]} {do wave.do}

run 1us