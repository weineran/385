module control
(
	input Clk, Reset, ClearXA_loadB, Execute,
	output logic Shift_XAB, ADD, SUB
);

enum logic [2:0] {A,B,C,D,E,F} curr_state, next_state;

always_ff @ (posedge Clk or posedge Reset )
begin
	if (Reset) // Asynchronous Reset - see note in Reg_4
		curr_state = A; // A is the reset/start state
	else
		curr_state = next_state;
end

always_comb
begin	
	next_state = curr_state;
