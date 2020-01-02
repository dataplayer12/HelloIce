`default_nettype none

// define a andorgate module
module andorgate(input CLK_IN, output GLED5, output RLED1, output RLED2, output RLED3, output RLED4);

	// define a 24-bit counter to divide the clock down from 12MHz
	localparam WIDTH = 25;
	reg [WIDTH-1:0] counter;

	// run counter from 12MHz clock
	always @(posedge CLK_IN)
		counter <= counter + 1;

	// wire up the red LEDs to the counter
	assign RLED1 = counter[WIDTH-1];
	assign RLED2 = counter[WIDTH-2];

	assign RLED3 = RLED1 & RLED2; //AND gate
	assign RLED4 = RLED1 | RLED2; //OR gate
	assign GLED5 = RLED1 ^ RLED2; //XOR gate

endmodule