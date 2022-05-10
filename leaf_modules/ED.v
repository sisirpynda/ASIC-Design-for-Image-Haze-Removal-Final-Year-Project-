module ED(en, a, b, c, d, e, f, g, h, i, out);

input [7:0] a,b,c,d,e,f,g,h,i;
input en;
output reg out;

reg [7:0] edge_1, edge_2, edge_3, edge_4;

always @(*)
	begin
	if (en ==0)
		begin
			edge_1 = (a>i)?(a-i):(i-a);
			edge_2 = (b>h)?(b-h):(h-b);
			edge_3 = (c>g)?(c-g):(g-c);
			edge_4 = (d>f)?(d-f):(f-d);
		
			out = ( (edge_1 > 'd50) || (edge_2 > 'd50) || (edge_3 > 'd50) || (edge_4 > 'd50) );
	//	out = 0;
		end
	end

endmodule

//testbench
/* 
module test_ED;

reg [7:0] t_a, t_b, t_c, t_d, t_e, t_f, t_g, t_h, t_i;
wire o;

ED test_ED(t_a, t_b, t_c, t_d, t_e, t_f, t_g, t_h, t_i, o);

initial
	begin
		t_a = 'd180;
		t_b = 'd200;
		t_c = 'd200;
		t_d = 'd200;
		t_e = 'd200;
		t_f = 'd200;
		t_g = 'd200;
		t_h = 'd200;
		t_i = 'd210;

		#20

		t_a = 'd200;
		t_i = 'd200;
		t_c = 'd210;
		t_g = 'd160;

		#20

		t_c = 'd160;
		t_g = 'd210;

		#20		

		t_g = 'd200;
		t_c = 'd200;

		#100 $finish;
		
	end

initial
	$monitor("time = %1t, a = %d, b = %d, c = %d, d = %d, e = %d, f = %d, g = %d, h = %d, i = %d, out = %b", $time, t_a, t_b, t_c, t_d, t_e, t_f, t_g, t_h, t_i, o);

endmodule
*/

