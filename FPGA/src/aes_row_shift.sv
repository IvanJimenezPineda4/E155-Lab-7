// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// shift rows of the 128-bit state to the left

module aes_row_shift(input logic [127:0] substituted_text,
                     output logic [127:0] shifted_text);

    assign shifted_text[127:96] = {substituted_text[127:120], substituted_text[87:80],  substituted_text[47:40],  substituted_text[7:0]};
    assign shifted_text[95:64]  = {substituted_text[95:88],   substituted_text[55:48],  substituted_text[15:8],   substituted_text[103:96]};
    assign shifted_text[63:32]  = {substituted_text[63:56],   substituted_text[23:16],  substituted_text[111:104], substituted_text[71:64]};
    assign shifted_text[31:0]   = {substituted_text[31:24],   substituted_text[119:112], substituted_text[79:72],  substituted_text[39:32]};

endmodule