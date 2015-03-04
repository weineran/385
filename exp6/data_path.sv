import lc3b_types::*;

module data_path
(
	//input logic [15:0] S,
	input logic Clk, Reset, Run, Continue, load_ir, load_pc, load_mdr,load_mar,
	input logic [1:0] pc_sel, 
	//output logic [11:0] LED,
	output logic [19:0] ADDR,
	inout logic [15:0] Data
);

logic [15:0] mdr_out;
logic [15:0] pc_out;
logic [15:0] pc_in;
logic [15:0] pc_mux_out;
logic [15:0] decode_mux_out;


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
	.in(pc_mux_out),
	.out(pc_out)
);

plus1 add_pc
(
	.in(pc_out),
	.out(pc_in) //address going back into PC
);

register #(.width(20))mar
(
	.clk(Clk),
	.load(load_mar),
	.in({4'b0000,Data}),
	.out(ADDR)
);

tri_buff mdr_buff
(
	.in(mdr_out),
	.sel(load_mdr),
	.out(Data)
);

tri_buff pc_buff
(
	.in(pc_out),
	.sel(load_pc),
	.out(Data)
);

mux4 pc_mux
(
	.a(Data),
	.b(pc_in),
	.c(decode_mux_out), 		// still figuring out preceeding logic for this input
	.d(16b'0000000000000000),
	.sel(pc_sel),
	.f(pc_mux_out)
);



endmodule




















