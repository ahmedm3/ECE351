// Ahmed Abdulkareem
// ECE 351
// shift unit for HW 3
// This module shifts the operand data_in by shift_by bits to left 
// or right. The direction is provided by dir
// direction of 0 specifies right, 1 specifies
// a left shift
// if shift_by > 8, then 0 will be returned

module shift_unit(data_in, shift_by, op_en, dir, data_out, out_en);

    input [7:0] data_in, shift_by;
    input op_en, dir;
    output reg [7:0] data_out;
    output out_en;

    // output enable logic
    assign out_en = op_en ? 1'b1 : 1'b0;

    always @* begin
        if (dir) // if left shift
            data_out = data_in << shift_by;
        else 
            data_out = data_in >> shift_by;
    end

endmodule

