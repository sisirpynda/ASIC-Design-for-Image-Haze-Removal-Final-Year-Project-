module line_buffer(in,out_r, out_g, out_b);
input [23:0]in;
output [7:0] out_r, out_g, out_b;

assign out_r = in[23:16];
assign out_g = in[15:8];
assign out_b = in[7:0];

endmodule
