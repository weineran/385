module control
(
	input logic Clk, Reset, Run, ClearA_LoadB, M;
	input logic [7:0] S,
	output logic [6:0] AhexU, AhexL, BhexU,
	output logic [7:0] Aval, Bval,
	output logic X,
	output Clr_Ld, Shift, Add, Sub
)

enum logic [3:0] {A,B,C,D,E,F,G,H,I,J} curr_state, next_state;
always_ff @ (posedge Clk or posedge Reset )
	begin
		if (Reset) 				// Asynchronous Reset - see note in Reg_4
			curr_state = A; 	// A is the reset/start state
		else
			curr_state = next_state;
end

always_comb
begin

	next_state = curr_state;
	unique case (curr_state)
		A : if (Execute)
			next_state = B;
		B : next_state = C;
		C : next_state = D;
		D : next_state = E;
		E : next_state = F;
		F : next_state = G;
		H : next_state = I;
		I : next_state = J;		
				
		J : if (~Execute)
			next_state = A;
endcase
end

always_comb
begin
	case(curr_state)
		A: begin
			Add = 1'b0;
			Sub = 1'b0;
			if(ClearA_LoadB)
				Clr_Ld = 1b'1;
			else
				Clr_ld = 1b'0;
			end
		
		B: begin
			if(M)
				Add = 1'b1;
			else
				Add = 1'b0; 
				Sub = 1'b0;
				Clr_ld = 1b'0;
				Shift = 1b'0;
			end
		
		// first shift
		C: begin
			Shift = 1'b1;
			Add = 1'b0;
			Sub = 1'b0;
			Clr_ld = 1'b0;
			end
			
		D: begin
			if(M)
				Add = 1'b1;
			else
				Add = 1'b0;
				Sub = 1'b0;
				Clr_ld = 1b'0;
				Shift = 1b'0;
			end
		
		// second shift
		E: begin
			Shift = 1'b1;
			Add = 1'b0;
			Sub = 1'b0;
			Clr_ld = 1'b0;
			
		//etc...
		// Make another 8 shifts for subtraction
			
		
		
	endcase
end