// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// AES encryption core module that is the datapath and controller

module aes_core(input  logic clk, 
                input  logic load,
                input  logic [127:0] key, 
                input  logic [127:0] plaintext, 
                output logic done, 
                output logic [127:0] cyphertext);

    logic [3:0] current_round;
    logic update_regs;
    
    logic [127:0] current_round_key, next_round_key;
    logic [127:0] current_mixed_text, next_mixed_text;
    logic [127:0] key_mux_out, text_mux_out;
    logic [127:0] wip_text, substituted_text, shifted_text, round_10_shifted_text;

    // control logic module
    aes_controller controller(.clk(clk), .load(load), .current_round(current_round), .update_regs(update_regs), .done(done));

    // datapath multiplexers and round registers
    assign key_mux_out  = (current_round == 4'd1) ? key : current_round_key;
    assign text_mux_out = (current_round == 4'd1) ? plaintext : current_mixed_text;

    always_ff @(posedge clk) begin
        if (load) begin
            current_round_key <= key;
            current_mixed_text <= 128'b0;
            round_10_shifted_text <= 128'b0;
        end else if (update_regs) begin
            current_round_key <= next_round_key;
            current_mixed_text <= next_mixed_text;
            if (current_round == 4'd10)
                round_10_shifted_text <= shifted_text;
        end
    end

    // AES datapath modules
    aes_key_expansion key_exp(clk, key_mux_out, current_round, next_round_key);
    aes_add_round_key add_key_x(key_mux_out, text_mux_out, wip_text);
    aes_sub_bytes sub_bytes(clk, wip_text, substituted_text);
    aes_row_shift row_shi(substituted_text, shifted_text);
    mixcolumns mix_col(shifted_text, next_mixed_text);
    aes_add_round_key add_key_10(current_round_key, round_10_shifted_text, cyphertext);

endmodule