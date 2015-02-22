module control
(
    input  Clk, Reset, LoadB, Run, C_out,
    input logic [15:0] SW,
    input logic [15:0] Sum,
    output logic [16:0] to_reg,
    output logic Ld_B
);

    // declare signals curr_state, next_state of type enum
    //    with enum values of A, B, ..., F as the state values
    enum logic [3:0] {
        s_start,
        s_load,
        s_run,
		  s_compute,
        s_reset
    }   curr_state, next_state; 


    always_ff @ (posedge Clk or posedge Run)  
    begin
       curr_state = next_state;
    end

    // Assign outputs based on ‘state’
	always_comb 
    begin
        next_state  = curr_state;         

        unique case(curr_state)
            s_start: begin
                if(LoadB)
                    next_state = s_load;
                else if(Run)
                    next_state = s_run;
                else if(Reset)
                    next_state = s_reset;
                else
                    next_state = s_start;
            end

            s_load: begin
                next_state = s_start;
            end

            s_run: begin
					 if(~Run)
						next_state = s_compute;
					 else
						next_state = s_run;
            end
				
				s_compute: begin
					if(Reset)
						next_state = s_reset;
					else if(Run)
						next_state = s_run;
					else if(LoadB)
						next_state = s_load;
					else
						next_state = s_start;
				end

            s_reset: begin
                next_state = s_start;
            end

        endcase
    end

    // Assign outputs based on ‘state’
	 always_comb
    begin
        case (curr_state) 
	   	   s_start: begin
                Ld_B <= 1'b0 ;
                to_reg[15:0] <= SW[15:0];
                to_reg[16] <= 1'b0;
                /*
                Ahex3[3:0] <= SW[15:12];
                Ahex2[3:0] <= SW[11:8];
                Ahex1[3:0] <= SW[7:4];
                Ahex0[3:0] <= SW[3:0];
                */
		    end

	   	   s_load: begin
                Ld_B <= 1'b1;
                to_reg[15:0] <= SW[15:0];
                to_reg[16] <= 1'b0;
            end

            s_run: begin
                Ld_B <= 1'b0;
                to_reg[15:0] <= SW[15:0];
                to_reg[16] <= 1'b0;
            end
				
				s_compute: begin
					 Ld_B <= 1'b1;
                to_reg[15:0] <= Sum[15:0];
                to_reg[16] <= C_out;
				end

	   	   default: begin
                Ld_B <= 1'b0;
                to_reg[15:0] <= SW[15:0];
                to_reg[16] <= 1'b0;
                /*
                Bhex3[3:0] <= R[15:12];
                Bhex2[3:0] <= R[11:8];
                Bhex1[3:0] <= R[7:4];
                Bhex0[3:0] <= R[3:0];
                */
		    end

        endcase
    end

endmodule: control
