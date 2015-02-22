module full_adder_cla 
(
	input x,y,z
	output s, c, g, p
);
						 
	assign s = x^y^z;
	assign c = (x&y)|(y&z)|(x&z);
	assign g = x&y;
	assign p = x^y;

endmodule
