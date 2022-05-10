/*
//`include "2x1_mux.v"
module inter_calc(dd, dn,ai,o);

input [10:0] dd, dn;
output [9:0]o;
output ai;
wire [8:0] in;
wire [8:0] ow, exp;

assign in = dd<<1;
assign ai = in > dn;
assign exp = dd - in;
//mux mux1(exp, in, ai, ow);

assign ow = ai?exp:in;

//always@(*)
assign o = (ow<<1);

endmodule



module alpha_calculation(dark_diff, denom, alpha);

input [10:0] dark_diff, denom;

output [6:0] alpha;
wire [9:0] w1, w2, w3, w4, w5, w6;

	//alpha = dark_diff/denom;
	inter_calc i1(dark_diff,denom,alpha[6],w1);
	inter_calc i2(w1,denom,alpha[5],w2);
	inter_calc i3(w2,denom,alpha[4],w3);
	inter_calc i4(w3,denom,alpha[3],w4);
	inter_calc i5(w4,denom,alpha[2],w5);
	inter_calc i6(w5,denom,alpha[1],w6);
	//inter_calc i7(dark_diff,denim,alpha[6],w);
	assign alpha[0] = (w6 << 1) > denom ; //just for now

endmodule
*/

//testbench


module test_alpha_calculation;

reg [7:0]dd,dn;
wire [6:0]al;

alpha_calculation alc1(dd,dn,al);

initial
	begin
		dd = 'd10;
		dn = 'd30;
		#20
		dd = 'd100;
		dn = 'd150;
		#20
		dd = 'd130;
		#20
		dd = 'd100;
		dn = 'd200;
		#100 $finish;
	end
initial
	$monitor("time = %1t, dark diff = %d, denom = %d, al = %b", $time, dd, dn, al);

endmodule



module alpha_calculation(dark_diff,denom,alpha);

input [7:0] dark_diff, denom;
output reg [6:0] alpha;
reg [15:0] temp;
integer i;

always @(dark_diff, denom)
	begin
		temp = dark_diff<<1;
		for(i=6;i>=1;i=i-1)
			begin
				alpha[i] = temp>=denom;
				temp = (temp>=denom)?((temp-denom)<<1):(temp<<1);	
			end 
		alpha[0] = temp>denom;
	end

endmodule



