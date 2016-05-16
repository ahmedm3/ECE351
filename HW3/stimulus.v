// Ahmed Abdulkareem
// ECE 351 HW 3
// 05/12/2016
// This is a test bench for the alu design
// data are pre-generated using a python and a C scripts
// This data generated are in the form A B results
// all other things I'll need to generate myself


module stimulus;

    // define fixed length for the test vectors
    localparam ADDER_LENGTH = 972, SUB_LENGTH = 513, SHIFTS_LENGTH = 756, LOGICAL_LENGTH = 48, WIDTH = 8;

    // inputs and outputs to ALU unit
    reg [7:0] A, B;
    reg [3:0] sel;
    reg carryIn;
    wire [7:0] results;
    wire carryOut;

    // test vectors to read data into
    reg [WIDTH: 0] adder_vects [ADDER_LENGTH - 1: 0]; 
    reg [WIDTH: 0] sub_vects  [SUB_LENGTH - 1: 0];
    reg [WIDTH - 1: 0]  leftShift_vects [SHIFTS_LENGTH - 1: 0], rightShift_vects [SHIFTS_LENGTH - 1: 0], leftRotate_vects [SHIFTS_LENGTH - 1: 0], rightRotate_vects [SHIFTS_LENGTH - 1: 0];
    reg [WIDTH - 1: 0] AND_vects [LOGICAL_LENGTH - 1: 0], OR_vects [LOGICAL_LENGTH - 1: 0], NAND_vects [LOGICAL_LENGTH - 1: 0], NOT_vects [LOGICAL_LENGTH - 1: 0], XOR_vects [LOGICAL_LENGTH - 1: 0], XNOR_vects [LOGICAL_LENGTH - 1: 0], NOR_vects [LOGICAL_LENGTH - 1: 0];

    reg fail; // will be set to 1 if a test case fails
    
    // read all test data
    initial begin
        $readmemh("adder_data.txt", adder_vects); // adder data
        $readmemh("sub_data.txt", sub_vects);     // subtraction data
        $readmemh("left_shift_data.txt", leftShift_vects); // left shift
        $readmemh("right_shift_data.txt", rightShift_vects); // right shift
        $readmemh("left_rotate_data.txt", leftRotate_vects); // left rotate
        $readmemh("right_rotate_data.txt", rightRotate_vects); // right rotate
        $readmemh("logical_AND_data.txt", AND_vects);
        $readmemh("logical_OR_data.txt", OR_vects);
        $readmemh("logical_NOT_data.txt", NOT_vects);
        $readmemh("logical_NAND_data.txt", NAND_vects);
        $readmemh("logical_XOR_data.txt", XOR_vects);
        $readmemh("logical_NOR_data.txt", NOR_vects);
        $readmemh("logical_XNOR_data.txt", XNOR_vects);
    end
    
    // for mac only, used in gtkwave
    // waveForm.vcd shows the waveform
    initial begin
        $dumpfile("waveForm.vcd");
        $dumpvars(0, stimulus);
    end

    // ***********************************************
    // test cases start here
    // ***********************************************
    integer i;
    initial #10 begin
        i = 0;
        carryIn = 0; 
        sel = 4'b0000; // to enable adder
        fail = 0; // assume no fails

        // ***********************************************
        // begin testing the adder unit
        // ***********************************************
        while (i < ADDER_LENGTH) begin
            A = adder_vects[i];
            B = adder_vects[i + 1];
            # 2;
            if ({carryOut, results} != adder_vects[i + 2]) begin
                $display("ERROR --> %d + %d = %d, expected: %d", A, B, {carryOut, results}, adder_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b0001; // subtractor unit
        
        # 5;
        // ***********************************************
        // begin subtractor testing
        // ***********************************************
        while (i < SUB_LENGTH) begin
            A = sub_vects[i];
            B = sub_vects[i + 1];
            # 2;
            if ({carryOut, results} != sub_vects[i + 2]) begin
                $display("ERROR --> %d - %d = %d, expected: %d", A, B, {carryOut, results}, sub_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b0010; // left shift
        
        # 5;
        // ***********************************************
        // begin left shift testing
        // ***********************************************
        while (i < SHIFTS_LENGTH) begin
            A = leftShift_vects[i];
            B = leftShift_vects[i + 1];
            # 2;
            if (results != leftShift_vects[i + 2]) begin
                $display("ERROR --> %d << %d = %d, expected: %d", A, B, results, leftShift_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b0011; // right shift
        
        # 5;
        // ***********************************************
        // begin right shift testing
        // ***********************************************
        while (i < SHIFTS_LENGTH) begin
            A = rightShift_vects[i];
            B = rightShift_vects[i + 1];
            # 2;
            if (results != rightShift_vects[i + 2]) begin
                $display("ERROR --> %d >> %d = %d, expected: %d", A, B, results, rightShift_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b0100; // left rotate
        
        # 5;
        // ***********************************************
        // begin left rotate testing
        // ***********************************************
        while (i < SHIFTS_LENGTH) begin
            A = leftRotate_vects[i];
            B = leftRotate_vects[i + 1];
            # 2;
            if (results != leftRotate_vects[i + 2]) begin
                $display("ERROR --> %d rotated left %d bits = %d, expected: %d", A, B, results, leftRotate_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b0101; // right rotate
        
        # 5;
        // ***********************************************
        // begin right rotate testing
        // ***********************************************
        while (i < SHIFTS_LENGTH) begin
            A = rightRotate_vects[i];
            B = rightRotate_vects[i + 1];
            # 2;
            if (results != rightRotate_vects[i + 2]) begin
                $display("ERROR --> %d rotated right %d bits = %d, expected: %d", A, B, results, rightRotate_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b0110; // AND
        
        # 5;
        // ***********************************************
        // begin AND testing
        // ***********************************************
        while (i < LOGICAL_LENGTH) begin
            A = AND_vects[i];
            B = AND_vects[i + 1];
            # 2;
            if (results != AND_vects[i + 2]) begin
                $display("ERROR --> %d AND %d = %d, expected: %d", A, B, results, AND_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b0111; // OR
        
        # 5;
        // ***********************************************
        // begin OR testing
        // ***********************************************
        while (i < LOGICAL_LENGTH) begin
            A = OR_vects[i];
            B = OR_vects[i + 1];
            # 2;
            if (results != OR_vects[i + 2]) begin
                $display("ERROR --> %d OR %d = %d, expected: %d", A, B, results, OR_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b1000; // NOT
        
        # 5;
        // ***********************************************
        // begin NOT testing
        // ***********************************************
        while (i < LOGICAL_LENGTH) begin
            A = NOT_vects[i];
            B = NOT_vects[i + 1];
            # 2;
            if (results != NOT_vects[i + 2]) begin
                $display("ERROR --> %d NOT %d = %d, expected: %d", A, B, results, NOT_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b1001; // NAND
        
        # 5;
        // ***********************************************
        // begin NAND testing
        // ***********************************************
        while (i < LOGICAL_LENGTH) begin
            A = NAND_vects[i];
            B = NAND_vects[i + 1];
            # 2;
            if (results != NAND_vects[i + 2]) begin
                $display("ERROR --> %d NAND %d = %d, expected: %d", A, B, results, NAND_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b1010; // NOR
        
        # 5;
        // ***********************************************
        // begin NOR testing
        // ***********************************************
        while (i < LOGICAL_LENGTH) begin
            A = NOR_vects[i];
            B = NOR_vects[i + 1];
            # 2;
            if (results != NOR_vects[i + 2]) begin
                $display("ERROR --> %d NOR %d = %d, expected: %d", A, B, results, NOR_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b1011; // XOR
        
        # 5;
        // ***********************************************
        // begin XOR testing
        // ***********************************************
        while (i < LOGICAL_LENGTH) begin
            A = XOR_vects[i];
            B = XOR_vects[i + 1];
            # 2;
            if (results != XOR_vects[i + 2]) begin
                $display("ERROR --> %d XOR %d = %d, expected: %d", A, B, results, XOR_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
        
        i = 0;
        sel = 4'b1100; // XNOR
        
        # 5;
        // ***********************************************
        // begin XNOR testing
        // ***********************************************
        while (i < LOGICAL_LENGTH) begin
            A = XNOR_vects[i];
            B = XNOR_vects[i + 1];
            # 2;
            if (results != XNOR_vects[i + 2]) begin
                $display("ERROR --> %d XNOR %d = %d, expected: %d", A, B, results, XNOR_vects[i + 2]);
                fail = 1;
            end
            i = i + 3;
        end
 
        // ***********************************************
        // some additional test vectors for adder unit 
        // with carry in = 1
        // ***********************************************
        # 5;
        A = 8'b00000000;
        B = 8'b00000000;
        carryIn = 1'b1;
        sel = 4'b0000;
        # 2;

        if ({carryOut, results} != 9'b000000001) begin
            $display("Error --> 0 + 0 + carry_in = %d, expected = %d", {carryOut, results}, 9'b000000001);
            fail = 1;
        end
        
        # 5;
        A = 8'b11111111;
        B = 8'b11111111;
        carryIn = 1'b1;
        # 2;

        if ({carryOut, results} != 9'b111111111) begin
            $display("Error --> 255 + 255 + carry_in = %d, expected = %d", {carryOut, results}, 9'b111111111);
            fail = 1;
        end
        
        # 5;
        A = 8'b11001111;
        B = 8'b11110011;
        carryIn = 1'b1;
        # 2;

        if ({carryOut, results} != 9'b111000011) begin
            $display("Error --> 207 + 243 + carry_in = %d, expected = %d", {carryOut, results}, 9'b111111111);
            fail = 1;
        end
        
        // ***********************************************
        // some additional test vectors for sub unit
        // where A < B
        // ***********************************************
        # 5;
        A = 8'b00000010;
        B = 8'b00000100;
        carryIn = 0;
        sel = 4'b0001;
        # 2;

        if ({carryOut, results} != -8'D2) begin
            $display("Error --> 2 - 4 = %d, expected = %d", {carryOut, results}, -8'D2);
            fail = 1;
        end
        
        # 5;
        A = 8'b00000000;
        B = 8'b00000100;
        sel = 4'b0001;
        # 2;

        if ({carryOut, results} != -8'D4) begin
            $display("Error --> 2 - 4 = %d, expected = %d", {carryOut, results}, -8'D4);
            fail = 1;
        end
        
        # 5;
        A = 8'b11111110;
        B = 8'b11111111;
        sel = 4'b0001;
        # 2;

        if ({carryOut, results} != -8'D1) begin
            $display("Error --> 2 - 4 = %d, expected = %d", {carryOut, results}, -8'D1);
            fail = 1;
        end

        // if nothing failed, output a message
        if (!fail)
            $display("All test cases passed! Congrats");
        else
            $display("There was at least 1 test case that didn't pass, please take a look at the log");

        $finish;
    end

endmodule

