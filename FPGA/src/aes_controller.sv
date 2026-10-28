// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// FSM controller that controls waiting states and rounds

module aes_controller(input  logic clk,
                      input  logic load,
                      output logic [3:0] current_round,
                      output logic update_regs,
                      output logic done);

    // define states for FSM
    typedef enum logic [1:0] {
        START = 2'b00,
        WAIT = 2'b01, // 1 cycle wait for sbox_sync read
        CALC = 2'b10, // MixColumns & KeyExpansion outputs
        RETURN = 2'b11  // Encryption complete
    } statetype;

    statetype current_state, next_state;
    logic [3:0] next_round;

    always_ff @(posedge clk) begin
        if (load) begin
            current_state <= START;
            current_round <= 4'd1;
        end else begin
            current_state <= next_state;
            current_round <= next_round;
        end
    end

    always_comb begin
        next_state  = current_state;
        next_round  = current_round;
        update_regs = 1'b0;

        case (current_state)
            START: begin
                next_round = 4'd1;
                if (!load) next_state = WAIT;
            end
            
            WAIT: begin
                next_state = CALC;
            end

            CALC: begin
                update_regs = 1'b1;
                next_round  = current_round + 4'd1;
                next_state  = (current_round == 4'd10) ? RETURN : WAIT;
            end

            RETURN: begin
                if (load) next_state = START;
            end

            default: next_state = START;
        endcase
    end

    assign done = (current_state == RETURN) & (current_round == 4'd11);

endmodule