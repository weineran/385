module control
(
	input logic Clk, Reset, Run, ClearA_LoadB, M;
	input logic [7:0] S,
	output logic [6:0] AhexU, AhexL, BhexU,
	output logic [7:0] Aval, Bval,
	output logic X,
	output Clr_Ld, Shift, Add, Sub
)

enum logic [4:0] {A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P} curr_state, next_state;
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
        K : next_state = L;
        L : next_state = M;
        M : next_state = N;
        N : next_state = O;
        O : next_state = P;
        P : if(~Execute)
            next_state = A;       		
				
endcase
end

always_comb
begin
	case(curr_state)
		A: begin
			Add = 1'b0;
			Sub = 1'b0;
			Shift = 1'b0;
            if(ClearA_LoadB)
            begin
				Clr_Ld = 1'b1;
			end
            else
			begin	
                Clr_ld = 1'b0;
			end
		   end


        //1 
		B: begin
			if(M)
				Add = 1'b1;
            else
				Add = 1'b0; 
				Sub = 1'b0;
				Clr_ld = 1'b0;
				Shift = 1'b0;
		    end
		// first shift
		C: begin
			Shift = 1'b1;
			Add = 1'b0;
			Sub = 1'b0;
			Clr_ld = 1'b0;
			end
		
        //2
        D: begin
			if(M)
				Add = 1'b1;
			else
				Add = 1'b0;
				Sub = 1'b0;
				Clr_ld = 1'b0;
				Shift = 1'b0;
			end
		// second shift
		E: begin
			Shift = 1'b1;
			Add = 1'b0;
			Sub = 1'b0;
			Clr_ld = 1'b0;
            end

	    //3
        F: begin
            if(M)
                Add = 1'b1;
            end
            else
                Add = 1'b0;
                Sub = 1'b0;
                Clr_ld = 1'b0;
                Shift = 1'b0;    
            end
        // third shift
        G: begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            end

        //4
        H: begin
            if(M)
                Add = 1'b1;
            end
            else
                Add = 1'b0;
                Sub = 1'b0;
                Clr_ld = 1'b0;
                Shift = 1'b0;    
            end
        // fourth shift
        I: begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            end
        
        //5
        H: begin
            if(M)
                Add = 1'b1;
            end
            else
                Add = 1'b0;
                Sub = 1'b0;
                Clr_ld = 1'b0;
                Shift = 1'b0;    
            end
        // fifth shift
        I: begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            end

         //6
        J: begin
            if(M)
                Add = 1'b1;
            end
            else
                Add = 1'b0;
                Sub = 1'b0;
                Clr_ld = 1'b0;
                Shift = 1'b0;    
            end
        // sixth shift
        K: begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            end

        //7
        L: begin
            if(M)
                Add = 1'b1;
            end
            else
                Add = 1'b0;
                Sub = 1'b0;
                Clr_ld = 1'b0;
                Shift = 1'b0;    
            end
        // seventh shift
        M: begin
            Shift = 1'b1;
            Add = 1'b0;
            Sub = 1'b0;
            Clr_ld = 1'b0;
            end
        
        //Subtract if necessary
        N: begin
            if(M) begin
                Sub = 1'b1;
            else
                Sub = 0'b0;
                Add = 1'b0;
                Shift = 1'b1;
                Clr_ld = 1'b0;
            end
        // Last shift
        O: begin
            Add = 1'b0;
            Sub = 1'b0;
            Shift = 1'b1;
            Clr_ld = 1'b0;
            end

        // clear
        P: begin
            Add = 1'b0;
            Sub = 1'b0;
            Shift = 1'b0;
            Clr_ld = 1'b0;
            end
        endcase

end
endmodule





        
     
        
        
         		
