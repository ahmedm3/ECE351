// bcdAdder8fpga.v - Top level module for the 8-bit BCD adder running on DE1
//
// Copyright (c) Roy Kravitz, 2016
// Created from bcdadder4fpga.v by Roy Kravitz
// 
// Created By:		Roy Kravitz
// Last Modified:	12-May-2016(RK)
//
// Revision History:
// -----------------
// 12-May-2016	RK		Created this module from bcdadder4fpga.v
//
// Description:
// ------------
// Top level module for the ECE 351 BCD 8-bit adder project
// on the Terasic DE1 board (Altera EP2C20F484C7 Cyclone II FPGA).
// Can be used with some modifications for other projects
//
// This version of the top level module connects to these pins on the DE1:
//	o The 10 slide switches (SW9..SW0])
//	o The 4 seven-segment display digits (HEX3..HEX0)
//	o The 8 Green LEDS (LEDG7..LEDG0)
//	o The 10 Red LEDs (LEDR9..LEDR0)
//	o The 4 pushbuttons (KEY3..KEY0]
//
// External port names match pin names in the de1fpga.qsf pin constraints
/////////////////////////////////////////////////////////////////////////////
module bcdAdder8fpga (
	////////////////////////	Clock Input	 	////////////////////////
	input	[1:0]	CLOCK_24,				//	24 MHz
	input	[1:0]	CLOCK_27,				//	27 MHz
	input			CLOCK_50,				//	50 MHz
	input			EXT_CLOCK,				//	External Clock
	////////////////////////	Push Button		////////////////////////
	input	[3:0]	KEY,					//	Pushbutton[3:0]
	////////////////////////	DPDT Switch		////////////////////////
	input	[9:0]	SW,						//	Toggle Switch[9:0]
	////////////////////////	7-SEG Display	////////////////////////
	output	[6:0]	HEX0,					//	Seven Segment Digit 0
	output	[6:0]	HEX1,					//	Seven Segment Digit 1
	output	[6:0]	HEX2,					//	Seven Segment Digit 2
	output	[6:0]	HEX3,					//	Seven Segment Digit 3
	////////////////////////////	LED		////////////////////////////
	output	[7:0]	LEDG,					//	LED Green[7:0]
	output	[9:0]	LEDR					//	LED Red[9:0]
);
		

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire	[3:0]	KEY_PULSE; 	// single clock cycle pulse (asserted high) when a pushbutton (KEY3..KEY0) is pressed
							// All 4 pushbuttons are debounced with a schmitt trigger device on the board so
							// there is no need for additional debouncing
							
reg		[3:0]	KEY_D;		// delayed KEY outputs so we can look for an edge when the button is pressed

wire	[4:0]	dig0, dig1, // seven segment digit inputs
				dig2, dig3;

		
//=======================================================
//  Button Pulse generator
//=======================================================
always @(posedge CLOCK_50) begin
	KEY_D <= KEY;
end

// KEY PULSE signals are asserted high 
// looking for the falling edge since the buttons are asserted low when pressed
assign KEY_PULSE[3] = ((KEY[3] == 1'b0) & (KEY_D[3] == 1'b1)) ? 1'b1 : 1'b0;
assign KEY_PULSE[2] = ((KEY[2] == 1'b0) & (KEY_D[2] == 1'b1)) ? 1'b1 : 1'b0;
assign KEY_PULSE[1] = ((KEY[1] == 1'b0) & (KEY_D[1] == 1'b1)) ? 1'b1 : 1'b0;
assign KEY_PULSE[0] = ((KEY[0] == 1'b0) & (KEY_D[0] == 1'b1)) ? 1'b1 : 1'b0;

//=======================================================
//  Seven Segment Display generator
//=======================================================
SEG7_4  sseg4 (
	.iDIG0(dig0),
	.iDIG1(dig1),
	.iDIG2(dig2),
	.iDIG3(dig3),
	.oSEG0(HEX0),
	.oSEG1(HEX1),
	.oSEG2(HEX2),
	.oSEG3(HEX3)
);
	

//=======================================================
//  8-bit BCD Adder
//=======================================================

// declare internal variables
wire			sysclk;							// system clock
wire			reset_n;						// rightmost pushbutton is the reset signal.  Assert low to reset
wire			next_btn;						// advance data entry/display FSM

wire			load_A, load_B, load_CIN;		// load signals for carry_in, A, and B registers to ALU	
wire			load_RSLT, out_of_range;		// load signal for result and out_of_range signal
wire	[11:0]	result;							// Result of BCD add 

wire	[2:0]	out_mux_sel;					// output mux control for 7-segment display
wire	[7:0]	A_out, B_out;					// latched A and B operands for LEDs
wire			CIN_out;						// latched Carry In to BCD adder

// instantiate the 8-bit BCD Adder
bcdAdder8  BCDADDER
(
	.clk(sysclk),
	.reset_n(reset_n),	
	.A(SW[7:0]),
	.B(SW[7:0]),
	.carry_in(SW[0]),
	.next_btn(next_btn),
	.RSLT(result),
	.out_mux_sel(out_mux_sel),
	
	.A_out(A_out),
	.B_out(B_out),
	.CIN_out(CIN_out)
);

// instantiate the BCD adder output mux 
bcdAdder8_mux OUTMUX
(
	.SW(SW),
	.RSLT(result),
	.out_mux_sel(out_mux_sel),
	
	.dig0(dig0),
	.dig1(dig1),
	.dig2(dig2),
	.dig3(dig3)
);

// map the ports to internal signals
assign sysclk = CLOCK_50;
assign reset_n = KEY[0];
assign next_btn = KEY_PULSE[3];
assign LEDG = B_out;
assign LEDR = {CIN_out, 1'b0, A_out};

endmodule