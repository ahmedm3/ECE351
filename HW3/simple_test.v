module simple_test;

    reg [7:0] A, B;
    wire [7:0] out;
    wire carry_out, out_enable;
    reg [8:0] correct_result;
    reg [8:0] sim_result;
    reg [16:0] test_vecs [0:65535];
    reg clk;
    
    always #5 clk = ~clk;

    integer i, j, tvi;
    initial begin
        clk = 0;
        A = 0;
        B = 0;
        tvi = 0;
        for (i = 0; i < 255; i = i + 1) begin
            for (j = 0; j < 255; j = j + 1) begin
                test_vecs[tvi][7:0] = i[7:0];
                test_vecs[tvi][16:8] = j[7:0];
                tvi = tvi + 1;
            end
        end
        tvi = 0;
    end

    adder_sub DUT(.A(A),
                  .B(B),
                  .add_en(1'b0),
                  .sub_en(1'b1),
                  .carry_in(1'b0),
                  .data_out(out),
                  .carry_out(carry_out),
                  .out_en(out_enable)
                  );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, simple_test);
    end

    always @(posedge clk) begin
        A = test_vecs[tvi][7:0];
        B = test_vecs[tvi][15:8];
        #1;
        correct_result = A + B;
        sim_result = {carry_out, out};
        if (sim_result != correct_result) 
            $display("A = %d, B  = %d, Error: A + B = %d, expected is A + B = %d", A, B, sim_result, correct_result);

        tvi = tvi + 1;
        if (tvi >= 65535)
            $stop;
    end

endmodule

