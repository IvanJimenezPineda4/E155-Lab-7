// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Bitwise XOR of state with round key

module aes_add_round_key(input logic [127:0] round_key,
                         input logic [127:0] old_text,
                         output logic [127:0] new_text);

    assign new_text = round_key ^ old_text;

endmodule