import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module control
(
    /* Input and output port declarations */
	 input clk,
	 
	 /* Datapath controls */
	 input lc3b_opcode opcode,
	 input logic branch_enable,
	 input logic ir11, Abit, Dbit, addrBit,				// AW mp2.2 added
	 output logic load_pc,
	 output logic load_ir,
	 output logic load_regfile,
	 output logic load_mar,
	 output logic load_mdr,
	 output logic load_cc,
	 output logic [1:0] pcmux_sel,	// AW mp2.1 modified
	 output logic storemux_sel,
	 output logic pcoffmux_sel,		// AW mp2.2 added
	 output logic destmux_sel,		// AW mp2.2 added
	 output	logic wdatamux_sel,		// mp2.2 added
	 output logic [1:0] alumux_sel,
	 output logic [1:0] regfilemux_sel,	// AW mp2.1 modified
	 output logic [1:0] marmux_sel,		// mp2.2
	 output logic [1:0] mdrmux_sel,		// 1.2 mod
	 output logic a_mux_sel,		// 1.2
	 output lc3b_aluop aluop,
	 /*et cetera */
	 
	 /* Memory signals */
	 input mem_resp,
	 output logic mem_read,
	 output logic mem_write,
	 output lc3b_mem_wmask mem_byte_enable
);

enum int unsigned {
    /* List of states */
	 fetch1,
	 fetch2,
	 fetch3,
	 decode,
	 s_add,
	 s_and,
	 s_not,
	 s_br,
	 s_br_taken,
	 s_calc_addr,
	 s_ldr1,
	 s_ldr2,
	 s_str1,
	 s_str2,
	 s_jmp,				// AW mp2.1 added
	 s_lea,				// AW mp2.1 added
	 s_jsr1,			// AW mp2.2 added
	 s_jsr2,			// AW mp2.2 added
	 s_jsr3,			// AW mp2.2 added
	 s_ldb1,			// AW mp2.2 added
	 s_ldb2,			// AW mp2.2 added
	 s_ldb3,			// AW mp2.2 added
	 s_ldb4,			// AW mp2.2 added
	 s_ldi1,			// AW mp2.2 added
	 s_ldi2,			// AW mp2.2 added
	 s_ldi3,			// AW mp2.2 added
	 s_ldi4,			// AW mp2.2 added
	 s_ldi5,			// AW mp2.2 added
	 s_trap1, s_trap2, s_trap3,			// AW mp2.2 added
	 s_shf,				// 1.2
	 s_stb1, s_stb2, s_stb3,			// 1.2
	 s_sti1, s_sti2, s_sti3, s_sti4, s_sti5		// 1.2
} state, next_states;

