// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Testbench for aes_sub_bytes module

`timescale 1 ns / 1 ps

module aes_sub_bytes_tb();

    logic clk, reset;
    logic error;

    logic [127:0] a, y;

    // Instantiate device under test
    aes_sub_bytes dut(
        .clk(clk),
        .a(a),
        .y(y)
    );

    // Generate clock
    always begin
        clk = 1'b1; #5;
        clk = 1'b0; #5;
    end

    initial begin
        reset = 1'b1; error = 1'b0; #22; reset = 1'b0;
        #10;

        // Test Case 1: FIPS-197 Appendix B Round 1 SubBytes
        a = 128'h193DE3BE_A0F4E22B_9AC68D2A_E9F84808;
        #50;
        assert (y === 128'hD42711AE_E0BF98F1_B8B45DE5_1E415230)
        else begin
            $display("Error! Round 1 SubBytes = %h, expected D42711AE_E0BF98F1_B8B45DE5_1E415230", y);
            error = 1'b1;
        end
        #10;

        // Test Case 2: FIPS-197 Appendix B Round 2 SubBytes
        a = 128'hA49C7FF2_689F352B_6B5BEA43_026A5049;
        #50;
        assert (y === 128'h49DED289_45DB96F1_7F39871A_7702533B)
        else begin
            $display("Error! Round 2 SubBytes = %h, expected 49DED289_45DB96F1_7F39871A_7702533B", y);
            error = 1'b1;
        end
        #10;

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule