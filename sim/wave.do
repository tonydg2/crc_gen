onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /generic_crc_tb/cs8
add wave -noupdate /generic_crc_tb/verif8
add wave -noupdate -divider {New Divider}
add wave -noupdate /generic_crc_tb/cs16
add wave -noupdate /generic_crc_tb/verif16
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {250 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1050 ns}
