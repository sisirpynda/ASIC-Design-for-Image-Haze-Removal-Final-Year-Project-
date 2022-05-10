//`include "min_of_3.v"
//`include "2x1_mux.v"

module modified_dark_channel(ED_in, a, b, c, d, e, f, g, h, i, out,mr,mg,mb,min_all); // other outputs input for global atmospheric light calculation

input [23:0] a,b,c,d,e,f,g,h,i;
input ED_in;
output [7:0]out; //set to reg on 2/12/22

wire [7:0] mr_1, mr_2, mr_3, mg_1, mg_2, mg_3,mb_1, mb_2, mb_3;
wire [7:0] dc_r, dc_g, dc_b;
output [7:0] mr, mg, mb, min_all;

	//red 
		min_of_3 min_r_1(a[7:0],b[7:0],c[7:0],mr_1);
		min_of_3 min_r_2(d[7:0],e[7:0],f[7:0],mr_2);
		min_of_3 min_r_3(g[7:0],h[7:0],i[7:0],mr_3);
		min_of_3 min_r(mr_1, mr_2, mr_3, mr);
	//green
		min_of_3 min_g_1(a[15:8],b[15:8],c[15:8],mg_1);
		min_of_3 min_g_2(d[15:8],e[15:8],f[15:8],mg_2);
		min_of_3 min_g_3(g[15:8],h[15:8],i[15:8],mg_3);
		min_of_3 min_g(mg_1, mg_2, mg_3, mg);

	//blue
		min_of_3 min_b_1(a[23:16],b[23:16],c[23:16],mb_1);
		min_of_3 min_b_2(d[23:16],e[23:16],f[23:16],mb_2);
		min_of_3 min_b_3(g[23:16],h[23:16],i[23:16],mb_3);
		min_of_3 min_b(mb_1, mb_2, mb_3, mb);

	//min_all
		min_of_3 min_all1(mr,mg,mb,min_all);


	mux mux_r(mr, e[7:0], ED_in, dc_r);
	mux mux_g(mg, e[15:8], ED_in, dc_g);
	mux mux_b(mb, e[23:16], ED_in, dc_b);

	min_of_3 dark_channel_op(dc_r,dc_g, dc_b, out);


endmodule
