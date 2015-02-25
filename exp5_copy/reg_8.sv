module reg_8 
(
	input Clk, Reset, Shift_In, Load, Shift_En,
	input [7:0] D,
	output Shift_Out,
	output logic [7:0] Data_out
);

always_ff @ (posedge Clk or posedge Load or posedge Reset)
begin
	if (Reset) 				// Asynchronous Reset
		Data_out <= 8'h0; // All your data storage should have a
	else if (Load) 		// construct that looks like this
		Data_out <= D;
	else if (Shift_En)
		Data_out <= { Shift_In, Data_out[7:1] };
end
assign Shift_Out = Data_out[0];

endmodule

