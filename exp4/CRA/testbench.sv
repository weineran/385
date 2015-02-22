module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Reset, LoadB, Run;
logic [15:0] Din;
logic [3:0] LED;


logic [16:0] reg_out;

/*
logic [6:0] AhexL,
		 AhexU,
		 BhexL,
		 BhexU; 
*/

// To store expected results
logic [15:0] ans_1a;
				
// A counter to count the instances where simulation results
// do no match with expected results
integer ErrorCnt = 0;
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
cra_datapath cra0(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
Reset = 0;		// Toggle Rest
LoadB = 1;
Run = 1;
Din = 16'h01;	// Specify Din, F, and R

#2 Reset = 1;

#2 LoadB = 0;	// Toggle LoadB
#2 LoadB = 1;

   Din = 16'h02;	// Change Din

#2 LoadB = 0;   // Toggle LoadB
#2 LoadB = 1;


#2 Run = 0;	// Toggle Execute
   
#22 Run = 1;
    ans_1a = (16'h03); // Expected result of 1st cycle
    // expected to be 'h03
    if (reg_out[15:0] != ans_1a)
	 ErrorCnt++;

/*

#2 Execute = 0;	// Toggle Execute
#2 Execute = 1;

#22 Execute = 0;
    // Aval is expected to stay the same
    // Bval is expected to be the answer of 1st cycle XNOR 8’h55
    if (Aval != ans_1a)	
	 ErrorCnt++;
    ans_2b = ~(ans_1a ^ 8'h55); // Expected result of 2nd  cycle
    if (Bval != ans_2b)
	 ErrorCnt++;
    R = 2'b11;
#2 Execute = 1;

// Aval and Bval are expected to swap
#22 if (Aval != ans_2b)
	 ErrorCnt++;
    if (Bval != ans_1a)
	 ErrorCnt++;
*/

if (ErrorCnt == 0)
	$display("Success!");  // Command line output in ModelSim
else
	$display("%d error(s) detected. Try again!", ErrorCnt);
end
endmodule
