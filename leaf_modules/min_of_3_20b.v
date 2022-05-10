module min_of_3_20b(in_a, in_b, in_c, out);

input [19:0] in_a, in_b, in_c;
output reg [19:0] out;

always @(*)
begin
	if(in_a > in_b)
		begin
			if(in_a > in_c)
				out = in_a;
			else
				out = in_c;
		end
	else
		begin
			if(in_b > in_c)
				out = in_b;
			else
				out = in_c;
		end
end

endmodule

//testbench
/*
module test_min_of_3;

reg [7:0] a, b, c;
wire [7:0] o;

min_of_3 test_min_of_3(a,b,c,o);

initial
	begin
		a = 8'b11110000;
		b = 8'b10100110;
		c = 8'b01010101;

		#20
		
		
		a = 8'b01110000;
		b = 8'b10111000;
		c = 8'b10010000;

		#20

		
		a = 8'b00000000; 
		b = 8'b00000001;
		c = 8'b10100000;

		#100 $finish;
	end

initial
	$monitor("%1t, a = %b, b = %b, c = %b, out = %b", $time, a, b, c, o);

endmodule
*/
