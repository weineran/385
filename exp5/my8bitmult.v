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
// CREATED		"Tue Feb 24 14:09:07 2015"

module my8bitmult(
	CLR_LDB,
	Reset,
	Run,
	Clk,
	Reset2,
	Switches
);


input wire	CLR_LDB;
input wire	Reset;
input wire	Run;
input wire	Clk;
input wire	Reset2;
input wire	[7:0] Switches;

wire	[8:0] s;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[7:0] SYNTHESIZED_WIRE_2;
wire	[7:0] SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;

/* push buttons are active low */
wire CLR_LDB_h = ~CLR_LDB;
wire Reset_h = ~Reset;
wire Run_h = ~Run;
wire Reset2_h = ~Reset2;


assign	SYNTHESIZED_WIRE_7 = 1;
assign	SYNTHESIZED_WIRE_8 = 1;
assign	SYNTHESIZED_WIRE_9 = 0;





control	b2v_inst(
	.Clk(Clk),
	.Reset(Reset_h),
	.Run(Run_h),
	.ClearA_LoadB(CLR_LDB_h),
	.M(SYNTHESIZED_WIRE_0),
	
	.Clr_ld(SYNTHESIZED_WIRE_14),
	.Shift(SYNTHESIZED_WIRE_15),
	.Add(SYNTHESIZED_WIRE_12),
	.Sub(SYNTHESIZED_WIRE_1)
	
	
	
	
	);


ADD_SUB9	b2v_inst1(
	.fn(SYNTHESIZED_WIRE_1),
	.A(SYNTHESIZED_WIRE_2),
	.B(SYNTHESIZED_WIRE_3),
	.S(s));


reg_8	b2v_inst10(
	.Clk(Clk),
	.Reset(Reset_h),
	.Shift_In(SYNTHESIZED_WIRE_4),
	.Load(SYNTHESIZED_WIRE_14),
	.Shift_En(SYNTHESIZED_WIRE_15),
	.D(Switches),
	.Shift_Out(SYNTHESIZED_WIRE_0)
	);




reg_8	b2v_inst2(
	.Clk(Clk),
	.Reset(Reset2_h),
	
	.Load(SYNTHESIZED_WIRE_7),
	
	.D(Switches),
	
	.Data_out(SYNTHESIZED_WIRE_2));



DeeFF	b2v_inst5(
	.Clk(Clk),
	.Load(SYNTHESIZED_WIRE_8),
	.Reset(SYNTHESIZED_WIRE_9),
	.D(s[8]),
	.Q(SYNTHESIZED_WIRE_11));


reg_8	b2v_inst9(
	.Clk(Clk),
	.Reset(SYNTHESIZED_WIRE_14),
	.Shift_In(SYNTHESIZED_WIRE_11),
	.Load(SYNTHESIZED_WIRE_12),
	.Shift_En(SYNTHESIZED_WIRE_15),
	.D(s[7:0]),
	.Shift_Out(SYNTHESIZED_WIRE_4),
	.Data_out(SYNTHESIZED_WIRE_3));


endmodule
