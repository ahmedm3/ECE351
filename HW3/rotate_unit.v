// Ahmed Abdulkareem
// ECE 351
// rotate unit for HW 3
// this module will rotate left or right
// based on dir input (1 for left, 0 for right)
// any rotation bigger than 8 will return all 0s


module rotate_unit(data_in, rotate_by, op_en, dir, data_out, out_en);

    input [7:0] data_in, rotate_by;
    input op_en, dir;
    output reg [7:0] data_out;
    output reg out_en;

    always @* begin
        if (rotate_by > 4'b1000) // if bigger than 8
            data_out = 8'b00000000;
        /*
        else if (dir) // left rotate
            data_out = {data_in[rotate_by - 1:0], data_in[7:rotate_by]};
        else 
            data_out = {data_in[7:rotate_by], data_in[rotate_by - 1:0]};
        */
    end // always
endmodule

