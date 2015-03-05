onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label IR_data /testbench/slc3/the_data_path/inst_reg/data
add wave -noupdate -label pc_mux_out /testbench/slc3/the_data_path/pc_mux/f
add wave -noupdate -label pc_in -radix decimal /testbench/slc3/the_data_path/pc/in
add wave -noupdate -label load_pc /testbench/slc3/the_data_path/load_pc
add wave -noupdate -label PC_data /testbench/slc3/the_data_path/pc/data
add wave -noupdate -label GateMAR_in /testbench/slc3/the_data_path/marmux_buff/in
add wave -noupdate -label GateMAR_out /testbench/slc3/the_data_path/marmux_buff/out
add wave -noupdate -label load_MAR /testbench/slc3/the_data_path/mar/load
add wave -noupdate -label MAR_in /testbench/slc3/the_data_path/mar/in
add wave -noupdate -label MAR_data /testbench/slc3/the_data_path/mar/data
add wave -noupdate -label MDR_data /testbench/slc3/the_data_path/mdr/data
add wave -noupdate -label State /testbench/slc3/the_ISDU/State
add wave -noupdate -label Registers -childformat {{{/testbench/slc3/the_data_path/the_regfile/data[2]} -radix decimal} {{/testbench/slc3/the_data_path/the_regfile/data[1]} -radix decimal}} -expand -subitemconfig {{/testbench/slc3/the_data_path/the_regfile/data[2]} {-height 16 -radix decimal} {/testbench/slc3/the_data_path/the_regfile/data[1]} {-height 16 -radix decimal}} /testbench/slc3/the_data_path/the_regfile/data
add wave -noupdate -label IR_data /testbench/slc3/the_data_path/inst_reg/data
add wave -noupdate -label Switches -radix hexadecimal /testbench/slc3/Switches
add wave -noupdate -label OpCode /testbench/slc3/the_ISDU/Opcode
add wave -noupdate -label opcode /testbench/slc3/the_data_path/opcode
add wave -noupdate -label adder_output /testbench/slc3/the_data_path/the_adder/address
add wave -noupdate -label adder_PC_in /testbench/slc3/the_data_path/the_adder/PC
add wave -noupdate -label adder_offset_in /testbench/slc3/the_data_path/the_adder/PCoffset
add wave -noupdate /testbench/slc3/the_data_path/addr2mux/sel
add wave -noupdate /testbench/slc3/the_data_path/addr2mux/a
add wave -noupdate /testbench/slc3/the_data_path/addr2mux/b
add wave -noupdate /testbench/slc3/the_data_path/addr2mux/c
add wave -noupdate /testbench/slc3/the_data_path/addr2mux/d
add wave -noupdate /testbench/slc3/the_data_path/addr2mux/f
add wave -noupdate -radix hexadecimal /testbench/slc3/the_Mem2IO/Data_CPU
add wave -noupdate -label hex0 /testbench/slc3/the_Mem2IO/HEX0
add wave -noupdate -label hex1 /testbench/slc3/the_Mem2IO/HEX1
add wave -noupdate -label hex2 /testbench/slc3/the_Mem2IO/HEX2
add wave -noupdate -label hex3 /testbench/slc3/the_Mem2IO/HEX3
add wave -noupdate -radix hexadecimal /testbench/slc3/LED
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {457633 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 146
configure wave -valuecolwidth 100
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
WaveRestoreZoom {9822234 ps} {10009356 ps}
