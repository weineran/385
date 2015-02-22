onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/Clk
add wave -noupdate /testbench/Reset
add wave -noupdate /testbench/LoadA
add wave -noupdate /testbench/LoadB
add wave -noupdate /testbench/Execute
add wave -noupdate -label Shift_En /testbench/processor0/reg_unit/Shift_En
add wave -noupdate -label Ld_A /testbench/processor0/reg_unit/Ld_A
add wave -noupdate -label Ld_B /testbench/processor0/reg_unit/Ld_B
add wave -noupdate -label curr_state /testbench/processor0/control_unit/curr_state
add wave -noupdate -label next_state /testbench/processor0/control_unit/next_state
add wave -noupdate /testbench/processor0/compute_unit/F
add wave -noupdate -label D /testbench/processor0/reg_unit/D
add wave -noupdate /testbench/processor0/reg_unit/A
add wave -noupdate /testbench/processor0/reg_unit/B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50506 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 51
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
configure wave -timelineunits ns
update
WaveRestoreZoom {223125 ps} {485625 ps}
