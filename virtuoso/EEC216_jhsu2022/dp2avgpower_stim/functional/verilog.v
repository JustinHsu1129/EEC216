module dp2avgpower_stim (
    output reg [31:0] A0in, 
    output reg [31:0] A1in, 
    output reg CINin
);
    integer i;

    initial begin
        // Wait 1ns before assigning anything to let the 
        // AMS Connect Modules settle their DC operating points!
        #1; 

        // Generate 100 random additions at 100 MHz (10ns period)
        for (i = 0; i < 100; i = i + 1) begin
            A0in = $random;
            A1in = $random;
            CINin = $random;
            #10;
        end

        $finish;
    end
endmodule