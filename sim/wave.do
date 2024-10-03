onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {New Group} /generic_crc_tb/cs8
add wave -noupdate -group {New Group} /generic_crc_tb/verif8
add wave -noupdate -group {New Group} -divider -height 33 {New Divider}
add wave -noupdate -group {New Group} /generic_crc_tb/cs16
add wave -noupdate -group {New Group} /generic_crc_tb/verif16
add wave -noupdate -group {New Group} -divider -height 33 {New Divider}
add wave -noupdate -group {New Group} /generic_crc_tb/cs32
add wave -noupdate -group {New Group} /generic_crc_tb/verif32
add wave -noupdate -group {New Group} -divider -height 33 {New Divider}
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc8_test(0)/gen_crc8_inst(1)/generic_crc/d
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc8_test(0)/gen_crc8_inst(1)/generic_crc/checksum_reflect
add wave -noupdate -group {New Group} -divider -height 33 {New Divider}
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc8_test(0)/gen_crc8_inst(2)/generic_crc/d
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc8_test(0)/gen_crc8_inst(2)/generic_crc/checksum_reflect
add wave -noupdate -group {New Group} -divider -height 33 {New Divider}
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc16_test(0)/gen_crc16_inst(1)/generic_crc/d
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc16_test(0)/gen_crc16_inst(1)/generic_crc/checksum_reflect
add wave -noupdate -group {New Group} -divider -height 33 {New Divider}
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc32_test(0)/gen_crc32_inst(0)/generic_crc/d
add wave -noupdate -group {New Group} /generic_crc_tb/gen_crc32_test(0)/gen_crc32_inst(0)/generic_crc/checksum_reflect
add wave -noupdate -expand -group 1 /generic_crc_tb/inst1/checksum
add wave -noupdate -expand -group 1 /generic_crc_tb/inst1/Polynomial
add wave -noupdate -expand -group 1 /generic_crc_tb/inst1/InitialConditions
add wave -noupdate -expand -group 1 /generic_crc_tb/inst1/ReflectInputBytes
add wave -noupdate -expand -group 1 /generic_crc_tb/inst1/ReflectChecksums
add wave -noupdate -expand -group 1 /generic_crc_tb/inst1/ReflectByte
add wave -noupdate /generic_crc_tb/inst1/d
add wave -noupdate -expand -group 2 /generic_crc_tb/inst2/checksum
add wave -noupdate -expand -group 2 /generic_crc_tb/inst2/Polynomial
add wave -noupdate -expand -group 2 /generic_crc_tb/inst2/InitialConditions
add wave -noupdate -expand -group 2 /generic_crc_tb/inst2/ReflectInputBytes
add wave -noupdate -expand -group 2 /generic_crc_tb/inst2/ReflectChecksums
add wave -noupdate -expand -group 2 /generic_crc_tb/inst2/ReflectByte
add wave -noupdate /generic_crc_tb/inst2/d
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {134 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 197
configure wave -valuecolwidth 107
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
WaveRestoreZoom {100 ns} {301 ns}
