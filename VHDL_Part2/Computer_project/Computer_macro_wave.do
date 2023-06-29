onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/clock
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/reset
add wave -noupdate -divider {Control Unit}
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/current_state
add wave -noupdate -divider {Instruction Register}
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/IR
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/IR_Load
add wave -noupdate -divider {Memory Address Register}
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/MAR_Load
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/MAR
add wave -noupdate -divider {Program Counter}
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/PC_Load
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/PC_Inc
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/PC
add wave -noupdate -divider {General Purpose Register}
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/A_Load
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/B_load
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/A
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/B
add wave -noupdate -divider {Bus System}
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/from_memory
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/to_memory
add wave -noupdate /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/Bus1_Sel
add wave -noupdate /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/Bus2_Sel
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/Bus2
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/Bus1
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/write
add wave -noupdate -divider Ports
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/MEMORY_inst/port_in_00
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/MEMORY_inst/port_out_00
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/MEMORY_inst/port_in_01
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/MEMORY_inst/port_out_01
add wave -noupdate -divider {ALU signals}
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/ALU_Sel
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/CCR_Load
add wave -noupdate /computer_tb/DUT1/CPU_inst/CTRL_UNT_Inst/CCR_Result
add wave -noupdate -radix hexadecimal /computer_tb/DUT1/CPU_inst/DATA_PATH_inst/ALU_Result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1414788 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 170
configure wave -valuecolwidth 61
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
WaveRestoreZoom {1385278 ps} {1506039 ps}
