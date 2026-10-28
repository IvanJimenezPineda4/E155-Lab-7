// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Testbench for aes_controller FSM module

`timescale 1 ns / 1 ps

module aes_controller_tb();

    logic       clk, load;
    logic [3:0] current_round;
    logic       update_regs, done;
    logic       error;

    // Instantiate device under test
    aes_controller dut(
        .clk(clk),
        .load(load),
        .current_round(current_round),
        .update_regs(update_regs),
        .done(done)
    );

    // Generate clock (10 ns period)
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end

    initial begin
        error = 1'b0;
        load  = 1'b1;
        #22;
        // Verify reset/START state while load is asserted
        assert (current_round === 4'd1 && done === 1'b0)
        else begin
            $display("Error during load: current_round = %d, done = %b", current_round, done);
            error = 1'b1;
        end

        // Deassert load to begin rounds 1..10 (2 cycles per round = 20 cycles = 200 ns)
        load = 1'b0;
        #220;

        // Verify controller reaches RETURN state with current_round == 11 and done == 1
        assert (current_round === 4'd11 && done === 1'b1)
        else begin
            $display("Error after 10 rounds: current_round = %d, done = %b", current_round, done);
            error = 1'b1;
        end

        if (error) $display("Simulation failed");
        else       $display("Simulation passed");
        $stop();
    end

endmodule