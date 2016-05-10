// Ahmed Abdulkareem
// ECE 351
// rotate unit for HW 3
// this module will rotate left or right
// based on dir input (0 for left, 1 for right)
// any rotation bigger than 8 will return all 0s


module rotate_unit(data_in, rotate_by, op_en, dir, data_out, out_en);

    input [7:0] data_in, rotate_by;
    input op_en, dir;
    output reg [7:0] data_out;
    output reg out_en;

    always @* begin
        if (dir) // right rotate
            data_out = {data_in[7:rotate_by], data_in[rotate_by - 1:0]};
        else 
            data_out = {data_in[rotate_by - 1:0], data_in[7:rotate_by]};
        
    end // always
endmodule

