module p(d,clk,q);

input [7:0]d;
input clk;
output reg [7:0]q;

always @(posedge clk)
	q = d;

endmodule
