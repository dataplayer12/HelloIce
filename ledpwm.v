`default_nettype none

module comparison (
	input clk,    // Clock
	input reg1, // Clock Enable
	input reg2,  // Asynchronous reset active low
	output reg3,
	
);
assign reg3 = (reg1<reg2);

endmodule

module ledpwm(input CLK_IN, output GLED5, output RLED1, output RLED2, output RLED3, output RLED4);
	localparam WIDTH = 12;
	localparam PWMLEVEL = 512; //(2<<(WIDTH-3));
	localparam ALLONES = ((2<<(WIDTH-1))-1);
	localparam PERIODFINISHED = 255;

	reg [7:0] period;
	reg [WIDTH-1:0] counter=0;
	reg [WIDTH-1:0] pwmval= 0; //PWMLEVEL;
	reg ison;
	// run counter from 12MHz clock
	always @(posedge CLK_IN)
		counter <= counter + 1;

	// for (int i = 0; i < WIDTH-1; i++) begin
	// 	/* code */
	// end

	always @(posedge CLK_IN)
		if(counter==ALLONES) begin
		 		period <= period+1;
		 		//GLED5 <= ~GLED5;
	 	end

	always @(posedge CLK_IN)
		if(period==PERIODFINISHED) begin
			pwmval <= pwmval+1;
			GLED5 <= ~GLED5;
		end

	// wire up the red LEDs to the counter
	comparison cmp(CLK_IN,counter,pwmval,ison);

	//assign ison = (counter<pwmval);
	assign RLED1 = ison; //(counter<pwmval);
	assign RLED2 = ison; //(counter<pwmval);
	assign RLED4 = 1'b1;

endmodule

//`default_nettype wire