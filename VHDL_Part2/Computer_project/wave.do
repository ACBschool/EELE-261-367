onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/clock
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/reset
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/current_state
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/IR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {464296 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 422
configure wave -valuecolwidth 60
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {393984 ps} {508852 ps}
