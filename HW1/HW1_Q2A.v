// Ahmed Abdulkareem
// FA module at the gate level
// 04/09/2016


module FA(A, B, CIN, S, COUT);

    input A, B, CIN;
    output S, COUT;
    wire S1, S2, S3;

    // xor gate for A and B
    xor x1(S1, A, B);
   
    // xor for S1 and CIN to produce the sum
    xor sum(S, S1, CIN);

    // and for S1 and CIN
    and a1(S2, S1, CIN);

    // and for A and B
    and a2(S3, A, B);

    // or to produce COUT
    or cout(COUT, S2, S3);

endmodule
