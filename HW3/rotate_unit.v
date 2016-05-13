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
    output out_en;
    integer i;

    assign out_en = op_en ? 1'b1 : 1'b0;

    always @* begin
        data_out = data_in;
        if (rotate_by > 4'b1000) // if bigger than 8
            data_out = 8'b00000000; 
        else if (dir) begin // left rotate
            for (i = 0; i < rotate_by; i = i + 1)
                data_out = {data_out[6:0], data_out[7]};
            //data_out = {data_in[rotate_by - 1:0], data_in[7:rotate_by]};
            i = 0;
        end
        else begin
            for (i = 0; i < rotate_by; i = i + 1)
                data_out = {data_out[0], data_out[7:1]};
            //data_out = {data_in[7:rotate_by], data_in[rotate_by - 1:0]};
            i = 0;
        end
        
    end // always
endmodule

