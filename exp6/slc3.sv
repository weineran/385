module slc3
(
	// inputs from user
	input logic [15:0] S,
	input logic Clk, Reset, Run, Continue,
	
	// outputs to FPGA
	output logic [11:0] LED,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3	
	
);

// declare internal signals here
logic load_ir, load_pc, load_mdr, load_mar; 
//logic [6:0] HEX0, HEX1, HEX2, HEX3;
//logic [11:0] LED;
wire [15:0] Bus;	


data_path the_data_path
(
	// inputs from user
	.S(S),
	.Clk(Clk), .Reset(Reset), .Run(Run), .Continue(Continue),

	// inputs from ISDU (control)
	.load_ir(load_ir), .load_pc(load_pc), .load_mdr(load_mdr),
	
	// outputs to FPGA board
	//.LED(LED),

	// outputs to memory?
	.CE(), .UB(), .LB(), .OE(), .WE(),
	.ADDR(),
	
	// inout
	.Data(Bus)
);

ISDU the_ISDU
(
	// inputs from user
	.Clk(Clk), .Reset(Reset), .Run(Run), .Continue(Continue),
	
	.ContinueIR(),	// what is this?
	
	// input from data_path
	.Opcode(), .IR_5(),

	// output to data_path
	.LD_MAR(load_mar), .LD_MDR(load_mdr), .LD_IR(load_ir),
	.LD_BEN(), .LD_CC(), .LD_REG(),
	.LD_PC(load_pc),
	.GatePC(), .GateMDR(), .GateALU(),
	.GateMARMUX(),
	.PCMUX(), .DRMUX(),
	.SR1MUX(),
	.SR2MUX(),
	.ADDR1MUX(),
	.ADDR2MUX(),
	.MARMUX(),
	.ALUK(),
	.Mem_CE(),
	.Mem_UB(),
	.Mem_LB(),
	.Mem_OE(),
	.Mem_WE()
);

Mem2IO the_Mem2IO
(
	.Clk(Clk), .Reset(Reset),
	.A(), 
	.CE(), .UB(), .LB(), .OE(), .WE(),
	.Switches(S),
	.Data_CPU(Bus), .Data_Mem(),
	.HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3) 
);

test_memory the_test_memory
(
	.Clk(Clk),
	.Reset(Reset), 
   .I_O(Bus),
   .A(),
   .CE(),
   .UB(),
   .LB(),
   .OE(),
   .WE() 


);



endmodule
