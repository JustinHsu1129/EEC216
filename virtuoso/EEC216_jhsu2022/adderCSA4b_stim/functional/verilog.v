//Verilog HDL for "EEC216_jhsu2022", "adderCSA4b_stim" "functional"
`timescale 1ns / 1ps

module adderCSA4b_stim (
    output reg [3:0] A,
    output reg [3:0] B,
    output reg Ci
);

    initial begin
        // 0. Initialize all outputs
        A = 4'b0000; 
        B = 4'b0000; 
        Ci = 1'b0;
        
        // 1. MUX Select Path Test
        // Both chains calculate, then Ci toggles to switch the MUX
        #20 A = 4'b1111; B = 4'b0000; Ci = 1'b0;
        #20 Ci = 1'b1;

        // 2. Ripple Carry Path Test
        // Force a carry to ripple from bit 0 to bit 3
        #20 A = 4'b0000; B = 4'b1111; Ci = 1'b0;
        #20 A = 4'b0001;

        // 3. Max Switching Activity Test
        // Toggle all bits simultaneously
        #20 A = 4'b0000; B = 4'b0000; Ci = 1'b0;
        #20 A = 4'b1111; B = 4'b1111; Ci = 1'b1;

        // 4. Checkerboard Pattern Test
        #20 A = 4'b1010; B = 4'b0101; Ci = 1'b0;
        #20 A = 4'b0101; B = 4'b1010; Ci = 1'b1;
        
        // Hold final state
        #20;
    end

endmodule
