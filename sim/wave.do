onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /generic_crc_tb/cs8
add wave -noupdate -expand /generic_crc_tb/verif8
add wave -noupdate -divider {New Divider}
add wave -noupdate /generic_crc_tb/cs16
add wave -noupdate -subitemconfig {/generic_crc_tb/verif16(0) -expand} /generic_crc_tb/verif16
add wave -noupdate -divider {New Divider}
add wave -noupdate /generic_crc_tb/cs32
add wave -noupdate -expand /generic_crc_tb/verif32
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {813 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 170
configure wave -valuecolwidth 171
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {5250 ns}
