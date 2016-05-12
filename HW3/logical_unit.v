// Ahmed Abdulkareem
// ECE 351
// logical unit for HW3
// this unit is used to perform logical operations
// supported ops: AND --> 0110, OR --> 0111, NOT --> 1000,
// NAND --> 1001, NOR --> 1010, XOR --> 1011, XNOR --> 1100
// this binary representation for the ops are specified by the input
// fn_sel. op_en is used to enable the unit
// in case of a NOT operation, the A will be negated and B will be left 
// as is
// If fn_sel is invalid, the output will be 8'bxxxxxxxx

module logical_unit(A, B, fn_sel, op_en, out_en, data_out);

    input [7:0] A, B;
    input [3:0] fn_sel;
    input op_en;
    output out_en;
    output reg [7:0] data_out;

    // define local parameters for the ops
    localparam AND = 4'b0110, OR = 4'b0111, NOT = 4'b1000, NAND = 4'b1001;
    localparam NOR = 4'b1010, XOR = 4'b1011, XNOR = 4'b1100;

    // only enable output enable if the unit is enabled
    assign out_en = op_en ? 1'b1 : 1'b0;

    always @* begin
        case (fn_sel)
            AND : data_out = A & B;
            OR  : data_out = A | B;
            NOT : data_out = ~A;
            NAND: data_out = ~(A & B);
            NOR : data_out = ~(A | B);
            XOR : data_out = A ^ B;
            XNOR: data_out = A ~^ B;
            default: data_out = 8'bxxxxxxxx;
        endcase
    end // always
endmodule

