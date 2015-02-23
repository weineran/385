module DFF 
(
	input Clk, Load, Reset, D,
	output logic Q
);

always @ (posedge Clk or poseedge Reset)
begin
	Q <= Q;
	if(Reset)
		Q <= 1'b0;
	else
		if (Load)
			Q <= D;
end
endmodule
