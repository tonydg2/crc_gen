rm -rf crc_lib 
rm -rf work

vcom ../hdl/generic_crc.vhd         -2008 -work   crc_lib 
vcom ../hdl/tb/crc_tb_pkg.vhd       -2008 -work   crc_lib 
vcom ../hdl/tb/generic_crc_tb.vhd   -2008 -work   work

#vsim -voptargs="+acc" generic_crc_tb

vsim -vopt work.generic_crc_tb -voptargs=+acc

#vsim -novopt work.generic_crc_tb 

log -r /*

if {[file exists wave2.do]} {do wave2.do}

run 5us