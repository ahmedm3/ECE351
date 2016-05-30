// bcdAdder8_mux.v - Output multiplexer for 8-bit BCD adder running on DE1
//
// Copyright (c) Roy Kravitz, 2016
// 
// Created By:		Roy Kravitz
// Last Modified:	13-May-2016(RK)
//
// Revision History:
// -----------------
// 13-May-2016	RK		Created this module
//
// Description:
// ------------
// This module implements a multiplexer that controls what is displayed on the
// 4-digit 7-segment display on the DE1.  The mux switches between showing the
// operands so the user can use the switches to set the value, showing the
// carry in so the user can enter the carry in to the BCD adder and showing
// the result of the BCD add.  The select for the mux is provided by the 
// BCD adder control logic based on the state of data entry.  The mux is
// also capable of blanking the display and displaying an ERR state.
//
// The mux produces a 5-bit code for each digit which is converted to the 
// 7 segments by the SEG7_4 module.  SEG7_4 can display the digits 0-9, A-F,
// individual segments (one at a time) and several special characters.  See
// SEG7_4.v to get a list of the codes.
/////////////////////////////////////////////////////////////////////////////

module bcdAdder8_mux (
	input	wire	[9:0]	SW,				// slide switches
	input	wire	[11:0]	RSLT,			// BCD Adder Result register 
	input	wire	[2:0]	out_mux_sel,	// select inputs for the MUX
	
	output	reg		[4:0]	dig0,			// rightmost digit of 7-seg display
	output	reg		[4:0]	dig1,			// second to rightmost digit
	output	reg		[4:0]	dig2,			// third digit (next to leftmost digit)
	output	reg		[4:0]	dig3			// leftmost digit of 7-seg display
);

// define the out mux values from the control logic
localparam 	[2:0]	SHOWA = 3'd0, SHOWB = 3'd1, SHOWCIN = 3'd2, SHOWRSLT = 3'd3, SHOWZEROS = 3'd4,
					SHOWBLNKS = 3'd5, SHOWERR = 3'd6;

// define the special characters decoded by SEG7_4.v					
localparam	[4:0]
					UPCA = 5'h0A, UPCB = 5'h0B, UPCC = 5'h0C, UPCD = 5'h0D, UPCE = 5'h0E,
					UPCF = 5'hF,
					SEGA = 5'd16, SEGB = 5'd17, SEGC = 5'd18, SEGD = 5'd19, SEGE = 5'd20,
					SEGF = 5'd21, SEGG = 5'd22, BLNK = 5'd23, UPCH = 5'd24, UCL  = 5'd25,
					UCR  = 5'd26, LCL  = 5'd27, LCR  = 5'd28, RSV1 = 5'd29, RSV2 = 5'd30,
					RSV3 = 5'd31;
					
// internal variables
wire rslt_dig3, rslt_dig2, rslt_dig1;		// checks for the result nibbles == 0

assign rslt_dig3_eq0 = (RSLT[11:8] == 4'd0);
assign rslt_dig2_eq0 = (RSLT[7:4] == 4'd0);
assign rslt_dig1_eq0 = (RSLT[3:0] == 4'd0);
					
// implement the mux using a combinational always block and
// a case statement
always @* begin
	case (out_mux_sel)
		SHOWA:		begin		// User is entering A operand
						dig3 = UPCA;
						dig2 = BLNK;
						dig1 = SW[7:4];
						dig0 = SW[3:0];
					end
		
		SHOWB:		begin		// User is entering B operand
						dig3 = UPCB;
						dig2 = BLNK;
						dig1 = SW[7:4];
						dig0 = SW[3:0];
					end	

		SHOWCIN:	begin		// User is entering Carry In
						dig3 = UPCC;
						dig2 = BLNK;
						dig1 = BLNK;
						dig0 = {4'b0000, SW[0]};
					end	

		SHOWRSLT:	begin		// Show the result
						dig3 = BLNK;
						dig2 = (rslt_dig3_eq0) ? BLNK : {1'b0, RSLT[11:8]};
						dig1 = (rslt_dig3_eq0 && rslt_dig2_eq0) ? BLNK : {1'b0, RSLT[7:4]};
						dig0 = {1'b0, RSLT[3:0]};		// should show at least one digit
					end	

		SHOWBLNKS:	begin		// Blank the display
						dig3 = BLNK;
						dig2 = BLNK;
						dig1 = BLNK;
						dig0 = BLNK;
					end	

		SHOWERR:	begin		// Show Error
						dig3 = BLNK;
						dig2 = UPCE;
						dig1 = LCR;
						dig0 = LCR;
					end	

		default:	begin		// default - shouldn't get here but just in case
						dig3 = SEGG;
						dig2 = SEGG;
						dig1 = SEGG;
						dig0 = SEGG;
					end	
	endcase
end // always for mux

endmodule
		
	