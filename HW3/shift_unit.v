// Ahmed Abdulkareem
// ECE 351
// shift unit for HW 3
// This module shifts the operand data_in by shift_by bits to left 
// or right. The direction is provided by dir
// direction of 0 specifies left, 1 specifies
// a right shift

module shift_unit(data_in, shift_by, op_en, dir, data_out, out_en);

    input [7:0] data_in, shift_by;
    input op_en, dir;
    output reg [7:0] data_out;
    output reg out_en;

    always @* begin
        if (dir) // if right shift
            data_out = data_in >> shift_by;
        else 
            data_out = data_in << shift_by;
    end

endmodule

