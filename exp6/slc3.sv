module slc3
(
	// inputs from user
	input logic [15:0] Switches,
	input logic Clk, Reset, Run, Continue,
	input logic BEN
	
	// outputs to FPGA
	//output logic [11:0] LED,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3	
	
);

// declare internal signals here
logic load_ir, load_pc, load_mdr, load_mar;
logic ce_int, ub_int, lb_int, oe_int, we_int;
logic gatePC, gateMDR; 
//logic [6:0] HEX0, HEX1, HEX2, HEX3;
//logic [11:0] LED;
wire [15:0] Bus_CPU;
wire [15:0] Bus_MEM;	
wire Reset_h = ~Reset;
wire Run_h = ~Run;
wire Continue_h = ~Continue;
wire [15:0] addr_int;	// MIGHT NEED TO CHANGE THIS BACK TO 20 BITS


data_path the_data_path
(
	// inputs from user
	//.S(S),
	.Clk(Clk), .Reset(Reset_h), .Run(Run_h), .Continue(Continue_h),

	// inputs from ISDU (control)
	.load_ir(load_ir), .load_pc(load_pc), .load_mdr(load_mdr), .load_mar(load_mar),
	.GatePC(gatePC),.GateMDR(gateMDR),
	
	// outputs to FPGA board
	//.LED(LED),

	// outputs to memory
	.ADDR(addr_int),
	
	// inout
	.Data(Bus_CPU)
);

ISDU the_ISDU
(
	// inputs from user
	.Clk(Clk), .Reset(Reset_h), .Run(Run_h), .Continue(Continue_h),
	
	.ContinueIR(Continue_h),	// what is this?
	
	// input from data_path
	.Opcode(), .IR_5(),

	// output to data_path
	.LD_MAR(load_mar), .LD_MDR(load_mdr), .LD_IR(load_ir),
	.LD_BEN(), .LD_CC(), .LD_REG(),
	.LD_PC(load_pc),
	.GatePC(gatePC), .GateMDR(gateMDR), .GateALU(),
	.GateMARMUX(),
	.PCMUX(), .DRMUX(),
	.SR1MUX(),
	.SR2MUX(),
	.ADDR1MUX(),
	.ADDR2MUX(),
	.MARMUX(),
	.ALUK(),
	.Mem_CE(ce_int),
	.Mem_UB(ub_int),
	.Mem_LB(lb_int),
	.Mem_OE(oe_int),
	.Mem_WE(we_int)
);

Mem2IO the_Mem2IO
(
	.Clk(Clk), .Reset(Reset_h),
	.A(addr_int), 
	.CE(ce_int), .UB(ub_int), .LB(lb_int), .OE(oe_int), .WE(we_int),
	.Switches(Switches),
	.Data_CPU(Bus_CPU), .Data_Mem(Bus_MEM),
	.HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3) 
);

test_memory the_test_memory
(
	.Clk(Clk),
	.Reset(Reset_h), 
   .I_O(Bus_MEM),
   .A(addr_int),
   .CE(ce_int),
   .UB(ub_int),
   .LB(lb_int),
   .OE(oe_int),
   .WE(we_int) 


);



endmodule
