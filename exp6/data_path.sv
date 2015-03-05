import lc3b_types::*;

module data_path
(
	//input logic [15:0] S,
	/* inputs from control */
	input logic Clk, Reset, Run, Continue, load_ir, load_pc, load_mdr,load_mar, 
	input logic [1:0] pc_sel, 
	input lc3b_aluop ALUK,
	input logic GatePC,GateMDR,GateALU, GateMARMUX,
	input logic SR2_mux_sel,SR1_mux_sel,
	input logic ld_reg,
	input logic [1:0] addr2mux_sel,
	input logic addr1mux_sel,
	
	/* output to memory */
	output logic [11:0] LED,
	output logic [19:0] ADDR,
	output lc3b_opcode opcode,
	inout logic [15:0] Data,
	
	/* output to Control */
	output logic BEN,	imm5_sel_out
);

logic [15:0] mdr_out;
logic [15:0] pc_out;
logic [15:0] pc_in;
logic [15:0] pc_mux_out;
lc3b_word addradd_out;
logic [15:0] ALU_out;

lc3b_nzp data_cc;
lc3b_word SR1_out;
lc3b_word SR2_out;
lc3b_word SR2_mux_out;
lc3b_word ir_5_sext;

/* addr2mux inputs and SEXT */
lc3b_word imm5_sext;
lc3b_word offset9_sext;
lc3b_word offset11_sext;
lc3b_word offset6_sext;
lc3b_imm5 imm5_out;
lc3b_offset9 offset9_out; 
lc3b_offset11 offset11_out; 
lc3b_offset6 offset6_out;
/* output for addr2mux */
lc3b_word addr2mux_out;

/* addr1mux output */
lc3b_word addr1mux_out;

lc3b_reg dest_out;
lc3b_reg src1_out;
lc3b_reg src2_out;

/* output of sr1mux */
lc3b_reg sr1mux_out;


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
	.ledVect12(LED),
	.offset9(offset9_out),
	.offset6(offset6_out),
	.offset11(offset11_out),
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
	.out(pc_in)  //address going back into PC
);

register #(.width(20))mar
(
	.clk(Clk),
	.load(load_mar),
	.in({4'b0000, Data}),
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

tri_buff marmux_buff
(
	.in(addradd_out),
	.sel(GateMARMUX),
	.out(Data)
);


mux4 pc_mux
(
	.a(Data),
	.b(pc_in),
	.c(addradd_out), 		// still figuring out preceeding logic for this input
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
	.b(imm5_sext),
	.sel(SR2_mux_sel),
	.f(SR2_mux_out)

);

mux2 #(.width(3))sr1mux
(
	.a(src2_out),
	.b(dest_out),
	.sel(SR1_mux_sel),
	.f(sr1mux_out)
);


// [4:0]
sext #(.width(5)) the_sext1
(
	.in(imm5_out),
	.out(imm5_sext)
);

/* sign extensions for addr2mux */
// [8:0]
sext #(.width(9)) the_sext2
(
	.in(offset9_out),
	.out(offset9_sext)
);

// [5:0]
sext #(.width(6)) the_sext3
(
	.in(offset6_out),
	.out(offset6_sext)
);
// [10:0]
sext #(.width(11))the_sext4
(
	.in(offset11_out),
	.out(offset11_sext)
);

/* addr2mux inputs are from sexts */ 
mux4 addr2mux
(
	.d(offset11_sext),
	.c(offset9_sext),
	.b(offset6_sext),
	.a(16'b0000000000000000),
	.sel(addr2mux_sel),
	.f(addr2mux_out)
);

adder the_adder
(
	.PC(addr2mux_out),
	.PCoffset(addr1mux_out),
	.address(addradd_out)	
);

mux2 addr1mux
(
	.a(pc_out),
	.b(SR1_out),
	.sel(addr1mux_sel),
	.f(addr1mux_out)
	
);

regfile the_regfile
(
	.clk(Clk),
	.in(Data),
	.load(ld_reg),
	.src_a(sr1mux_out),
	 //.src_a(src1_out),
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




















