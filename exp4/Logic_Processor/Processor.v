// Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 14.1.0 Build 186 12/03/2014 SJ Web Edition"
// CREATED		"Wed Feb 11 22:01:29 2015"

module Processor(
	Clk,
	Reset,
	Load_A,
	Load_B,
	Execute,
	D,
	F,
	R,
	AhexL,
	AhexU,
	Aval,
	BhexL,
	BhexU,
	Bval,
	LED
);


input wire	Clk;
input wire	Reset;
input wire	Load_A;
input wire	Load_B;
input wire	Execute;
input wire	[7:0] D;
input wire	[2:0] F;
input wire	[1:0] R;
output wire	[6:0] AhexL;
output wire	[6:0] AhexU;
output wire	[7:0] Aval;
output wire	[6:0] BhexL;
output wire	[6:0] BhexU;
output wire	[7:0] Bval;
output wire	[3:0] LED;

wire	[7:0] A;
wire	[7:0] B;
wire	[3:0] LED_ALTERA_SYNTHESIZED;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;





register_unit	b2v_inst(
	.Clk(Clk),
	.Reset(LED_ALTERA_SYNTHESIZED[0]),
	.A_In(SYNTHESIZED_WIRE_0),
	.B_In(SYNTHESIZED_WIRE_1),
	.Ld_A(SYNTHESIZED_WIRE_2),
	.Ld_B(SYNTHESIZED_WIRE_3),
	.Shift_En(SYNTHESIZED_WIRE_4),
	.D(D),
	.A_out(SYNTHESIZED_WIRE_5),
	.B_out(SYNTHESIZED_WIRE_6),
	.A(A),
	.B(B));


compute	b2v_inst1(
	.A_In(SYNTHESIZED_WIRE_5),
	.B_In(SYNTHESIZED_WIRE_6),
	.F(F),
	.A_Out(SYNTHESIZED_WIRE_7),
	.B_Out(SYNTHESIZED_WIRE_8),
	.F_A_B(SYNTHESIZED_WIRE_9));

assign	LED_ALTERA_SYNTHESIZED[1] =  ~Load_B;

assign	LED_ALTERA_SYNTHESIZED[3] =  ~Execute;


router	b2v_inst2(
	.A_In(SYNTHESIZED_WIRE_7),
	.B_In(SYNTHESIZED_WIRE_8),
	.F_A_B(SYNTHESIZED_WIRE_9),
	.R(R),
	.A_Out(SYNTHESIZED_WIRE_0),
	.B_Out(SYNTHESIZED_WIRE_1));


control	b2v_inst3(
	.Clk(Clk),
	.Reset(LED_ALTERA_SYNTHESIZED[0]),
	.LoadA(LED_ALTERA_SYNTHESIZED[2]),
	.LoadB(LED_ALTERA_SYNTHESIZED[1]),
	.Execute(LED_ALTERA_SYNTHESIZED[3]),
	.Shift_En(SYNTHESIZED_WIRE_4),
	.Ld_A(SYNTHESIZED_WIRE_2),
	.Ld_B(SYNTHESIZED_WIRE_3));


HexDriver	b2v_inst4(
	.In0(B[3:0]),
	.Out0(BhexL));


HexDriver	b2v_inst5(
	.In0(B[7:4]),
	.Out0(BhexU));


HexDriver	b2v_inst6(
	.In0(A[3:0]),
	.Out0(AhexL));


HexDriver	b2v_inst7(
	.In0(A[7:4]),
	.Out0(AhexU));

assign	LED_ALTERA_SYNTHESIZED[0] =  ~Reset;

assign	LED_ALTERA_SYNTHESIZED[2] =  ~Load_A;

assign	Aval = A;
assign	Bval = B;
assign	LED = LED_ALTERA_SYNTHESIZED;

endmodule
