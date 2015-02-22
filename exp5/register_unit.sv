module register_unit
(
	input Clk, Reset, A_In, B_In, S_In, Ld_A,Ld_B, Ld_S, Shift_En,
	input [7:0] D,
	output A_out, B_out, S_out,
	output [7:0] A,
	output [7:0] B,
	output [7:0] S
);
// reg_A
reg_8 reg_A (.*, .Shift_In(A_In), .Load(Ld_A),
.Shift_Out(A_out), .Data_Out(A));

// reg_B
reg_8 reg_B (.*, .Shift_In(B_In), .Load(Ld_B),
.Shift_Out(B_out), .Data_Out(B));

// reg_B
reg_8 reg_S (.*, .Shift_In(S_In), .Load(Ld_S),
.Shift_Out(S_out), .Data_Out(S));

endmodule