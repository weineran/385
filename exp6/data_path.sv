import lc3b_types::*;

module data_path
(
	//input logic [15:0] S,
	/* inputs from control */
	input logic Clk, Reset, Run, Continue, load_ir, load_pc, load_mdr,load_mar,
	input logic [1:0] pc_sel, 
	input lc3b_aluop ALUK,
	input logic GatePC,GateMDR,GateALU,
	input logic SR2_mux_sel,
	input logic ld_reg,
	
	/* output to memory */
	//output logic [11:0] LED,
	output logic [15:0] ADDR,
	output lc3b_opcode opcode,
	inout logic [15:0] Data,
	
	/* output to Control */
	output logic BEN,	imm5_sel_out
);

logic [15:0] mdr_out;
logic [15:0] pc_out;
logic [15:0] pc_in;
logic [15:0] pc_mux_out;
logic [15:0] decode_mux_out;
logic [15:0] ALU_out;


lc3b_nzp data_cc;
lc3b_word SR1_out;
lc3b_word SR2_out;
lc3b_word SR2_mux_out;
lc3b_word imm5_sext;
lc3b_imm5 imm5_out;
lc3b_reg dest_out;
lc3b_reg src1_out;
lc3b_reg scr2_out;


ir inst_reg
(
	.clk(Clk),
	.load(load_ir),
	.in(Data),
	.imm5_out(imm5_out),
	.src1(src1_out),
	.src2(src2_out),
	.dest(dest_out),
	.imm5mux_sel(imm5_sel_out),
	.opcode(opcode)
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

tri_buff ALU_buff
(
	.in(ALU_out),
	.sel(GateALU),
	.out(Data)
);

mux4 pc_mux
(
	.a(Data),
	.b(pc_in),
	.c(decode_mux_out), 		// still figuring out preceeding logic for this input
	.d(16'b0000000000000000),
	.sel(pc_sel),
	.f(pc_mux_out)
);


alu the_alu
(
	 .aluop(ALUK),
	 .a(SR1_out),
	 .b(SR2_mux_out),
	 .f(ALU_out)
);

mux2 sr2mux
(
	.a(SR2_out),
	.b(ir_5_sext),
	.sel(SR2_mux_sel),
	.f(SR2_mux_out)

);

sext the_sext1
(
	.in(imm5_out),
	.out(imm5_sext)
);

regfile the_regfile
(
	.clk(Clk),
	.in(Data),
	.load(ld_reg),
	.src_a(src1_out),
	.src_b(src2_out),
	.dest(dest_out),
	.reg_a(SR1_out),
	.reg_b(SR2_out)
);


gencc the_ccgen
(
	.in(Data),
	.out(data_cc)
);

nzp_comp the_nzp_comp
(
	.nzp_stored(data_cc),
	.nzp_instr(dest_out),
	.should_branch(BEN)
);



endmodule




















