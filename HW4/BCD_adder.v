// bcd_adder.v - 4-bit BCD Adder with illegal input detection using Verilog dataflow modeling
//
// Ahmed Abdulkareem
// 04/15/2016
//
// Description:
// ------------
// This module takes 2 4-bit binary inputs
// and outputs the BCD sum of the inputs
// with a possible carry out
// it also detects illegal input 
// the flag out_of_range will be asserted
// if illegal input is detected
//
module bcd_adder (
	input	[3:0]	X, Y,
	input			c_in,
	output			c_out,
	output	[7:0]	result,
	output			out_of_range
);

    wire [3:0] s1, s2, mux_out; 
    wire c1, c2, adjust;
    
    assign result = {3'b000, c_out, s2};
    assign out_of_range = (X[3] & X[1]) | (X[3] & X[2]) | (Y[3] & Y[1]) | (Y[3] & Y[2]); // illegal input detection
    assign c_out = c1 | c2;
    assign adjust = c1 | (s1[3] & s1[1]) | (s1[3] & s1[2]); // sum > 9 detection
    assign mux_out[0] = adjust ^ adjust;
    assign mux_out[1] = adjust;
    assign mux_out[2] = adjust;
    assign mux_out[3] = adjust ^ adjust;

    // 4 bit binary adder
    fulladd4 FA1(
        .a(X),
        .b(Y),
        .c_in(c_in),
        .s(s1),
        .c_out(c1)
    );

    
    // second 4 bit binary adder to add 6
    fulladd4 FA2(
        .a(s1),
        .b(mux_out),
        .c_in(1'b0),
        .s(s2),
        .c_out(c2)
    );
    
endmodule
