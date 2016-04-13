// Ahmed Abdulkareem
// 04/09/2016
// Homework 1 Question 3 B

module two_to_four(w, En, y);

    input [1:0] w;
    input En;
    output [3:0] y;
    wire n0, n1;

    not g0(n0, w[0]);
    not g1(n1, w[1]);
    
    and g2(y[0], n0, En, n1);
    and g3(y[1], w[0], En, n1);
    and g4(y[2], n0, En, w[1]);
    and g5(y[3], w[0], En, w[1]);

endmodule
 