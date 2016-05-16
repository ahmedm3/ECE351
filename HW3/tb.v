// Ahmed Abdulkareem
// 05/06/2016
// ECE 351 HW 3
// This is the highest level of the test bench
// This module contains both the ALU and stimulus

module tb;

    // instantiate stimulus
    stimulus testBench();

    // ALU
    alu_design ALU(.A(testBench.A),
                   .B(testBench.B),
                   .carry_in(testBench.carryIn),
                   .sel(testBench.sel),
                   .Y(testBench.results),
                   .carry_out(testBench.carryOut)
    );

endmodule

