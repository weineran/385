module sixteen_bit_cla
(
	input [15:0] A, B,
	input Cin,
	output [15:0] S,
	output Cout, carry16bit
);

wire [15:0] c

cla_adder CLA0
(
	.A(A[3:0]),
	.B(B[3:0]),
	.Cin(Cin),
	.S(S[3:0]),
	.P(P[3:0])
);


cla_adder CLA1
(
	.A(A[8:4]),
	.B(B[8:4]),
	.Cin(Cin),
	.S(S[8:4]),
	.P(P[8:4])
);


cla_adder CLA2
(
	.A(A[8:4]),
	.B(B[8:4]),
	.Cin(Cin),
	.S(S[8:4]),
	.P(P[8:4])
);


cla_adder CLA3
(
	.A(A[8:4]),
	.B(B[8:4]),
	.Cin(Cin),
	.S(S[8:4]),
	.P(P[8:4])
);
