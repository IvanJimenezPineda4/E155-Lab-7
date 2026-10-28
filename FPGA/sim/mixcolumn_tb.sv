// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/27/2026
// Testbench for mixcolumn module

`timescale 1 ns / 1 ps

module mixcolumn_tb();

    logic clk, reset, error;
    logic [31:0] a, y;

    mixcolumn dut(a, y);

    always begin
        clk = 1'b1; #5; clk = 1'b0; #5;
    end

    initial begin
        reset = 1'b1; error = 1'b0; #22; reset = 1'b0;
        #10;

        a = 32'hD4BF5D30; #50; assert (y === 32'h046681E5) else begin $display("Error! Expected 046681E5, got %h", y); error = 1'b1; end #10;
        a = 32'h49DB873B; #50; assert (y === 32'h584DCAF1) else begin $display("Error! Expected 584DCAF1, got %h", y); error = 1'b1; end #10;
        a = 32'hACC1D6B8; #50; assert (y === 32'h75EC0993) else begin $display("Error! Expected 75EC0993, got %h", y); error = 1'b1; end #10;

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule