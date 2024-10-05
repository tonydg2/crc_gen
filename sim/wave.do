onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /generic_crc_tb/crc8p2/data_i
add wave -noupdate /generic_crc_tb/crc8p2/data_valid_i
add wave -noupdate /generic_crc_tb/crc8p2/crc_o
add wave -noupdate /generic_crc_tb/crc8p2/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {894603 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5250 ns}
