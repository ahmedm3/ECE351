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
    input          clk,            // clock input
    input          reset_n,        // reset button
    input          next_btn,       // Advance data entry sequence
    input          out_of_range,   // Operand A and/or Operand B are illegal
    output reg     load_A,         // load the A operand register
    output reg     load_B,         // load the B operand register
    output reg     load_CIN,       // load the Carry In register
    output reg     load_RSLT,      // load the BCD result register
    output reg [2:0] out_mux_sel   // 3-bit code that can be used to multiplex the
                                   // operands and results on a display
);

    // internal registers
    reg [1:0] curr_state, next_state;
    localparam LDA = 2'b00, LDB = 2'b01, LDCIN = 2'b10, LDRSLT = 2'b11;


    // reset and assigning current state
    always @(posedge clk) begin
        if (reset_n)
            curr_state = LDA;
        else
            curr_state = next_state;
    end

    // state transitions
    always @(*) begin
        next_state = curr_state; // default
        case (curr_state)
            LDA: begin
                if (next_btn && !out_of_range)
                    next_state = LDB;
            end
            LDB: begin
                if (next_btn && !out_of_range)
                    next_state = LDCIN;
            end
            LDCIN: begin
                if (next_btn)
                    next_state = LDRSLT;
            end
            LDRSLT: begin
                if (next_btn)
                    next_state = LDA;
            end
        endcase
    end

    // output
    always @(*) begin
        case (curr_state)
            LDA: begin
                if (next_btn && !out_of_range) begin
                    load_A = 1'b1;
                    load_B = 1'b0;
                    load_CIN = 1'b0;
                    load_RSLT = 1'b0;
                    out_mux_sel = 3'b000;
                end else if (out_of_range) begin
                    load_A = 1'b1;
                    load_B = 1'b0;
                    load_CIN = 1'b0;
                    load_RSLT = 1'b0; 
                    out_mux_sel = 3'b110;
                end
            end
            LDB: begin
                if (next_btn && !out_of_range) begin
                    load_A = 1'b0;
                    load_B = 1'b1;
                    load_CIN = 1'b0;
                    load_RSLT = 1'b0;
                    out_mux_sel = 3'b001;
                end else if (out_of_range) begin
                    load_A = 1'b0;
                    load_B = 1'b1;
                    load_CIN = 1'b0;
                    load_RSLT = 1'b0; 
                    out_mux_sel = 3'b110;
                end
            end
            LDCIN: begin
                load_A = 1'b0;
                load_B = 1'b0;
                load_CIN = 1'b1;
                load_RSLT = 1'b0;
                out_mux_sel = 3'b010;
            end
            LDRSLT: begin
                load_A = 1'b0;
                load_B = 1'b0;
                load_CIN = 1'b0;
                load_RSLT = 1'b1;
                out_mux_sel = 3'b011;
            end 
        endcase // case 
    end // always
endmodule

