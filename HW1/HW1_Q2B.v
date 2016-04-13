// Ahmed Abdulkareem
// 04/09/2016
// 4 bit ripple carry adder


module fourBit_ripple_adder(Ain, Bin, Cin, Sum, Cout);

    input [3:0] Ain, Bin;
    input Cin;
    output [3:0] Sum;
    output Cout;
    wire C1, C2, C3;

    // instantiate FA
    FA ra1(
	.A(Ain[0]),
	.B(Bin[0]),
	.CIN(Cin),
	.S(Sum[0]),
	.COUT(C1)
    );

    FA ra2(
	.A(Ain[1]),
	.B(Bin[1]),
	.CIN(C1),
	.S(Sum[1]),
	.COUT(C2)
    );

    FA ra3(
	.A(Ain[2]),
	.B(Bin[2]),
	.CIN(C2),
	.S(Sum[2]),
	.COUT(C3)
    );

   FA ra4(
	.A(Ain[3]),
	.B(Bin[3]),
	.CIN(C3),
	.S(Sum[3]),
	.COUT(Cout)
    );

endmodule
