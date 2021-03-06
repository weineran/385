module cla_adder
(	
	input [3:0] A, B, 
	input Cin,
	output [3:0] S, P, G
	output Cout
);

		
wire c1, c2, c3;
full_adder_cla FA0
(
	.x(A[0]), 
	.y(B[0]), 
	.z(Cin), 
	.s(S[0]), 
	.c(c1),
	.g(G[0]),
	.p(P[0])
);


full_adder_cla FA1
(
	.x(A[1]), 
	.y(B[1]), 
	.z(c1),  
	.s(S[1]), 
	.c(c2),
	.g(G[1]),
	.p(P[1])
);


full_adder_cla FA2
(
	.x(A[2]), 
	.y(B[2]), 
	.z(c2),  
	.s(S[2]), 
	.c(c3),
	.g(G[2]),
	.p(P[2])
);


full_adder_cla FA3
(
	.x(A[3]), 
	.y(B[3]), 
	.z(c3),  
	.s(S[3]), 
	.c(Cout),
	.g(G[3]),
	.p(P[3])
);
	
endmodule