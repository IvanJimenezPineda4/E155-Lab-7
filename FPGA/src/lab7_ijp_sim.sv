// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Top level module

module lab7_ijp( input logic clk,
                input logic sck,
                input logic sdi,
                output logic sdo,
                input  logic load,
                output logic done);

    logic [127:0] key, plaintext, cyphertext;

    aes_spi  spi(sck, sdi, sdo, done, key, plaintext, cyphertext);
    aes_core core(clk, load, key, plaintext, done, cyphertext);

endmodule