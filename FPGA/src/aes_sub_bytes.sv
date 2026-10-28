// E155: Lab 7 - The Advanced Encryption Standard
// Ivan Jimenez Pineda, iijimenezpineda@g.hmc.edu
// 10/25/2026
// apply 16 synchronous sbox lookups to all 16 bytes of the 128-bit state

module aes_sub_bytes(input  logic         clk,
                     input  logic [127:0] a,
                     output logic [127:0] y);

    sbox_sync sb0 (.clk(clk), .a(a[127:120]), .y(y[127:120]));
    sbox_sync sb1 (.clk(clk), .a(a[119:112]), .y(y[119:112]));
    sbox_sync sb2 (.clk(clk), .a(a[111:104]), .y(y[111:104]));
    sbox_sync sb3 (.clk(clk), .a(a[103:96]),  .y(y[103:96]));

    sbox_sync sb4 (.clk(clk), .a(a[95:88]),   .y(y[95:88]));
    sbox_sync sb5 (.clk(clk), .a(a[87:80]),   .y(y[87:80]));
    sbox_sync sb6 (.clk(clk), .a(a[79:72]),   .y(y[79:72]));
    sbox_sync sb7 (.clk(clk), .a(a[71:64]),   .y(y[71:64]));

    sbox_sync sb8 (.clk(clk), .a(a[63:56]),   .y(y[63:56]));
    sbox_sync sb9 (.clk(clk), .a(a[55:48]),   .y(y[55:48]));
    sbox_sync sb10(.clk(clk), .a(a[47:40]),   .y(y[47:40]));
    sbox_sync sb11(.clk(clk), .a(a[39:32]),   .y(y[39:32]));

    sbox_sync sb12(.clk(clk), .a(a[31:24]),   .y(y[31:24]));
    sbox_sync sb13(.clk(clk), .a(a[23:16]),   .y(y[23:16]));
    sbox_sync sb14(.clk(clk), .a(a[15:8]),    .y(y[15:8]));
    sbox_sync sb15(.clk(clk), .a(a[7:0]),     .y(y[7:0]));

endmodule