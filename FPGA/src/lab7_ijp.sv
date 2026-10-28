// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// Top level module

module lab7_ijp( input logic sck,
                input logic sdi,
                output logic sdo,
                input  logic load,
                output logic done);

    logic clk;
    logic [127:0] key, plaintext, cyphertext;

    // High speed oscillator set to 6 MHz (2'b11)
    HSOSC #(.CLKHF_DIV("0b11")) hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    aes_spi  spi(sck, sdi, sdo, done, key, plaintext, cyphertext);
    aes_core core(clk, load, key, plaintext, done, cyphertext);

endmodule