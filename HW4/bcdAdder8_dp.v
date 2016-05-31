// Ahmed Abdulkareem
// data path module
// ECE 351, HW4
// 05/26/2016

module bcdAdder8_dp (
    input clk, reset_n,             // system clock and reset signals. the reset signals 
                                    // is asserted low
    input [7:0] A, B,               // A and B operands. Values are saved in registers 
                                    // when the associated load signal is asserted
    input carry_in,                 // carry_in to the BCD adder
    input load_A, load_B,           // load signals for the A and B operand registers
    input load_CIN,                 // load signal for Carry In register
    input load_RSLT,                // load signal to store the result of the BCD add
    output reg [11:0] RSLT,         // packed BCD result of add
    output out_of_range,            // asserted if either of the operands is invalid
    output reg [7:0] A_out, B_out,  // A and B register outputs.
    output reg CIN_out              // Carry In register out
);

    // internal registers
    wire c_out_hi;
    wire c_out_lo;
    wire [15:0] results;
    wire [1:0] out_of_ranges;

    assign out_of_range = out_of_ranges[0] | out_of_ranges[1];

    // instantiate the two 4-bit BCD adders
    bcd_adder BCD1(.X(A_out[3:0]),
                   .Y(B_out[3:0]),
                   .c_in(carry_in),
                   .c_out(c_out_lo),
                   .result(results[7:0]),
                   .out_of_range(out_of_ranges[0])
    );
    bcd_adder BCD2(.X(A_out[7:4]),
                   .Y(B_out[7:4]),
                   .c_in(c_out_lo),
                   .c_out(c_out_hi),
                   .result(results[15:8]),
                   .out_of_range(out_of_ranges[1])
    );

    // latching input logic
    always @(posedge clk) begin
        if (!reset_n) begin
            A_out   <= 8'd0;
            B_out   <= 8'd0;
            CIN_out <= 1'b0;
        end // if 
        else if (load_A)
            A_out <= A;
        else if (load_B)
            B_out <= B;
        else if (load_CIN)
            CIN_out <= carry_in;
        else begin
            A_out   <= A_out;
            B_out   <= B_out;
            CIN_out <= CIN_out;
        end // else 
    end // always

    // output
    always @(posedge clk) begin
        if (!reset_n) 
            RSLT <= 11'd0;
        else if (load_RSLT) 
            RSLT <= {results[15:8], results[3:0]};
        else 
            RSLT <= RSLT;
    end

endmodule

