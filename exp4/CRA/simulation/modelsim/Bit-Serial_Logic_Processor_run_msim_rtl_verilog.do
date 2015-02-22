transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/CRA {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/CRA/control.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/CRA {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/CRA/Reg_17.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/CRA {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/CRA/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/CRA {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/CRA/full_adder.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/CRA {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/CRA/adder16.sv}
vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/CRA {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/CRA/cra_datapath.sv}

vlog -sv -work work +incdir+C:/Users/Andrew/Documents/Box\ Sync/UIUC/ECE385\ Digital\ Systems\ Lab/Experiment_4/CRA {C:/Users/Andrew/Documents/Box Sync/UIUC/ECE385 Digital Systems Lab/Experiment_4/CRA/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_cra

add wave *
view structure
view signals
run 1000 ns
