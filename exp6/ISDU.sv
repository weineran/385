import lc3b_types::*;

// ISDU.sv (control)

/* 
 * This file is a skeleton of the control unit, performing the instruction fetch and ADD operations. 
 * It is up to you to complete it to implement all the functions required for the processor. In addition, 
 * this entity was created to work with the full LC-3 datapath, and therefore may include signals that 
 * are not necessary for our simplified version, the SLC-3.2. You should identify these functions and 
 * remove them. Rename the file to "ISDU.sv" after download.
 */


//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//------------------------------------------------------------------------------


module ISDU ( 	input	Clk, 
                        Reset,
						Run,
						Continue,
						ContinueIR,
						BEN,
									
				input [3:0]  Opcode, 
				input        IR_5,
				  
				output logic 	LD_MAR,
								LD_MDR,
								LD_IR,
								LD_BEN,
								LD_CC,
								LD_REG,
								LD_PC,
									
				output logic 	GatePC,
								GateMDR,
								GateALU,
								GateMARMUX,
									
				output logic [1:0] 	PCMUX,
				                    DRMUX,

									
				output logic 		SR2MUX, SR1MUX,
									ADDR1MUX,
									dr_mux_sel,
				output logic [1:0] 	ADDR2MUX,
				output logic 		MARMUX,
				  
				output lc3b_aluop ALUK,
				  
				output logic 		Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				);

    enum logic [4:0] {Halted, PauseIR1, PauseIR2, S_18, S_33_1, S_33_2, S_35, S_32, S_01, S_05, S_09, S_02, S_00, S_22,
    					S_16_1, S_16_2, S_13, S_07, S_23, S_12, S_04, S_21, S_06, S_25a, S_25b, S_27}   State, Next_state;   // Internal state logic
	    
    always_ff @ (posedge Clk or posedge Reset )
    begin : Assign_Next_State
        if (Reset) 
            State <= Halted;
        else 
            State <= Next_state;
    end
   
	always_comb
    begin 
	    Next_state  = State;
	 
        unique case (State)
            Halted : 
	            if (Run) 
					Next_state <= S_18;					  
            
            // Fetch1
            S_18 : 
                Next_state <= S_33_1;
            
            // Fetch2a
            S_33_1 : 
                Next_state <= S_33_2;
            
            // Fetch2b
            S_33_2 : 
                Next_state <= S_35;
            
            // Fetch3
            S_35 : 
                Next_state <= S_32;
            
            PauseIR1 : 
                if (~ContinueIR) 
                    Next_state <= PauseIR1;
                else 
                    Next_state <= PauseIR2;
            
            PauseIR2 : 
                if (ContinueIR) 
                    Next_state <= PauseIR2;
                else 
                    Next_state <= S_18;
            
            // Decode
            S_32 : 
				case (Opcode)
					op_add : 
						Next_state <= S_01;
					op_and :
						Next_state <= S_05;
					op_not :
						Next_state <= S_09;
					op_br :
						Next_state <= S_00;
					op_jmp :
						Next_state <= S_12;
					op_jsr :
						Next_state <= S_04;
					op_ldr :
						Next_state <= S_06;
					op_str :
						Next_state <= S_16_1;
					op_pause :
						Next_state <= PauseIR1;
					default : 
					    Next_state <= S_18;
				endcase
            
            // ADD
            S_01 : 
				Next_state <= S_18;
			
			// AND
			S_05 :
				Next_state <= S_18;
			
			// NOT
			S_09 :
				Next_state <= S_18;
			
			// Branch
			S_00 :
				if(BEN == 0)
					Next_state <= S_18;
				else
					Next_state <= S_22;
			
			// Branch taken
			S_22 :
				Next_state <= S_18;

			// JMP
			S_12 :
				Next_state <= S_18;

			// JSR1
			S_04 :
				Next_state <= S_21; // unconditional (not doing JSRR instruction)

			// JSR2
			S_21 :
				Next_state <= S_18;

			// LDR1
			S_06 :
				Next_state <= S_25a;
			
			// LDR2a
			S_25a :
				Next_state <= S_25b;

			// LDR2b
			S_25b :
				Next_state <= S_27;

			// LDR3
			S_27 :
				Next_state <= S_18;

			// STR
				S_07 :
					Next_state <= S_23;
				S_23 :
					Next_state <= S_16_1;
				S_16_1: 
					Next_state <= S_16_2;
				S_16_2: 
					Next_state <= S_18;

			default : ;
	
	     endcase
    end
   
    always_comb
    begin 
        //default controls signal values; within a process, these can be
        //overridden further down (in the case statement, in this case)
	    LD_MAR = 1'b0;
	    LD_MDR = 1'b0;
	    LD_IR = 1'b0;
	    LD_BEN = 1'b0;
	    LD_CC = 1'b0;
	    LD_REG = 1'b0;
	    LD_PC = 1'b0;
		 
	    GatePC = 1'b0;
	    GateMDR = 1'b0;
	    GateALU = 1'b0;
	    GateMARMUX = 1'b0;
		 
		 ALUK = alu_add;
		 
	    PCMUX = 2'b01;
	    DRMUX = 2'b00;
	    SR1MUX = 1'b0;
	    SR2MUX = 1'b0;
	    ADDR1MUX = 1'b0;
	    ADDR2MUX = 2'b00;
	    MARMUX = 1'b0;
	    dr_mux_sel = 1'b0;
		 
	    Mem_OE = 1'b1;
	    Mem_WE = 1'b1;
		 
	    case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b01;
					LD_PC = 1'b1;
				end
			S_33_1 : 
					Mem_OE = 1'b0;
			S_33_2 : 
				begin 
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_35 : 
				begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
				end
            PauseIR1: ;
            PauseIR2: ;
			S_32 : 
                LD_BEN = 1'b1;
         	// ADD
			S_01 : 
				begin 
					SR2MUX = IR_5;
					ALUK = alu_add;
					GateALU = 1'b1;
					LD_REG = 1'b1;
				end
			// AND
			S_05 :
				begin
					SR2MUX = IR_5;
					ALUK = alu_and;
					GateALU = 1'b1;
					LD_REG = 1'b1;
				end
			// NOT
			S_09 :
				begin
					ALUK = alu_not;
					GateALU = 1'b1;
					LD_REG = 1'b1;
				end
			// BR
			S_00 :
				begin
					//ADDR2MUX = 2'b11;
					//PCMUX = 1;
					//LD_PC = 1'b1;
				end
			
			// BR taken
			S_22 :
				// PC <- PC+off9
				begin
					ADDR1MUX = 0;	// select PC
					ADDR2MUX = 2;	// select offset9
					PCMUX = 2;		// select addradd_out
					LD_PC = 1;
				end
			
			// PAUSE
			S_13 :
				begin
					
				end
				
			// STORE
			S_07 :
				begin
					LD_MAR = 1'b1;
					GateMARMUX = 1'b1;
					ADDR2MUX = 2'b10;
					ADDR1MUX = 0;
				end
			S_23: 
				begin
					SR1MUX = 1;
					ALUK = alu_pass;
					GateALU = 1'b0;
					LD_MDR = 1'b1;
				end
			S_16_1:
				begin
					Mem_WE = 1'b0;
				end
			S_16_2:
				begin
					Mem_WE = 1'b0;
					GateMDR = 1'b1;
				end

			// JMP
			S_12 :
				// PC <- BaseR
				begin
					ADDR1MUX = 1'b1; // select SR1_out
					PCMUX = 2'b10;	// select addradd_out
					LD_PC = 1;		// load PC
				end

			// JSR1
			S_04 :
				// R7 <- PC
				begin
					dr_mux_sel = 1;		// select R7
					GatePC = 1;
					LD_REG = 1;
				end

			// JSR2
			S_21 :
				begin
					ADDR2MUX = 2'b11;	// select offset11
					ADDR1MUX = 1'b0; 	// select PC
					PCMUX = 2;			// select addradd_out
					LD_PC = 1;
				end

			// LDR1
			S_06 :
				// MAR <- SR1 + off6
				begin
					ADDR1MUX = 1;	// select SR1
					ADDR2MUX = 2'b01; 	// select off6
					GateMARMUX = 1;
					LD_MAR = 1;
				end

			// LDR2a
			S_25a :
				// MDR <- M[MAR]
				begin
					Mem_OE = 1'b0;
				end

			// LDR2b
			S_25b :
				// MDR <- M[MAR]
				begin
					Mem_OE = 1'b0;
					LD_MDR = 1;
				end

			// LDR3
			S_27 :
				// DR <- MDR
				// set CC
				begin
					GateMDR = 1;
					LD_REG = 1;
					LD_CC = 1;
				end			
				
			default : ;
		endcase
	end 

	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule
