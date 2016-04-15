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

    wire [3:0] s1, adjust, mux_out; 
    wire c1, c2, big_sum;
    
    assign c_out = c1 | c2;
    assign adjust = c1 | (s1[3] & s1[1]) | (s1[3] & s[2]); // sum > 9 detection
    assign mux_out = (4'b0000 & (~adjust)) | (4'b0110 & adjust); // mux output

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
        .s(result),
        .c_out(c2)
    );

    
endmodule