/* State Logic */
always_comb
begin : state_actions
    /* Default output assignments */
	 load_pc = 1'b0;
	 load_ir = 1'b0;
	 load_regfile = 1'b0;
	 load_mar = 1'b0;
	 load_mdr = 1'b0;
	 load_cc = 1'b0;
	 pcmux_sel = 2'b00;		// AW mp2.1 modified
	 storemux_sel = 1'b0;
	 destmux_sel = 1'b0;	// AW mp2.2 added
	 pcoffmux_sel = 1'b1;	// AW mp2.2 added
	 wdatamux_sel = 1'b0;	// mp2.2 added
	 alumux_sel = 2'b00;
	 regfilemux_sel = 1'b0;
	 marmux_sel = 2'b00;
	 mdrmux_sel = 2'b00;
	 aluop = alu_add;
	 mem_read = 1'b0;
	 mem_write = 1'b0;
	 mem_byte_enable = 2'b11;
	 a_mux_sel = 1'b0;
	 
    /*********************** Actions for each state *********************************************/
	 unique case(state)
		fetch1: begin
			/* MAR <= PC */
			marmux_sel = 2'b01;
			load_mar = 1;
			
			/* PC <= PC + 2 */
			pcmux_sel = 2'b00;	// AW mp2.1 modified
			load_pc = 1;
		end
		
		fetch2: begin
			/* Read memory */
			mem_read = 1;
			mdrmux_sel = 2'b01;
			load_mdr = 1;
		end
		
		fetch3: begin
			/* Load IR */
			load_ir = 1;
		end
		
		decode: /* Do nothing */;
		
		s_add: begin
			/* DR <= SRA + SRB */
			aluop = alu_add;
			load_regfile = 1;
			regfilemux_sel = 0;
			load_cc = 1;
		end
		
		s_and: begin
			/* DR <= A & B;*/
			aluop = alu_and;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_not: begin
			/* DR <= NOT(A) */
			aluop = alu_not;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_br: /* do nothing */ ;
		
		s_br_taken: begin
			/* PC <= PC + SEXT(IR[8:0] << 1) */
			pcmux_sel = 2'b01;		// AW mp2.1 modified
			load_pc = 1;
		end
		
		s_calc_addr: begin
			/* MAR <= A + SEXT(IR[5:0] << 1) */
			alumux_sel = 2'b01;
			aluop = alu_add;
			load_mar = 1;
		end
		
		s_ldr1: begin
			/* MDR <= M[MAR] */
			mdrmux_sel = 2'b01;
			load_mdr = 1;
			mem_read = 1;
		end
		
		s_ldr2: begin
			/* DR <= MDR */
			regfilemux_sel = 2'b01;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_str1: begin
			/* MDR <= SR */
			storemux_sel = 1'b1;
			aluop = alu_pass;
			load_mdr = 1;
		end
		
		s_str2: begin
			/* M[MAR] <= MDR */
			mem_write = 1;
		end

		/* AW mp2.1 added */
		s_jmp: begin
			/* PC <= SRA */
			storemux_sel = 1'b0;
			pcmux_sel = 2'b10;
			load_pc = 1;
		end

		/* AW mp2.1 added */
		s_lea: begin
			/* DR <= PC + SEXT(IR[8:0] << 1) */
			pcmux_sel = 2'b01;
			regfilemux_sel = 2'b10;
			load_regfile = 1;
			load_cc = 1;
		end

		// AW mp2.2 added
		s_jsr1: begin
			/* R7 <= PC */
			destmux_sel = 1'b1;		// hard wired 111
			regfilemux_sel = 2'b11;
			load_regfile = 1;
		end

		// AW mp2.2 added
		s_jsr2: begin
			/* PC <= PC + off11 */
			pcoffmux_sel = 1'b0;
			pcmux_sel = 2'b01;
			load_pc = 1;
		end

		// AW mp2.2 added
		s_jsr3: begin
			/* PC <= BaseR */
			storemux_sel = 1'b0;
			pcmux_sel = 2'b10;
			load_pc = 1;
		end

		// mp2.2 add
		s_ldb1: begin
			// MAR <= BaseR + SEXT(offset6)
			alumux_sel = 2'b10;
			aluop = alu_add;
			marmux_sel = 2'b00;
			load_mar = 1;
		end

		// mp2.2 add
		s_ldb2: begin
			/* MDR <= M[MAR] */
			mdrmux_sel = 2'b01;
			load_mdr = 1;
			mem_read = 1;
		end

		// mp2.2 add
		s_ldb3: begin
			// DR <= ZEXT(bytemux_out)
			wdatamux_sel = 1;
			regfilemux_sel = 2'b01;
			destmux_sel = 0;
			load_regfile = 1;
			load_cc = 1;
		end

		// mp2.2 add
		s_ldb4: begin
			// extra ldb state
			wdatamux_sel = 1;
			regfilemux_sel = 2'b01;
			destmux_sel = 0;
			load_regfile = 1;
			load_cc = 1;
		end

		// mp2.2 add
		s_ldi1: begin
			// MAR <= BaseR + SEXT(Offset6)<<1)
			alumux_sel = 2'b01;
			aluop = alu_add;
			marmux_sel = 2'b00;
			load_mar = 1;
		end

		// mp2.2 add
		s_ldi2: begin
			// MDR <= M[MAR]
			mdrmux_sel = 2'b01;
			load_mdr = 1;
			mem_read = 1;
		end

		// mp2.2 add
		s_ldi3: begin
			// MAR <= MDR
			marmux_sel = 2'b10;
			load_mar = 1;
		end

		// mp2.2 add
		s_ldi4: begin
			// MDR <= M[MAR]
			mdrmux_sel = 2'b01;
			load_mdr = 1;
			mem_read = 1;
		end

		// mp2.2 add
		s_ldi5: begin
			// DR <= MDR
			wdatamux_sel = 0;
			regfilemux_sel = 2'b01;
			destmux_sel = 0;
			load_regfile = 1;
			load_cc = 1;
		end

		// 1.2
		s_trap1: begin
			// MAR <- ZEXT[IR[7:0]]
			a_mux_sel = 1'b1;
			aluop = alu_pass;
			marmux_sel = 1'b0;
			load_mar = 1'b1;
		end

		// 1.2
		s_trap2: begin
			// MDR <- M[MAR]
			// R7 <- PC
			mdrmux_sel = 2'b01;
			load_mdr = 1'b1;
			mem_read = 1;
			destmux_sel = 1'b1;		// hard wired 111
			regfilemux_sel = 2'b11;
			load_regfile = 1;
		end

		// 1.2
		s_trap3: begin
			// PC <- MDR
			pcmux_sel = 2'b11;
			load_pc = 1'b1;
		end

		// 1.2
		s_shf: begin
			/* if (D = 0)
					DR = SR << imm4 (left shift)
				else
					if(A == 0)
						DR = SR >> imm4,0; (right shift logical)
					else
						DR = SR >> imm4, SR[15]; (right shift arithmetic)
				setcc();
			 */
			 a_mux_sel = 1'b0;
			 alumux_sel = 2'b11;
			 regfilemux_sel = 2'b00;
			 destmux_sel = 1'b0;

			 if(Dbit == 1'b0)
			 	aluop = alu_sll;
			 else
			 	if(Abit == 1'b0)
			 		aluop = alu_srl;
			 	else
			 		aluop = alu_sra;

			 load_regfile = 1'b1;
			 load_cc = 1;
		end

		// 1.2
		s_stb1: begin
			/* MAR <= SR1 + SEXT(IR[5:0]) */
			alumux_sel = 2'b10;
			aluop = alu_add;
			load_mar = 1;
		end

		// 1.2
		s_stb2: begin
			// MDR <- {SR[7:0], SR[7:0]}
			// note that SR is dest
			if(addrBit)
				mem_byte_enable = 2'b10;
			else
				mem_byte_enable = 2'b01;
			storemux_sel = 1'b1;	// data coming from dest (IR[11:9])
			aluop = alu_pass;
			mdrmux_sel = 2'b10;
			load_mdr = 1;
		end

		// 1.2
		s_stb3: begin
			/* M[MAR] <= MDR */
			mem_write = 1;
			if(addrBit)
				mem_byte_enable = 2'b10;
			else
				mem_byte_enable = 2'b01;
		end

		// 1.2
		s_sti1: begin
			// MAR <- BaseR + SEXT(offset6)<<1
			alumux_sel = 2'b01;
			aluop = alu_add;
			load_mar = 1;
		end

		// 1.2
		s_sti2: begin
			// MDR <-M[MAR]
			mdrmux_sel = 2'b01;
			load_mdr = 1;
			mem_read = 1;
		end

		// 1.2
		s_sti3: begin
			// MAR <- MDR
			marmux_sel = 2'b10;
			load_mar = 1;
		end
		
		default: /* Do nothing */;
		
	 endcase
end

/************************ Next State logic ********************************************/
always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	next_states = state;
	case(state)
		fetch1: begin
			next_states = fetch2;
		end
		
		fetch2: begin
			if(mem_resp == 1'b1)
				next_states = fetch3;
			else
				next_states = fetch2;
		end
		
		fetch3: begin
			next_states = decode;
		end
		
		decode: begin
			case(opcode)
				op_add: begin
					next_states = s_add;
				end

				op_and: begin
					next_states = s_and;
				end

				op_not: begin
					next_states = s_not;
				end

				op_ldr: begin
					next_states = s_calc_addr;
				end

				op_str: begin
					next_states = s_calc_addr;
				end

				op_br: begin
					next_states = s_br;
				end

				op_jmp: begin				// AW mp2.1 added	
					next_states = s_jmp;
				end

				op_lea: begin				// AW mp2.1 added
					next_states = s_lea;
				end

				op_jsr: begin				// AW mp2.2 added
					next_states = s_jsr1;
				end

				op_ldb: begin				// mp2.2 added
					next_states = s_ldb1;
				end

				op_ldi: begin				// mp2.2
					next_states = s_ldi1;
				end

				op_trap: begin				// 1.2
					next_states = s_trap1;
				end

				op_shf: begin				// 1.2
					next_states = s_shf;
				end

				op_stb: begin				// 1.2
					next_states = s_stb1;
				end

				op_sti: begin				// 1.2
					next_states = s_sti1;
				end

				default: /* do nothing */ ;
			endcase
		end
		
		s_add: begin
			next_states = fetch1;
		end
		
		s_and: begin
			next_states = fetch1;
		end
		
		s_not: begin
			next_states = fetch1;
		end
		
		s_br: begin
			if(branch_enable == 1'b1)
				next_states = s_br_taken;
			else
				next_states = fetch1;
		end
		
		s_br_taken: begin
			next_states = fetch1;
		end
		
		s_calc_addr: begin
			if(opcode == op_ldr)
				next_states = s_ldr1;
			else if(opcode == op_str)
				next_states = s_str1;
			else
				/* do nothing */;
		end
		
		s_ldr1: begin
			if(mem_resp == 1'b1)
				next_states = s_ldr2;
		end
		
		s_ldr2: begin
			next_states = fetch1;
		end
		
		s_str1: begin
			next_states = s_str2;
		end
		
		s_str2: begin
			if(mem_resp == 1'b1)
				next_states = fetch1;
		end

		/* AW mp2.1 added */
		s_jmp: begin
			next_states = fetch1;
		end

		/* AW mp2.1 added */
		s_lea: begin
			next_states = fetch1;
		end

		// AW mp2.2 added
		s_jsr1: begin
			if(ir11 == 1'b1)
				next_states = s_jsr2;
			else
				next_states = s_jsr3;
		end

		// AW mp2.2 added
		s_jsr2: begin
			next_states = fetch1;
		end

		// AW mp2.2 added
		s_jsr3: begin
			next_states = fetch1;
		end

		// mp2.2 add
		s_ldb1: begin
			next_states = s_ldb2;
		end

		// mp2.2 add
		s_ldb2: begin
			if(mem_resp == 1'b1)
				next_states = s_ldb3;
		end

		// mp2.2 add
		s_ldb3: begin
			next_states = s_ldb4;
		end

		// mp2.2 add
		s_ldb4: begin
			next_states = fetch1;
		end

		// mp2.2
		s_ldi1: begin
			next_states = s_ldi2;
		end

		// mp2.2
		s_ldi2: begin
			if(mem_resp == 1'b1)
				next_states = s_ldi3;
		end

		// mp2.2
		s_ldi3: begin
			next_states = s_ldi4;
		end

		// mp2.2
		s_ldi4: begin
			if(mem_resp == 1'b1)
				next_states = s_ldi5;
		end

		// mp2.2
		s_ldi5: begin
			next_states = fetch1;
		end

		// 1.2
		s_trap1: begin
			next_states = s_trap2;
		end

		// 1.2
		s_trap2: begin
			if(mem_resp == 1'b1)
				next_states = s_trap3;
		end

		// 1.2
		s_trap3: begin
			next_states = fetch1;
		end

		// 1.2
		s_shf: begin
			next_states = fetch1;
		end

		// 1.2
		s_stb1: begin
			next_states = s_stb2;
		end

		// 1.2
		s_stb2: begin
			next_states = s_stb3;
		end

		// 1.2
		s_stb3: begin
			if(mem_resp == 1'b1)
				next_states = fetch1;
		end

		// 1.2
		s_sti1: begin
			next_states = s_sti2;
		end

		// 1.2
		s_sti2: begin
			if(mem_resp == 1'b1)
				next_states = s_sti3;
		end

		// 1.2
		s_sti3: begin
			next_states = s_str1;		// trying to reuse state
		end
		
		default: /* do nothing */;
		
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_states;
end

endmodule : control
