// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Testbench for aes_key_expansion module

`timescale 1 ns / 1 ps

module aes_key_expansion_tb();

    logic clk, reset;
    logic error;

    logic [3:0]   round;
    logic [127:0] key, round_key;

    // Instantiate device under test
    aes_key_expansion dut(
        .clk(clk),
        .key(key),
        .round(round),
        .round_key(round_key)
    );

    // Generate clock
    always begin
        clk = 1'b1; #5;
        clk = 1'b0; #5;
    end

    initial begin
        reset = 1'b1; error = 1'b0; #22; reset = 1'b0;
        #10;

        // Test Case 1: Round 1 Key Expansion (FIPS-197 Appendix A.1)
        key   = 128'h2B7E1516_28AED2A6_ABF71588_09CF4F3C;
        round = 4'd1;
        #50;
        assert (round_key === 128'hA0FAFE17_88542CB1_23A33939_2A6C7605)
        else begin
            $display("Error! Round 1 key = %h, expected A0FAFE17_88542CB1_23A33939_2A6C7605", round_key);
            error = 1'b1;
        end
        #10;

        // Test Case 2: Round 2 Key Expansion (FIPS-197 Appendix A.1)
        key   = 128'hA0FAFE17_88542CB1_23A33939_2A6C7605;
        round = 4'd2;
        #50;
        assert (round_key === 128'hF2C295F2_7A96B943_5935807A_7359F67F)
        else begin
            $display("Error! Round 2 key = %h, expected F2C295F2_7A96B943_5935807A_7359F67F", round_key);
            error = 1'b1;
        end
        #10;

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule