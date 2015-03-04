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
									SR1MUX,
				output logic 		SR2MUX,
									ADDR1MUX,
				output logic [1:0] 	ADDR2MUX,
				output logic 		MARMUX,
				  
				output lc3b_aluop ALUK,
				  
				output logic 		Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				);

    enum logic [3:0] {Halted, PauseIR1, PauseIR2, S_18, S_33_1, S_33_2, S_35, S_32, S_01, S_05, S_09, S_02, S_00}   State, Next_state;   // Internal state logic
	    
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
            S_18 : 
                Next_state <= S_33_1;
            S_33_1 : 
                Next_state <= S_33_2;
            S_33_2 : 
                Next_state <= S_35;
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
            S_32 : 
				case (Opcode)
					op_add : 
						Next_state <= S_01;
					op_and :
						Next_state <= S_05;
					op_not :
						Next_state <= S_09;
					default : 
					    Next_state <= S_18;
				endcase
            S_01 : 
					Next_state <= S_18;
				S_05 :
					Next_state <= S_18;
				S_09 :
					Next_state <= S_18;
				S_00 :
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
		 
	    GatePC = 1'b1;
	    GateMDR = 1'b1;
	    GateALU = 1'b1;
	    GateMARMUX = 1'b1;
		 
		 ALUK = alu_add;
		 
	    PCMUX = 2'b00;
	    DRMUX = 2'b00;
	    SR1MUX = 2'b00;
	    SR2MUX = 1'b0;
	    ADDR1MUX = 1'b0;
	    ADDR2MUX = 2'b00;
	    MARMUX = 1'b0;
		 
	    Mem_OE = 1'b1;
	    Mem_WE = 1'b1;
		 
	    case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
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
					GateALU = 1'b0;
					LD_REG = 1'b1;
				end
			// AND
			S_05 :
				begin
					SR2MUX = IR_5;
					ALUK = alu_and;
					GateALU = 1'b0;
					LD_REG = 1'b1;
				end
			// NOT
			S_09 :
				begin
					ALUK = alu_not;
					GateALU = 1'b0;
					LD_REG = 1'b1;
				end
			// BR
			S_00 :
				begin
					//TODO figure it out
				end
			
			
				
			default : ;
		endcase
	end 

	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule
