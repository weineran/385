module control
(
	input logic Clk, Reset, Run, ClearA_LoadB, M,
	output logic [6:0] AhexU, AhexL, BhexU,
	output logic [7:0] Aval, Bval,
	output logic X,
	output logic Clr_ld, Shift, Add, Sub
);

enum logic [4:0] {A,B,Shift1,D,Shift2,F,Shift3,H,Shift4,J,Shift5,L,Shift6,N,Shift7,P,Shift8,R} curr_state, next_state;
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
		B : next_state = Shift1;
		Shift1 : next_state = D;
		D : next_state = Shift2;
		Shift2 : next_state = F;
		F : next_state = Shift3;
		Shift3 : next_state = H;
		H : next_state = Shift4;
		Shift4 : next_state = J;
		J : next_state = Shift5;
      Shift5 : next_state = L;
      L : next_state = Shift6;
      Shift6 : next_state = N;
      N : next_state = Shift7;
      Shift7 : next_state = P;
		P : next_state = Shift8;
		Shift8 : next_state = R;
      R : if(~Run)
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
		  Shift1:  begin
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
		  Shift2:  begin
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
        Shift3:  begin
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
        Shift4:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					
        
        //5
        J:  begin
            if(M)
                Add = 1'b1;
					
            else
                Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0; 
				end
					
        // fifth shift
        Shift5:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					

         //6
        L:  begin
            if(M)
                Add = 1'b1;
					
            else
                Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0;
				end
					
        // sixth shift
        Shift6:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					

        //7
        N:  begin
            if(M)
                Add = 1'b1;
            else
                Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            Shift = 1'b0;
				end
					
        // seventh shift
        Shift7:  begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
				end
					
        
        //Subtract if necessary
        P:  begin
            if(M)
                Sub = 1'b1;
            else
                Sub = 1'b0;
            Add = 1'b0;
            Shift = 1'b1;
            Clr_ld = 1'b0;
				end
					
        // Last shift
        Shift8:  begin
            Add = 1'b0;
            Sub = 1'b0;
            Shift = 1'b1;
            Clr_ld = 1'b0;
				end	

        // clear
        R:  begin
            Add = 1'b0;
            Sub = 1'b0;
            Shift = 1'b0;
            Clr_ld = 1'b0;
				end
			
			default: begin
				Add = 1'b0;
				Sub = 1'b0;
				Shift = 1'b0;
				Clr_ld = 1'b0;
			end
				
		 endcase
		 end
endmodule





        
     
        
        
         		
