// SEG7_4.v - 4 digit 7 segment display controller
//
// Copyright (c) Roy Kravitz, 2016
// 
// Created By:		Roy Kravitz
// Last Modified:	02-May-2016(RK)
//
// Revision History:
// -----------------
// 02-May-2016	RK		Created this module 
//
// Description:
// ------------
// 7 segment digit drivers for the DE1 display (4 digits), no decimal points.
// input is a 5-bit (32 possible codes) value which includes the digits 0..9,
// the hex digits A..F, blank (all segments off), individual segment display,
// and a few special codes (letters)
//
// NOTES:
//	o  Segment outputs are driven low to light the segment, high to turn the segment off
//	o This is NOT a multiplexed display.  All of the segments are driven directly by FPGA pins.
//	o The decimal points on the display digits are not driven on the DE1 board
// 
/////////////////////////////////////////////////////////////////////////////

module SEG7_4 (
	input	[4:0]		iDIG0,			// digit 0 (rightmost) value
	input	[4:0]		iDIG1,			// digit 1 value
	input	[4:0]		iDIG2,			// digit 2 value
	input	[4:0]		iDIG3,			// digit 3 (leftmost) value
	
	output	[6:0]		oSEG0,			// digit 0 decoded outputs for the 7 segments
	output	[6:0]		oSEG1,			// digit 1 decoded outputs for the 7 segments
	output	[6:0]		oSEG2,			// digit 2 decoded outputs for the 7 segments
	output	[6:0]		oSEG3			// digit 3 decoded outputs for the 7 segments
);

// internal variables
reg	[6:0]	oSEG0_int, oSEG1_int, oSEG2_int, oSEG3_int;

// assign the outputs
assign oSEG0 = oSEG0_int;
assign oSEG1 = oSEG1_int;
assign oSEG2 = oSEG2_int;
assign oSEG3 = oSEG3_int;

// decode the digits
always @(iDIG0, iDIG1, iDIG2, iDIG3) begin
	oSEG0_int = dig2sseg(iDIG0);
	oSEG1_int = dig2sseg(iDIG1);
	oSEG2_int = dig2sseg(iDIG2);
	oSEG3_int = dig2sseg(iDIG3);
end // decode the digits

// 7 segment decoder is implemented as a Verilog function
function [6:0] dig2sseg(
	input[4:0] digit_in
);
	case (digit_in)
							//   gfedcba
		5'd0:	dig2sseg	= 7'b1000000;	// zero
		5'd1:	dig2sseg	= 7'b1111001;	// one
		5'd2:	dig2sseg	= 7'b0100100;	// two
		5'd3:	dig2sseg	= 7'b0110000;	// three
		5'd4:	dig2sseg	= 7'b0011001;	// four
		5'd5:	dig2sseg	= 7'b0010010;	// five
		5'd6:	dig2sseg	= 7'b0000010;	// six
		5'd7:	dig2sseg	= 7'b1111000;	// seven
		5'd8:	dig2sseg	= 7'b0000000;	// eight
		5'd9:	dig2sseg	= 7'b0010000;	// nine
		5'd10:	dig2sseg	= 7'b0001000;	// hex A
		5'd11:	dig2sseg	= 7'b0000011;	// hex B
		5'd12:	dig2sseg	= 7'b1000110;	// hex C
		5'd13:	dig2sseg	= 7'b0100001;	// hex D
		5'd14:	dig2sseg	= 7'b0000110;	// hex E
		5'd15:	dig2sseg	= 7'b0001110;	// hex F
		
							//   gfedcba
		5'd16:	dig2sseg	= 7'b1111110;	// seg A
		5'd17:	dig2sseg	= 7'b1111101;	// seg B
		5'd18:	dig2sseg	= 7'b1111011;	// seg C
		5'd19:	dig2sseg	= 7'b1110111;	// seg D
		5'd20:	dig2sseg	= 7'b1101111;	// seg E
		5'd21:	dig2sseg	= 7'b1011111;	// seg F
		5'd22:	dig2sseg	= 7'b0111111;	// seg G
		5'd23:	dig2sseg	= 7'b1111111;	// blank
		
							//   gfedcba		
		5'd24:	dig2sseg	= 7'b0001001;	// upper case H
		5'd25:	dig2sseg	= 7'b1000111;	// upper case L
		5'd26:	dig2sseg	= 7'b0001000;	// upper case R
		5'd27:	dig2sseg	= 7'b1001111;	// lower case L
		5'd28:	dig2sseg	= 7'b0101111;	// lower case R

							//   gfedcba		
		5'd29:	dig2sseg	= 7'b1111111;	// ** RESERVED **
		5'd30:	dig2sseg	= 7'b1111111;	// codes are set to blank
		5'd31:	dig2sseg	= 7'b1111111;	// (all segments off)
	endcase
endfunction

endmodule

	