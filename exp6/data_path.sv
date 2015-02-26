import lc3b_types::*;

module data_path
(
	//input logic [15:0] S,
	input logic Clk, Reset, Run, Continue, load_ir, load_pc, load_mdr,load_mar,
	input logic GatePC,GateMDR,
	//output logic [11:0] LED,
	output logic [15:0] ADDR,		// MIGHT NEED TO CHANGE THIS BACK TO 20 BITS
	inout logic [15:0] Data
);

logic [15:0] mdr_out;
logic [15:0] pc_out;
logic [15:0] pc_in;

ir inst_reg
(
	.clk(Clk),
	.load(load_ir),
	.in(Data)
);

register mdr
(
	.clk(Clk),
	.load(load_mdr),
	.in(Data),
	.out(mdr_out)
);

register pc
(
	.clk(Clk),
	.load(load_pc),
	.in(pc_in),
	.out(pc_out)
);

plus1 add_pc
(
	.in(pc_out),
	.out(pc_in) //address going back into PC
);

register #(.width(16))mar
(
	.clk(Clk),
	.load(load_mar),
	.in({Data}),
	.out(ADDR)
);

tri_buff mdr_buff
(
	.in(mdr_out),
	.sel(GateMDR),
	.out(Data)
);

tri_buff pc_buff
(
	.in(pc_out),
	.sel(GatePC),
	.out(Data)
);


endmodule




















