transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/Router.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/Reg_8.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/Control.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/compute.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/Register_unit.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/Processor.sv}

vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/Logic_Processor {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/Logic_Processor/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
