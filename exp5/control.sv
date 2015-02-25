module control
(
	input logic Clk, Reset, Run, ClearA_LoadB, M,
	output logic [6:0] AhexU, AhexL, BhexU,
	output logic [7:0] Aval, Bval,
	output logic X,
	output logic Clr_ld, Shift, Add, Sub
);

enum logic [4:0] {A,B,C,D,E,F,G,H,I,J,K,L,M1,N,O,P} curr_state, next_state;
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
		A : if (Run)
			next_state = B;
		B : next_state = C;
		C : next_state = D;
		D : next_state = E;
		E : next_state = F;
		F : next_state = G;
		G : next_state = H;
		H : next_state = I;
		I : next_state = J;
		J : next_state = K;
      K : next_state = L;
      L : next_state = M1;
      M1 : next_state = N;
      N : next_state = O;
      O : next_state = P;
      P : if(~Run)
          next_state = A; 
			 
	endcase		
end	

always@(curr_state or ClearA_LoadB or M)
begin
	case(curr_state)
		  A:  begin
				Add = 1'b0;
				Sub = 1'b0;
				Shift = 1'b0;
				if(ClearA_LoadB)
					Clr_ld = 1'b1;  
				else
					Clr_ld = 1'b0;
				end

        //1 
		  B: 	begin
				if(M)
					Add = 1'b1;
				else
					Add = 1'b0; 
				Sub = 1'b0;
				Clr_ld = 1'b0;
				Shift = 1'b0;
				end
					
		  // first shift
		  C:  begin
				Shift = 1'b1;
				Add = 1'b0;
				Sub = 1'b0;
				Clr_ld = 1'b0;
				end
					
		
        //2
        D:  begin
				if(M)
					Add = 1'b1;
				else
					Add = 1'b0;
				Sub = 1'b0;
				Clr_ld = 1'b0;
				Shift = 1'b0;
				end
					
		  // second shift
		  E:  begin
			   Shift = 1'b1;
			   Add = 1'b0;
			   Sub = 1'b0;
			   Clr_ld = 1'b0;
				end
					

	     //3
        F:  begin
			   if(M)
					Add = 1'b1;
			   else
					Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0; 
				end
					
        // third shift
        G:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					

        //4
        H:  begin
            if(M)
                Add = 1'b1;
					
            else
                Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0;  
				end
					
        // fourth shift
        I:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					
        
        //5
        H:  begin
            if(M)
                Add = 1'b1;
					
            else
                Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0; 
				end
					
        // fifth shift
        I:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					

         //6
        J:  begin
            if(M)
                Add = 1'b1;
					
            else
                Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0;
				end
					
        // sixth shift
        K:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					

        //7
        L:  begin
            if(M)
                Add = 1'b1;
            else
                Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0;
				end
					
        // seventh shift
        M1:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					
        
        //Subtract if necessary
        N:  begin
            if(M)
                Sub = 1'b1;
            else
                Sub = 1'b0;
            Add = 1'b0;
            Shift = 1'b1;
            Clr_ld = 1'b0;
				end
					
        // Last shift
        O:  begin
            Add = 1'b0;
            Sub = 1'b0;
            Shift = 1'b1;
            Clr_ld = 1'b0;
				end	

        // clear
        P:  begin
            Add = 1'b0;
            Sub = 1'b0;
            Shift = 1'b0;
            Clr_ld = 1'b0;
				end
				
		 endcase
		 end
endmodule





        
     
        
        
         		
