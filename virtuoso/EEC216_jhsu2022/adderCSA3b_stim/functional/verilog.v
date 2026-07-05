//Verilog HDL for "EEC216_jhsu2022", "adderCSA3b_stim" "functional"


module adderCSA3b_stim ( 

    output reg [2:0] A,
    output reg [2:0] B,
    output reg Ci
);

    initial begin
        // 0. Initialize (Test 0 in SKILL script)
        A = 3'b000; 
        B = 3'b000; 
        Ci = 1'b0;
        
        // 1. MUX Setup Path (Test 1)
        // A=7, B=0, Ci=0 -> S=7, Co=0
        #10 A = 3'b111; B = 3'b000; Ci = 1'b0;

        // 2. MUX Switching (Test 2)
        // Flip Ci to trigger the carry-select MUX
        // A=7, B=0, Ci=1 -> S=0, Co=1
        #10 Ci = 1'b1;

        // 3. Ripple Setup (Test 3)
        // Set B=7 to prepare the ripple-carry chain
        // A=0, B=7, Ci=0 -> S=7, Co=0
        #10 A = 3'b000; B = 3'b111; Ci = 1'b0;

        // 4. Worst-Case Ripple Carry (Test 4)
        // Force a carry generation at Bit 0 to ripple through the block
        // A=1, B=7, Ci=0 -> S=0, Co=1
        #10 A = 3'b001;

        // 5. Toggle Activity Test (Optional)
        #10 A = 3'b101; B = 3'b010; Ci = 1'b1;
        
        // Hold final state for observation
        #10;
    end

endmodule
