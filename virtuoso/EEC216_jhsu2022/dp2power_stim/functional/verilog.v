`timescale 1ns/1ps

module dp2power_stim (
    output reg [31:0] A0in, 
    output reg [31:0] A1in, 
    output reg CINin
);
    initial begin
        // Initialize at t=0 to prevent X/Z driving AMS connect modules
        A0in  = 32'h00000000;
        A1in  = 32'h00000000;
        CINin = 1'b0;

        // Wait 1ns for AMS Connect Modules to settle DC operating point
        #1;

        // State 1: All Zeros
        A0in  = 32'h00000000;
        A1in  = 32'h00000000;
        CINin = 1'b0;
        #100;

        // State 2: All Ones
        A0in  = 32'hFFFFFFFF;
        A1in  = 32'hFFFFFFFF;
        CINin = 1'b1;
        #100;

        // State 3: Propagate 0
        A0in  = 32'hFFFFFFFF;
        A1in  = 32'h00000000;
        CINin = 1'b0;
        #100;

        // State 4: Propagate 1
        A0in  = 32'hFFFFFFFF;
        A1in  = 32'h00000000;
        CINin = 1'b1;
        #100;

        $finish;
    end
endmodule