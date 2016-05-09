module simple_test;

    reg [7:0] A, B;
    wire [7:0] out;
    wire carry_out, out_enable;

    initial begin
        A = 10;
        #5 B = 20;
        #20 A = 255;
        #5 B = 255;
    end

    adder_sub DUT(.A(A),
                  .B(B),
                  .add_en(1'b1),
                  .sub_en(1'b0),
                  .carry_in(1'b0),
                  .data_out(out),
                  .carry_out(carry_out),
                  .out_en(out_enable)
                  );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, simple_test);
    end

endmodule

