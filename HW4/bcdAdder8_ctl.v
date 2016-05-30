// Ahmed Abdulkareem
// control logic module
// Mealy state machine
// ECE 351, HW4
// 05/26/2016

/*
Curr state           Input                 Next State
              next_btn   out_of_range
LDA             1           0               LDB
                X           1               LDA
LDB             1           0               LDCIN
                X           1               LDB
LDCIN           1           X               LDRSLT
                0           X               LDCIN
LDRSLT          1           X               LDA
                0           X               LDRSLT
*/

module bcdAdder8_ctl (
    input       clk,            // clock input
    input       reset_n,        // reset button
    input       next_btn,       // Advance data entry sequence
    input       out_of_range,   // Operand A and/or Operand B are illegal
    output      load_A,         // load the A operand register
    output      load_B,         // load the B operand register
    output      load_CIN,       // load the Carry In register
    output      load_RSLT,      // load the BCD result register
    output [2:0] out_mux_sel    // 3-bit code that can be used to multiplex the
                                // operands and results on a display
);

    // internal registers
    reg [1:0] curr_state, next_state;
    localparam LDA = 2'b00, LDB = 2'b01, LDCIN = 2'b10, LDRSLT = 2'b11;

    // state transitions
    always @(

endmodule

