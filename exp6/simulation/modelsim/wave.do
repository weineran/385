onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label IR_data /testbench/slc3/the_data_path/inst_reg/data
add wave -noupdate -label PC_data /testbench/slc3/the_data_path/pc/data
add wave -noupdate -label MAR_data /testbench/slc3/the_data_path/mar/data
add wave -noupdate -label MDR_data /testbench/slc3/the_data_path/mdr/data
add wave -noupdate -label State /testbench/slc3/the_ISDU/State
add wave -noupdate -label Registers -childformat {{{/testbench/slc3/the_data_path/the_regfile/data[2]} -radix decimal} {{/testbench/slc3/the_data_path/the_regfile/data[1]} -radix decimal}} -expand -subitemconfig {{/testbench/slc3/the_data_path/the_regfile/data[2]} {-height 16 -radix decimal} {/testbench/slc3/the_data_path/the_regfile/data[1]} {-height 16 -radix decimal}} /testbench/slc3/the_data_path/the_regfile/data
add wave -noupdate /testbench/slc3/the_data_path/the_regfile/load
add wave -noupdate -radix decimal /testbench/slc3/the_data_path/the_regfile/in
add wave -noupdate /testbench/slc3/the_data_path/the_regfile/src_a
add wave -noupdate /testbench/slc3/the_data_path/the_regfile/src_b
add wave -noupdate /testbench/slc3/the_data_path/the_regfile/dest
add wave -noupdate /testbench/slc3/the_data_path/the_regfile/reg_a
add wave -noupdate /testbench/slc3/the_data_path/the_regfile/reg_b
add wave -noupdate /testbench/slc3/the_data_path/ALU_buff/in
add wave -noupdate /testbench/slc3/the_data_path/ALU_buff/sel
add wave -noupdate /testbench/slc3/the_data_path/ALU_buff/out
add wave -noupdate /testbench/slc3/the_data_path/the_alu/aluop
add wave -noupdate /testbench/slc3/the_data_path/the_alu/a
add wave -noupdate /testbench/slc3/the_data_path/the_alu/b
add wave -noupdate /testbench/slc3/the_data_path/the_alu/f
add wave -noupdate /testbench/slc3/the_data_path/sr2mux/sel
add wave -noupdate /testbench/slc3/the_data_path/sr2mux/a
add wave -noupdate /testbench/slc3/the_data_path/sr2mux/b
add wave -noupdate /testbench/slc3/the_data_path/sr2mux/f
add wave -noupdate -label IR_data /testbench/slc3/the_data_path/inst_reg/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2987909 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 458
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
WaveRestoreZoom {0 ps} {200068 ps}
