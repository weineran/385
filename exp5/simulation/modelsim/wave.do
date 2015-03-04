onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/Clk
add wave -noupdate -label Reset_h /testbench/my8bitmult/Reset_h
add wave -noupdate -label CLR_LDB_h /testbench/my8bitmult/CLR_LDB_h
add wave -noupdate -label Run_h /testbench/my8bitmult/Run_h
add wave -noupdate -label mult_Switches -radix decimal /testbench/my8bitmult/Switches
add wave -noupdate -label B_reset /testbench/my8bitmult/b2v_inst10/Reset
add wave -noupdate -label B_shift_in /testbench/my8bitmult/b2v_inst10/Shift_In
add wave -noupdate -label B_load /testbench/my8bitmult/b2v_inst10/Load
add wave -noupdate -label B_shift_en /testbench/my8bitmult/b2v_inst10/Shift_En
add wave -noupdate -label Add /testbench/my8bitmult/b2v_inst/Add
add wave -noupdate -label A_load /testbench/my8bitmult/b2v_inst9/Load
add wave -noupdate -label A_data_out -radix binary /testbench/my8bitmult/b2v_inst9/Data_out
add wave -noupdate -label A_data_out -radix decimal /testbench/my8bitmult/b2v_inst9/Data_out
add wave -noupdate -label B_data_out /testbench/my8bitmult/b2v_inst10/Data_out
add wave -noupdate -label curr_state /testbench/my8bitmult/b2v_inst/curr_state
add wave -noupdate -label next_state /testbench/my8bitmult/b2v_inst/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {194445 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 152
configure wave -valuecolwidth 114
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
WaveRestoreZoom {1405577 ps} {1777242 ps}
