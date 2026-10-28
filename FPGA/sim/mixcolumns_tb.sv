// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Testbench for mixcolumns module

`timescale 1 ns / 1 ps

module mixcolumns_tb();

    logic clk, reset, error;
    logic [127:0] a, y;

    mixcolumns dut(a, y);

    always begin
        clk = 1'b1; #5; clk = 1'b0; #5;
    end

    initial begin
        reset = 1'b1; error = 1'b0; #22; reset = 1'b0;
        #10;

        a = 128'hD4BF5D30_E0B452AE_B84111F1_1E2798E5; #50;
        assert (y === 128'h046681E5_E0CB199A_48F8D37A_2806264C)
        else begin $display("Error! Got %h", y); error = 1'b1; end #10;

        a = 128'h49DB873B_45395389_7F02D2F1_77DE961A; #50;
        assert (y === 128'h584DCAF1_1B4B5AAC_DBE7CAA8_1B6BB0E5)
        else begin $display("Error! Got %h", y); error = 1'b1; end #10;

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule