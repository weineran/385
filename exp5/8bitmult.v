// Copyright (C) 1991-2014 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 32-bit"
// VERSION		"Version 13.1.4 Build 182 03/12/2014 SJ Full Version"
// CREATED		"Mon Feb 23 19:31:32 2015"

module \8bitmult (
	CLR_LDB,
	Reset,
	Run,
	Clk,
	Reset2,
	Switches,
	A,
	B
);


input wire	CLR_LDB;
input wire	Reset;
input wire	Run;
input wire	Clk;
input wire	Reset2;
input wire	[7:0] Switches;
output wire	[7:0] A;
output wire	[7:0] B;

wire	[8:0] S;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_11;

assign	A = SYNTHESIZED_WIRE_3;
assign	SYNTHESIZED_WIRE_7 = 1;




control	b2v_inst(
	.Clk(Clk),
	.Reset(Reset),
	.Run(Run),
	.ClearA_LoadB(CLR_LDB),
	.M(SYNTHESIZED_WIRE_0),
	
	.Clr_ld(SYNTHESIZED_WIRE_12),
	.Shift(SYNTHESIZED_WIRE_11),
	.Add(SYNTHESIZED_WIRE_13),
	.Sub(SYNTHESIZED_WIRE_1)
	
	
	
	
	);


ADD_SUB9	b2v_inst1(
	.fn(SYNTHESIZED_WIRE_1),
	.A(SYNTHESIZED_WIRE_2),
	.B(SYNTHESIZED_WIRE_3),
	.S(S));


reg_8	b2v_inst10(
	.Clk(Clk),
	.Reset(Reset),
	.Shift_In(SYNTHESIZED_WIRE_4),
	.Load(SYNTHESIZED_WIRE_12),
	.Shift_En(SYNTHESIZED_WIRE_13),
	.D(Switches),
	.Shift_Out(SYNTHESIZED_WIRE_0),
	.Data_out(B));



DFF	b2v_inst14(
	.Clk(Clk),
	
	
	.D(S[8]),
	.Q(SYNTHESIZED_WIRE_9));


reg_8	b2v_inst2(
	.Clk(Clk),
	.Reset(Reset2),
	
	.Load(SYNTHESIZED_WIRE_7),
	
	.D(Switches),
	
	.Data_out(SYNTHESIZED_WIRE_2));


reg_8	b2v_inst9(
	.Clk(Clk),
	.Reset(SYNTHESIZED_WIRE_12),
	.Shift_In(SYNTHESIZED_WIRE_9),
	.Load(SYNTHESIZED_WIRE_13),
	.Shift_En(SYNTHESIZED_WIRE_11),
	.D(S[7:0]),
	.Shift_Out(SYNTHESIZED_WIRE_4),
	.Data_out(SYNTHESIZED_WIRE_3));


endmodule
