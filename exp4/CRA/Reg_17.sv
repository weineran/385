module reg_17 (input Clk, Reset, Shift_In, Load, Shift_En,
              input  [16:0]  D,
              output        Shift_Out,
              output logic [16:0]  Data_Out);

    always_ff @ (posedge Clk or posedge Load or posedge Reset)
    begin
	 
    if (Reset) 
        Data_Out <= 17'h0;
	 else if (Load)
        Data_Out <= D;
    else if (Shift_En)
        Data_Out <= { Shift_In, Data_Out[16:1] };
    end
	
    assign Shift_Out = Data_Out[0];

endmodule
