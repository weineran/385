module tri_buff
(
	input [15:0] in,
	input sel,
	output [15:0] out
	
);


always_comb
begin
	if (sel==0)
		out = 16'bZZZZZZZZZZZZZZZZ;
	else
		out = in;
end


endmodule
