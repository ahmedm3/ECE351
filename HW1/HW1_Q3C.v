module three_to_eight(w, En, y);

    input [2:0] w;
    input En;
    output [7:0] y;
    wire [7:0] out;

    two_to_four d1(w[1:0], En, out[3:0]);
    two_to_four d2({1'b0, w[2]}, En, out[7:4]);

    // produce output with some additional gates
    and g1(y[0], out[0], out[4]);
    and g2(y[1], out[1], out[4]);
    and g3(y[2], out[2], out[4]);
    and g4(y[3], out[3], out[4]);
    
    and g5(y[4], out[0], out[5]);
    and g6(y[5], out[1], out[5]);
    and g7(y[6], out[2], out[5]);
    and g8(y[7], out[3], out[5]);

endmodule