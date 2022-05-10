//`include "min_of_3.v"
//`include "p.v"
//`include "alpha_calculation.v"

module local_atmospheric_light_calculation_alternate(Ar_global, Ag_global, Ab_global, I_dark, clk, Ar_local,Ag_local, Ab_local);

input [7:0] Ar_global, Ag_global, Ab_global, I_dark;
input clk;
output reg [7:0] Ar_local, Ag_local, Ab_local;
wire [7:0] Ar_go, Ag_go, Ab_go, Ar_dark, Ag_dark, Ab_dark, Ar_darko, Ag_darko, Ab_darko, Ar_go_o, Ag_go_o, Ab_go_o, w_min, w_mino;
wire [7:0] dark_diff, Th_dark;
wire [6:0] al;
//wire [7:0] varr_1, varg_1, varb_1;
//wire [8:0] varr_2, varg_2, varb_2;
wire [7:0] one_minus_al, Ar_alpha_o, Ag_alpha_o, Ab_alpha_o;
wire [15:0] Ar_alpha_s1, Ag_alpha_s1, Ab_alpha_s1;
wire [11:0] alt_varr, alt_varg, alt_varb;

min_of_3 min_rgb(Ar_global, Ag_global, Ab_global, w_min);
p p1(w_min,clk,w_mino);
p p2(Ar_global, clk, Ar_go);
p p3(Ag_global, clk, Ag_go);
p p4(Ab_global, clk, Ab_go);



//assign varr_1 = Ar_go>>1;
//assign varg_1 = Ag_go>>1;
//assign varb_1 = Ab_go>>1;
//assign varr_2 = varr_1 + Ar_go;
//assign varg_2 = varg_1 + Ag_go;
//assign varb_2 = varb_1 + Ab_go;
//assign Ar_dark = varr_2>>1;
//assign Ag_dark = varg_2>>1;
//assign Ab_dark = varb_2>>1;

assign  alt_varr = Ar_go*4'b1111;
assign  alt_varg = Ag_go*4'b1111;
assign  alt_varb = Ab_go*4'b1111;
assign Ar_dark = alt_varr [11:4];
assign Ag_dark = alt_varg [11:4];
assign Ab_dark = alt_varb [11:4];


p p5(Ar_dark, clk, Ar_darko);
p p6(Ar_go, clk, Ar_go_o);

p p7(Ag_dark, clk, Ag_darko);
p p8(Ag_go, clk, Ag_go_o);

p p9(Ab_dark, clk, Ab_darko);
p p10(Ab_go, clk, Ab_go_o);

assign Th_dark = w_mino>>1;

assign dark_diff = I_dark - Th_dark;

alpha_calculation alc1(dark_diff,Th_dark,al);

//else if alpha case

assign one_minus_al = 8'd128 - al;
assign Ar_alpha_s1 = ((Ar_go_o*al) + (one_minus_al*Ar_darko));
assign Ag_alpha_s1 = ((Ag_go_o*al) + (one_minus_al*Ag_darko));
assign Ab_alpha_s1 = ((Ab_go_o*al) + (one_minus_al*Ab_darko));
assign Ar_alpha_o = Ar_alpha_s1>>7;
assign Ag_alpha_o = Ag_alpha_s1>>7;
assign Ab_alpha_o = Ab_alpha_s1>>7;

always @(*)
	begin
		if(I_dark > 2'd2*Th_dark)
			begin
				Ar_local = Ar_go_o;
				Ag_local = Ag_go_o;
				Ab_local = Ab_go_o;
			end

		else if (2'd2*Th_dark > I_dark && I_dark >= Th_dark)
			begin
				
				Ar_local = Ar_alpha_o;	
				Ag_local = Ag_alpha_o;	
				Ab_local = Ab_alpha_o;	
			end

		else
			begin
				
				Ar_local = Ar_darko;
				Ag_local = Ag_darko;
				Ab_local = Ab_darko;
			end
	end

endmodule

//testbench 
/*
module test_lalc;
reg [7:0] Ar_global, Ag_global, Ab_global, I_dark;
reg clk;
wire [7:0] Ar_local, Ag_local, Ab_local;

local_atmospheric_light_calculation lalc_test_dut(Ar_global, Ag_global, Ab_global, I_dark, clk, Ar_local,Ag_local, Ab_local);

initial
	begin
		clk = 1'b0;
		I_dark = 8'd140;
		Ar_global = 8'd180;
		Ag_global = 8'd200;
		Ab_global = 8'd200;
		#80 $finish;
	end
always 
	#20 clk = ~clk;

endmodule */

