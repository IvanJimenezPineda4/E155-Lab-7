// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Testbench for galoismult module

`timescale 1 ns / 1 ps

module galoismult_tb();

    logic clk, reset, error;
    logic [7:0] a, y;

    galoismult dut(a, y);

    always begin
        clk = 1'b1; #5; clk = 1'b0; #5;
    end

    initial begin
        reset = 1'b1; error = 1'b0; #22; reset = 1'b0;
        #10;

        a = 8'h85; #50; assert (y === 8'h11) else begin $display("Error! Expected 11, got %h", y); error = 1'b1; end #10;
        a = 8'h19; #50; assert (y === 8'h32) else begin $display("Error! Expected 32, got %h", y); error = 1'b1; end #10;
        a = 8'hBC; #50; assert (y === 8'h63) else begin $display("Error! Expected 63, got %h", y); error = 1'b1; end #10;

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule