onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/Clk
add wave -noupdate /testbench/Reset
add wave -noupdate /testbench/Run
add wave -noupdate /testbench/CLR_LDB
add wave -noupdate /testbench/Switches
add wave -noupdate /testbench/my8bitmult/b2v_inst/Clk
add wave -noupdate /testbench/my8bitmult/b2v_inst/Reset
add wave -noupdate /testbench/my8bitmult/b2v_inst/Run
add wave -noupdate /testbench/my8bitmult/b2v_inst/ClearA_LoadB
add wave -noupdate /testbench/my8bitmult/b2v_inst/M
add wave -noupdate /testbench/my8bitmult/b2v_inst/Clr_ld
add wave -noupdate /testbench/my8bitmult/b2v_inst/Shift
add wave -noupdate /testbench/my8bitmult/b2v_inst/Add
add wave -noupdate /testbench/my8bitmult/b2v_inst/Sub
add wave -noupdate /testbench/my8bitmult/b2v_inst/curr_state
add wave -noupdate /testbench/my8bitmult/b2v_inst/next_state
add wave -noupdate /testbench/my8bitmult/b2v_inst10/Clk
add wave -noupdate /testbench/my8bitmult/b2v_inst10/Reset
add wave -noupdate /testbench/my8bitmult/b2v_inst10/Shift_In
add wave -noupdate /testbench/my8bitmult/b2v_inst10/Load
add wave -noupdate /testbench/my8bitmult/b2v_inst10/Shift_En
add wave -noupdate /testbench/my8bitmult/b2v_inst10/D
add wave -noupdate /testbench/my8bitmult/b2v_inst10/Shift_Out
add wave -noupdate -label {Data_out B} /testbench/my8bitmult/b2v_inst10/Data_out
add wave -noupdate /testbench/my8bitmult/b2v_inst9/D
add wave -noupdate -label {Data_out A} /testbench/my8bitmult/b2v_inst9/Data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {150330 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
configure wave -valuecolwidth 79
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
WaveRestoreZoom {0 ps} {1050 ns}
