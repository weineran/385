module cra_datapath
(
	input logic Clk, Reset, Load_B, Run,
	input logic [15:0] SW,

	output logic C_out,
	output logic [15:0] Sum_out, reg_out,
	output logic [6:0] Ahex0, Ahex1, Ahex2, Ahex3, Bhex0, Bhex1, Bhex2, Bhex3
);

// internal signals
// logic [16:0] reg_out;
logic [16:0] R;
logic Reset_h, LoadB_h, Run_h, reg_load;

	always_comb
    begin
        Reset_h = ~Reset;  // The push buttons are active low,
        LoadB_h = ~Load_B;  // to work with
        Run_h = ~Run;
    end

// modules
control control_unit
(
	.Clk(Clk),
	.Reset(Reset_h),
	.LoadB(LoadB_h),
	.Run(Run_h),
	.C_out(C_out),
	.SW(SW),
	.Sum(Sum_out[15:0]),
	.Ld_B(reg_load),
	.to_reg(R)
);

adder16 myadder
(
	.A(SW),
	.B(reg_out[15:0]), 
	.Cin(1'b0),
	.S(Sum_out[15:0]),
	.Cout(C_out)
);

reg_17 myregister
(
	.Clk(Clk),
	.Reset(Reset_h),
	.Shift_In(1'b0),
	.Load(reg_load),
	.Shift_En(1'b0),
	.D(R),
	.Shift_Out(1'b0),
	.Data_Out(reg_out)
);

HexDriver Ahex0_mod
(
	.In0(SW[3:0]),
	.Out0(Ahex0)
);

HexDriver Ahex1_mod
(
	.In0(SW[7:4]),
	.Out0(Ahex1)
);

HexDriver Ahex2_mod
(
	.In0(SW[11:8]),
	.Out0(Ahex2)
);

HexDriver Ahex3_mod
(
	.In0(SW[15:12]),
	.Out0(Ahex3)
);

HexDriver Bhex0_mod
(
	.In0(reg_out[3:0]),
	.Out0(Bhex0)
);

HexDriver Bhex1_mod
(
	.In0(reg_out[7:4]),
	.Out0(Bhex1)
);

HexDriver Bhex2_mod
(
	.In0(reg_out[11:8]),
	.Out0(Bhex2)
);

HexDriver Bhex3_mod
(
	.In0(reg_out[15:12]),
	.Out0(Bhex3)
);

endmodule