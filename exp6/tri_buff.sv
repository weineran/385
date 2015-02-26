module tri_buff
(
	input [15:0] in,
	input sel,
	output [15:0] out
	
);

assign out = (sel) ? in : 16'bZZZZZZZZZZZZZZZZ;
endmodule
