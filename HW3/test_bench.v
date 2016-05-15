// Ahmed Abdulkareem
// ECE 351 HW 3
// 05/12/2016
// This is a test bench for the alu design
// data are pre-generated using a python and a C scripts
// This data generated are in the form A B results
// all other things I'll need to generate myself

module tb;

    reg [7:0] A, B;
    reg [3:0] sel;
    reg carryIn;
    wire [7:0] results;
    wire carryOut;
    reg [971: 0] adder_vects, sub_vects;
    reg [755: 0] leftShift_vects, rightShift_vects, leftRotate_vects, rightRotate_vects;
    reg [47: 0] AND_vects, OR_vects, NAND_vects, NOT_vects, XOR_vects, XNOR_vects, NOR_vects;
    reg clk;


    // read all test data
    initial begin
        $readmemh("adder_data.txt", adder_vects); // adder data
        $readmemh("sub_data.txt", sub_vects);     // subtraction data
        $readmemh("left_shift_data.txt", leftShift_vects); // left shift
        $readmemh("right_shift_data.txt", rightShift_vects); // right shift
        $readmemh("left_rotate_data.txt", leftRotate_vects); // left rotate
        $readmemh("right_rotate_data.txt", rightRotate_vects); // right rotate
        $readmemh("logical_AND_data.txta", AND_vects);
        $readmemh("logical_OR_data.txta", OR_vects);
        $readmemh("logical_NOT_data.txta", NOT_vects);
        $readmemh("logical_NAND_data.txta", NAND_vects);
        $readmemh("logical_XOR_data.txta", XOR_vects);
        $readmemh("logical_XNOR_data.txta", XNOR_vects);
        $readmemh("logical_NOR_data.txta", NOR_vects);
    end
    
    // initialize clock
    initial clk = 0;

    always #5 clk = ~clk;

    // for mac only, used in gtkwave
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, stimulus);
    end

    
        
endmodule

