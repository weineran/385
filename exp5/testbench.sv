module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Reset;
logic Run;
logic CLR_LDB;
logic Reset2;
logic [7:0] Switches; 
// To store expected results
logic [7:0] A_out, B_out;


		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
my8bitmult my8bitmult(.*);
	

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
#2 Reset = 0;		// Toggle Rest
#2 CLR_LDB = 1;
#2 Run = 1;
#2 Switches = 8'h33;	// Specify Din, F, and R

#2 Reset = 1;
#2 Reset = 0;
#2 CLR_LDB = 0;
#2 CLR_LDB = 1;
#2 Switches = 8'h2;
#2 Run = 0;
#4 Run = 1;

#25;
#2 Reset = 1;
#2 Reset = 0;
#2 Switches = 8'hFF;
#2 CLR_LDB = 0;
#2 CLR_LDB = 1;

#2 Reset = 1;
#2 Reset = 0;
#2 Run = 0;
#4 Run = 1;
#25;






end

endmodule


