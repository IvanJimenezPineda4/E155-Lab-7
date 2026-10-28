// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// make next round key

module aes_key_expansion(input  logic clk,
                         input  logic [127:0] key,
                         input  logic [3:0] round,
                         output logic [127:0] round_key);

    logic [31:0] shifted_column, first_column, substituted_column;
    logic [7:0] random_constant_byte;

    // RotWord on the least-significant word key[31:0]
    assign shifted_column = {key[23:0], key[31:24]};
    assign first_column   = key[127:96];

    // SubWord using 4 synchronous sboxes
    sbox_sync byte_sub[3:0](shifted_column, clk, substituted_column);

    // FIPS-197 Table 5, rounds 1 to 10
    always_comb begin
        case (round)
            4'd1: random_constant_byte = 8'h01;
            4'd2: random_constant_byte = 8'h02;
            4'd3: random_constant_byte = 8'h04;
            4'd4: random_constant_byte = 8'h08;
            4'd5: random_constant_byte = 8'h10;
            4'd6: random_constant_byte = 8'h20;
            4'd7: random_constant_byte = 8'h40;
            4'd8: random_constant_byte = 8'h80;
            4'd9: random_constant_byte = 8'h1B;
            4'd10: random_constant_byte = 8'h36;
            default: random_constant_byte = 8'h00;
        endcase
    end

    assign round_key[127:96] = substituted_column ^ first_column ^ {random_constant_byte, 24'b0};
    assign round_key[95:64]  = round_key[127:96]  ^ key[95:64];
    assign round_key[63:32]  = round_key[95:64]   ^ key[63:32];
    assign round_key[31:0]   = round_key[63:32]   ^ key[31:0];

endmodule