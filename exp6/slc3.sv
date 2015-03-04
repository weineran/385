import lc3b_types::*;

module slc3
(
	// inputs from user
	input logic [15:0] Switches,
	input logic Clk, Reset, Run, Continue, 
	
	// outputs to FPGA
	output logic [11:0] LED,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3	
	
);

// declare internal signals here
logic load_ir, load_pc, load_mdr, load_mar, load_regfile;
logic ce_int, ub_int, lb_int, oe_int, we_int;
logic SR2_mux_sel;
logic gatePC, gateMDR, gateALU; 
logic [1:0] pc_sel;
lc3b_aluop ALUK;
lc3b_opcode opcode;
logic ir_5;
logic [3:0] HEX0_4b, HEX1_4b, HEX2_4b, HEX3_4b;
logic BEN;
//logic [11:0] LED;
wire [15:0] Bus_CPU;
wire [15:0] Bus_MEM;	
wire Reset_h = ~Reset;
wire Run_h = ~Run;
wire Continue_h = ~Continue;
wire [19:0] addr_int;	// MIGHT NEED TO CHANGE THIS BACK TO 20 BITS


data_path the_data_path
(
	// inputs from user
	//.S(S),
	.Clk(Clk), .Reset(Reset_h), .Run(Run_h), .Continue(Continue_h),

	// inputs from ISDU (control)
	.load_ir(load_ir), .load_pc(load_pc), .load_mdr(load_mdr), .load_mar(load_mar),
	.GatePC(gatePC),.GateMDR(gateMDR),
	.ld_reg(load_regfile),
	.SR2_mux_sel(SR2_mux_sel),
	.GateALU(gateALU),
	.ALUK(ALUK),
	.pc_sel(pc_sel),
	
	
	// outputs to FPGA board
	//.LED(LED),

	// outputs to memory
	.ADDR(addr_int),
	.opcode(opcode),
	.imm5_sel_out(ir_5),
	.BEN(BEN),
	// inout
	.Data(Bus_CPU)
);

ISDU the_ISDU
(
	// inputs from user
	.Clk(Clk), .Reset(Reset_h), .Run(Run_h), .Continue(Continue_h),
	
	.ContinueIR(Continue_h),	// what is this?
	
	// input from data_path
	.Opcode(opcode), .IR_5(ir_5), .BEN(BEN),
	
	// output to data_path
	.LD_MAR(load_mar), .LD_MDR(load_mdr), .LD_IR(load_ir),
	.LD_BEN(), .LD_CC(), .LD_REG(load_regfile),
	.LD_PC(load_pc),
	.GatePC(gatePC), .GateMDR(gateMDR), .GateALU(gateALU),
	.GateMARMUX(),
	.PCMUX(pc_sel), .DRMUX(),
	.SR1MUX(),
	.SR2MUX(SR2_mux_sel),
	.ADDR1MUX(),
	.ADDR2MUX(),
	.MARMUX(),
	.ALUK(ALUK),
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
	.HEX0(HEX0_4b), .HEX1(HEX1_4b), .HEX2(HEX2_4b), .HEX3(HEX3_4b) 
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

HexDriver hex_driver0
(
	.In0(HEX0_4b), .Out0(HEX0)
);

HexDriver hex_driver1
(
	.In0(HEX1_4b), .Out0(HEX1)
);

HexDriver hex_driver2
(
	.In0(HEX2_4b), .Out0(HEX2)
);

HexDriver hex_driver3
(
	.In0(HEX3_4b), .Out0(HEX3)
);



endmodule
