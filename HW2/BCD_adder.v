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
    reg [2:0] six; // holds number 6 

    wire s1, c1;

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
        .a(x),
        .b(y),
        .cin(Cin),
        .s(s1),
        .cout(c1)
    );

    initial six = 3'b110;
