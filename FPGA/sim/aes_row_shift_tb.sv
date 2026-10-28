// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Testbench for aes_row_shift module

`timescale 1 ns / 1 ps

module aes_row_shift_tb();

    logic clk, reset;
    logic error;

    logic [127:0] substituted_text, shifted_text;

    // Instantiate device under test
    aes_row_shift dut(
        .substituted_text(substituted_text),
        .shifted_text(shifted_text)
    );

    // Generate clock
    always begin
        clk = 1'b1; #5;
        clk = 1'b0; #5;
    end

    initial begin
        reset = 1'b1; error = 1'b0; #22; reset = 1'b0;
        #10;

        // Test Case 1: FIPS-197 Appendix B Round 1 ShiftRows
        substituted_text = 128'hD42711AE_E0BF98F1_B8B45DE5_1E415230;
        #50;
        assert (shifted_text === 128'hD4BF5D30_E0B452AE_B84111F1_1E2798E5)
        else begin
            $display("Error! Shift 1 = %h, expected D4BF5D30_E0B452AE_B84111F1_1E2798E5", shifted_text);
            error = 1'b1;
        end
        #10;

        // Test Case 2: Sequential byte pattern
        substituted_text = 128'h15141312_11100908_07060504_03020100;
        #50;
        assert (shifted_text === 128'h15100500_11060112_07021308_03140904)
        else begin
            $display("Error! Shift 2 = %h, expected 15100500_11060112_07021308_03140904", shifted_text);
            error = 1'b1;
        end
        #10;

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule