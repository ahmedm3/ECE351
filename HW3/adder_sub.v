// Ahmed Abdulkareem
// ECE 351
// Adder subtractor for HW 3
// This file has the implementation of
// the adder and subtractor
// This module has 2 8 bit inputs A, B
// for the operands with an 8 bit output data_out
// and a 1 bit carry_out 
// It also contains 2 1-bit inputs (add_en, sub_en)
// to specify the operation
// out_en is an output signal used to select inputs to
// the output enable logic
// if the add_en is a 1, addition operation is performed
// if the sub_en is a 1, 2s, subtraction will be performed
// if A < B in subtraction, 2s complement will be returned

module adder_sub(A, B, sub_en, add_en, carry_in, out_en, data_out, carry_out);

    input [7:0] A, B;
    input sub_en, add_en, carry_in;
    output reg [7:0] data_out;
    output reg carry_out;
    output out_en;

    always @(A, B, sub_en, add_en, carry_in) begin
        if (add_en)
            {carry_out, data_out} = A + B;
        else if (sub_en) begin
            {carry_out, data_out} = A + (~B + 1);
        end // else if sub_en

    end // always 

endmodule

