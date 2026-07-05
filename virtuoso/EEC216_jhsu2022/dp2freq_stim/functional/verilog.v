module dp2freq_stim (
    output reg [31:0] A0in, 
    output reg [31:0] A1in, 
    output reg CINin
);
    initial begin
        #1; 
        // Initial State: Propagate setup
        // A + B + Cin = 0xFFFFFFFF + 0 + 0 = 0xFFFFFFFF (No carry out)
        A0in = 32'hFFFFFFFF;
        A1in = 32'h00000000;
        CINin = 1'b0;
        
        // Wait 100ns for the initial DC state to completely settle
        #99; 
        
        // Trigger the Critical Path at exactly t = 100ns
        // A + B + Cin = 0xFFFFFFFF + 0 + 1 = 0x00000000, Cout = 1
        CINin = 1'b1;
        
        // Wait a long time because 0.1V will be EXTREMELY slow (microseconds)
        #5000; 
        
        $finish;
    end
endmodule