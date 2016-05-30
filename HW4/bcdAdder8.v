// bcdAdder8.v - Top level module for am 8-bit BCD adder
//
// Copyright (c) Roy Kravitz, 2016
// 
// Created By:		Roy Kravitz
// Last Modified:	15-May-2016(RK)
//
// Revision History:
// -----------------
// 15-May-2016	RK		Created this module
//
// Description:
// ------------
// Top level module for an 8-bit BCD adder.  The adder is based on the 4-bit
// BCD adder developed for ECE 351 HW #2.  This implementation is a Datapath/Control Logic
// architecture with the Datapath being responsible for operating on the two 8-bit
// operands and producing an 12-bit packed BCD result.  
//
// The module also implements control for an output mux that drives either
// the operand values (for entering the operands) or the result to the
// four digit 7-segment display.  Ideally you would isolate this functionality
// from the BCD adder because sending output to a display has nothing to do
// with generating a BCD sum but it is convenient to put the functionality
// here. 
//
// The control logic implements the following sequencer:
//		o Load operand A
//		o Load operand B
//		o Load Carry In
//		o Save the result of the BCD Add
//		o start the sequence again.
//
//	Note: the control logic assumes that the input to advance the sequence is asserted
//  for a single cycle and only advances on valid BCD data.
/////////////////////////////////////////////////////////////////////////////
module bcdAdder8 (
	input			clk,			// system clock and reset.  reset_n is asserted low
	input			reset_n,		// for reset	
	input	[7:0]	A,				// A and B operands for the BCD Adder.  These are unsigned
	input	[7:0]	B,				// BCD numbers
	input			carry_in,		// Carry In to the BCD Adder
	input			next_btn,		// Asserted for one cycle to advance the sequencing
									// for entering A, B and Carry In and displaying the result
	
	output	[11:0]	RSLT,			// Packed BCD result of the BCD add operation
	output	[2:0]	out_mux_sel,	// output mux sel.  Can be used to select the
									// approriate data to display
									
	output	[7:0]	A_out,			// Latched A and B operands (available for display)
	output	[7:0]	B_out,			// Can be left unconnected if not needed
	output			CIN_out			// Latched Carry In (available for display)
									// Can be left unconnected if not needed
);

// internal variables
wire			load_A, load_B, load_CIN;		// load signals for carry_in, A, and B registers to ALU	
wire			load_RSLT, out_of_range;		// load signal for result and out_of_range signal

// instantiate the BCD adder datapath
bcdAdder8_dp DP
(
	.clk(clk),
	.reset_n(reset_n),	
	.A(A),
	.B(B),
	.carry_in(carry_in),
	.load_A(load_A),
	.load_B(load_B),
	.load_CIN(load_CIN),
	.load_RSLT(load_RSLT),
	
	.RSLT(RSLT),
	.out_of_range(out_of_range),
	
	.A_out(A_out),
	.B_out(B_out),
	.CIN_out(CIN_out)
);

// instantiate the BCD adder datapath control logic
bcdAdder8_ctl CTL
(
	.clk(clk),
	.reset_n(reset_n),
	.next_btn(next_btn),
	.out_of_range(out_of_range),
	
	.load_A(load_A),
	.load_B(load_B),
	.load_CIN(load_CIN),
	.load_RSLT(load_RSLT),
	.out_mux_sel(out_mux_sel)
);

endmodule
