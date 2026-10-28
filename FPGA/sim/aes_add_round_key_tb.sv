// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/26/2026
// Testbench for aes_add_round_key module

`timescale 1 ns / 1 ps

module aes_add_round_key_tb();

    logic clk, reset;
    logic error;

    logic [127:0] round_key;
    logic [127:0] old_text, new_text;

    // Instantiate device under test
    aes_add_round_key dut(
        .round_key(round_key),
        .old_text(old_text),
        .new_text(new_text)
    );

    // Generate clock
    always begin
        clk = 1'b1; #5;
        clk = 1'b0; #5;
    end

    initial begin
        reset = 1'b1; error = 1'b0; #22; reset = 1'b0;
        #10;

        // Test Case 1: FIPS-197 Appendix B Initial AddRoundKey (Round 0)
        round_key = 128'h2B7E1516_28AED2A6_ABF71588_09CF4F3C;
        old_text  = 128'h3243F6A8_885A308D_313198A2_E0370734;
        #50;
        assert (new_text === 128'h193DE3BE_A0F4E22B_9AC68D2A_E9F84808)
        else begin
            $display("Error! Test 1 new_text = %h, expected 193DE3BE_A0F4E22B_9AC68D2A_E9F84808", new_text);
            error = 1'b1;
        end
        #10;

        // Test Case 2: FIPS-197 Appendix B Round 1 AddRoundKey
        round_key = 128'hA0FAFE17_88542CB1_23A33939_2A6C7605;
        old_text  = 128'h046681E5_E0CB199A_48F8D37A_2806264C;
        #50;
        assert (new_text === 128'hA49C7FF2_689F352B_6B5BEA43_026A5049)
        else begin
            $display("Error! Test 2 new_text = %h, expected A49C7FF2_689F352B_6B5BEA43_026A5049", new_text);
            error = 1'b1;
        end
        #10;

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule