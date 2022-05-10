module greater_than_comparitor(clk, in_a, in_b, out);
input [7:0] in_a, in_b;
input clk;
output reg out;
always @(posedge clk)
begin
	out = in_a > in_b;
end
endmodule

//testbench

module test_greater_than_comparitor;
reg [7:0] a,b;
wire o;
reg c;

greater_than_comparitor test_greater_than_comparitor(c, a, b, o);

initial
begin
	c=1'b0;
	#20
	a = 8'b11110000;
	b = 8'b00001111;

	#20
	a = 8'b00001111;
	b = 8'b11110000;

	#20
	a = 8'b10101010;
	b = 8'b10101010;
	
	#100 $finish;
end

always #10 c = ~c;

initial
	$monitor("time = %1t, a = %b, b = %b, output = %b, clk = %b ", $time, a, b, o, c);

endmodule

