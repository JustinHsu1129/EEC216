//Verilog HDL for "EEC216_jhsu2022", "dp2_tb" "functional"
module dp2_stim (A0in, A1in, CINin);
	
	output reg [31:0] A0in;
    output reg [31:0] A1in;
    output reg CINin;
    
    integer i;
    reg [31:0] lfsr;
    
    initial begin
        // Initialize inputs
        A0in = 32'h00000000;
        A1in = 32'h00000000;
        CINin = 1'b0;
        //#10;
        // -----------------------------------------------------------
        // 1. CRITICAL PATH DELAY TEST
        // For a ripple-carry architecture, you need to propagate 
        // a carry from bit 0 all the way to bit 31.
        // Critical path delay measured: 1.46ns -> max freq ~685MHz
        // Meets 100MHz requirement with 8.54ns of slack
        // -----------------------------------------------------------
		// Test 1: 0xFFFFFFFF + 0x00000000 + CIN=0 = 0xFFFFFFFF
		A0in = 32'hFFFFFFFF;
		A1in = 32'h00000000;
		CINin = 1'b0;
		#10;
		// Test 2: 0xFFFFFFFF + 0x00000000 + CIN=1 = 0x00000000, Cout=1
		A0in = 32'hFFFFFFFF;
		A1in = 32'h00000000;
		CINin = 1'b1;
		#10;
		// Test 3: 0x7FFFFFFF + 0x00000000 + CIN=1 = 0x80000000
		A0in = 32'h7FFFFFFF;
		A1in = 32'h00000000;
		CINin = 1'b1;
		#10;
		// Test 4: 0xFFFFFFFE + 0x00000000 + CIN=1 = 0xFFFFFFFF
		A0in = 32'hFFFFFFFE;
		A1in = 32'h00000000;
		CINin = 1'b1;
		#10;
		// Test 5: 0x80000000 + 0x80000000 + CIN=0 = 0x00000000, Cout=1
		A0in = 32'h80000000;
		A1in = 32'h80000000;
		CINin = 1'b0;
		#10;

        // -----------------------------------------------------------
        // 6. ZERO + ZERO (trivial case)
        // Expected: Sout=0x00000000, Cout=0
        // -----------------------------------------------------------
        A0in = 32'h00000000;
        A1in = 32'h00000000;
        CINin = 1'b0;
        #10;

        // -----------------------------------------------------------
        // 7. ALTERNATING BIT PATTERNS
        // Catches bit-level wiring mistakes and XOR/carry logic errors.
        // Expected: Sout=0xFFFFFFFF, Cout=0
        // -----------------------------------------------------------
        A0in = 32'hAAAAAAAA;
        A1in = 32'h55555555;
        CINin = 1'b0;
        #10;

        // 8. Alternating bits with CIN=1
        // Expected: Sout=0x00000000, Cout=1
        A0in = 32'hAAAAAAAA;
        A1in = 32'h55555555;
        CINin = 1'b1;
        #10;

        // -----------------------------------------------------------
        // 9. BOTH OPERANDS NON-ZERO (general addition)
        // Stresses full addition logic rather than passthrough.
        // Expected: Sout=0x2468ACF0 + 0x13579BDF = 0x37C048CF, Cout=0
        // -----------------------------------------------------------
        A0in = 32'h2468ACF0;
        A1in = 32'h13579BDF;
        CINin = 1'b0;
        #10;

        // 10. General addition with carry-out
        // Expected: Sout=0x9ABCDEF0 + 0x9ABCDEF0 = 0x3579BDE0, Cout=1
        A0in = 32'h9ABCDEF0;
        A1in = 32'h9ABCDEF0;
        CINin = 1'b0;
        #10;

        // 11. Arbitrary values with CIN=1
        // Expected: Sout=0x12345678 + 0xEDCBA987 + 1 = 0x00000000, Cout=1
        A0in = 32'h12345678;
        A1in = 32'hEDCBA987;
        CINin = 1'b1;
        #10;

        // -----------------------------------------------------------
        // 12-43. SINGLE-BIT CARRY WALK
        // Adds 0x00000001 to 0x000000FF...FF for each bit boundary,
        // walking a carry ripple through every bit position.
        // This directly targets ripple-carry chain bugs.
        // -----------------------------------------------------------
        begin : carry_walk
            integer j;
            for (j = 0; j < 32; j = j + 1) begin
                A0in = (32'h00000001 << j) - 1; // 2^j - 1: all ones up to bit j-1
                A1in = 32'h00000000;
                CINin = 1'b1;                    // carry-in triggers ripple from bit 0
                #10;
            end
        end

		/*
        // -----------------------------------------------------------
        // 2. LEAKAGE POWER TESTS (Min and Max)
        // -----------------------------------------------------------
        // Min leakage: all inputs 0, all transistors in lowest leakage state
        A0in = 32'h00000000;
        A1in = 32'h00000000;
        CINin = 1'b0;
        #50;
        
        // Max leakage: all inputs 1, maximum transistors conducting
        A0in = 32'hFFFFFFFF;
        A1in = 32'hFFFFFFFF;
        CINin = 1'b1;
        #50;
        // -----------------------------------------------------------
        // 3. AVERAGE POWER TEST
        // 20 pseudo-random vectors via LFSR, switching every 10ns
        // to simulate realistic switching activity
        // -----------------------------------------------------------
        lfsr = 32'hACE1ACE1; // Seed
        for(i = 0; i < 20; i = i + 1) begin
            A0in = lfsr;
            lfsr = {lfsr[30:0], lfsr[31]^lfsr[21]^lfsr[1]^lfsr[0]};
            A1in = lfsr;
            lfsr = {lfsr[30:0], lfsr[31]^lfsr[21]^lfsr[1]^lfsr[0]};
            CINin = lfsr[0];
            #10;
        end
		*/
        
        $finish;
    end
endmodule