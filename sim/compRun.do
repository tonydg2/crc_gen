rm -rf crc_lib 
rm -rf work

vcom ../hdl/generic_crc.vhd         -2008 -work   crc_lib 
vcom ../hdl/tb/crc_tb_pkg.vhd       -2008 -work   crc_lib 
vcom ../hdl/tb/generic_crc_tb.vhd   -2008 -work   work

restart

log -r *

run 5us