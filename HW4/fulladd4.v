// fulladd4.v - 4-bit binary adder
//
// Ahmed Abdulkareem
// 04/15/2016
//
// Description:
// ------------
// This is a 4-bit full binary adder
// It takes 2 4-bit binary inputs 
// and outputs the sum of them 
// with a possible carry out
//
module fulladd4 (
	input	[3:0]	a, b,
	input			c_in,
	output	[3:0]	s,
	output			c_out
);

    wire C1, C2, C3;

    // instantiate FA
    fulladd ra1(
	.a(a[0]),
	.b(b[0]),
	.ci(c_in),
	.s(s[0]),
	.co(C1)
    );

    fulladd ra2(
	.a(a[1]),
	.b(b[1]),
	.ci(C1),
	.s(s[1]),
	.co(C2)
    );

    fulladd ra3(
	.a(a[2]),
	.b(b[2]),
	.ci(C2),
	.s(s[2]),
	.co(C3)
    );

   fulladd ra4(
	.a(a[3]),
	.b(b[3]),
	.ci(C3),
	.s(s[3]),
	.co(c_out)
    );

endmodule