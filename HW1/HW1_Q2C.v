// Ahmed Abdulkareem
// 04/09/2016
// 4 bit ripple carry adder

module eightBit_ripple_adder(A, B, CIN, S, COUT);

    input [7:0] A, B;
    input CIN;
    output [7:0] S;
    output COUT;
    wire C1;

    // instantiate 2 four-bit ripple carry adders
    fourBit_ripple_adder r1(
	.Ain(A[3:0]),
	.Bin(B[3:0]),
	.Cin(CIN),
	.Sum(S[3:0]),
	.Cout(C1)
    );

    fourBit_ripple_adder r2(
	.Ain(A[7:4]),
	.Bin(B[7:4]),
	.Cin(C1),
	.Sum(S[7:4]),
	.Cout(COUT)
    );

endmodule
