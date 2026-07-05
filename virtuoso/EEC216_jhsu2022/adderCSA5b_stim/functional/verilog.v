//Verilog HDL for "EEC216_jhsu2022", "adderCSA5b_stim" "functional"


module adderCSA5b_stim ( 
    output reg [4:0] A,
    output reg [4:0] B,
    output reg Ci
);

    initial begin
        // 0. Initialize (Test 0)
        A = 5'b00000; 
        B = 5'b00000; 
        Ci = 1'b0;
        
        // 1. MUX Setup Path (Test 1)
        // A=31, B=0, Ci=0 -> S=31, Co=0
        #10 A = 5'b11111; B = 5'b00000; Ci = 1'b0;

        // 2. MUX Switching (Test 2)
        // Flip Ci to trigger the carry-select MUX
        // A=31, B=0, Ci=1 -> S=0, Co=1
        #10 Ci = 1'b1;

        // 3. Ripple Setup (Test 3)
        // Set B=31 to prepare the ripple-carry chain
        // A=0, B=31, Ci=0 -> S=31, Co=0
        #10 A = 5'b00000; B = 5'b11111; Ci = 1'b0;

        // 4. Worst-Case Ripple Carry (Test 4)
        // Force a carry generation at Bit 0 to ripple through the entire 5-bit block
        // A=1, B=31, Ci=0 -> S=0, Co=1
        #10 A = 5'b00001;

        // 5. Toggle Activity Test (Optional)
        // Checkerboard pattern to toggle maximum internal nodes
        #10 A = 5'b10101; B = 5'b01010; Ci = 1'b1;
        
        // Hold final state for observation
        #10;
    end

endmodule
