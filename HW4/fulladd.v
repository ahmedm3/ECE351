// fulladd.v - one bit full adder using Verilog gate-level modeling
//
// Ahmed Abdulkareem
// 04/15/2016
//
// Description:
// ------------
// full 1-bit binary adder
// This module takes 2 1-bit binary
// inputs and outputs the sum
// with a possible carry out
//
module fulladd (
	input	a, b,
	input	ci,
	output	s,
	output	co
);

    wire S1, S2, S3;

    xor x1(S1, a, b);
    xor s1(s, S1, ci);

    and a1(S2, S1, ci);
    and a2(S3, a, b);

    or c1(co, S2, S3);

endmodule