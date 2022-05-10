
//`include "p.v"
//`include "min_of_3_20b.v"
//`include "lut.v"

//`include "2x1_mux.v"

/*

module transmission_calculation(I_dark, Ar_local, Ag_local, Ab_local,clk, tx_inv);

input [7:0] Ar_local, Ag_local, Ab_local, I_dark;
input clk;
output reg [10:0] tx_inv;
wire [7:0]Ar_localo, Ag_localo, Ab_localo, wr, wg, wb,wro,wgo,wbo;
wire [7:0] lut_rin, lut_gin, lut_bin;
wire [19:0] min_r_in, min_g_in, min_b_in,shift_w;

assign wr = Ar_local - I_dark;
assign wg = Ag_local - I_dark;
assign wb = Ab_local - I_dark;

p p1(wr,clk,wro);
p p2(Ar_local,clk,Ar_localo);
p p3(wg,clk,wgo);
p p4(Ag_local,clk,Ag_localo);
p p5(wb,clk,wbo);
p p6(Ab_local,clk,Ab_localo);

always @(*)
	begin
		if (Ar_local > I_dark)
			lut_rin = wro;
		else
			lut_rin = 8'b1;
		
		if (Ag_local > I_dark)
			lut_gin = wgo;
		else				
			lut_gin = 8'b1;
		
		if (Ab_local > I_dark)
			lut_bin = wbo;
		else				
			lut_bin = 8'b1;

	end
assign sel_wr = Ar_local > I_dark;
assign sel_wg = Ag_local > I_dark;
assign sel_wb = Ab_local > I_dark;
 
mux mux1(8'b1,wro,sel_wr, lut_rin);
mux mux2(8'b1,wgo,sel_wg, lut_gin);
mux mux3(8'b1,wbo,sel_wb, lut_bin);

assign min_r_in = Ar_localo/lut_rin;
assign min_g_in = Ag_localo/lut_gin;
assign min_b_in = Ab_localo/lut_bin;

min_of_3_20b min(min_r_in, min_g_in, min_b_in, shift_w);

always @(*)
	tx_inv = shift_w>>9;

endmodule
*/

module transmission_calculation(en, I_dark, Ar_local, Ag_local, Ab_local,clk, tx_inv,w); //w here is omega

input [7:0] Ar_local, Ag_local, Ab_local, I_dark;
input clk, en;
output reg [11:0] tx_inv;
wire [7:0]Ar_localo, Ag_localo, Ab_localo, wr, wg, wb,wro,wgo,wbo;
wire [7:0] lut_rin, lut_gin, lut_bin;
wire [19:0] min_r_in, min_g_in, min_b_in,shift_w;
input [4:0] w;
wire [11:0] wro_inv, wgo_inv, wbo_inv;
wire [7:0]shiftedwxI_dark;
wire [12:0] I_darkxw;
wire clk_gating;

assign I_darkxw = (I_dark*w)>>5;
assign shiftedwxI_dark = I_darkxw[7:0];


assign wr = Ar_local - shiftedwxI_dark;
assign wg = Ag_local - shiftedwxI_dark;
assign wb = Ab_local - shiftedwxI_dark;

p p1(wr,clk,wro);
p p2(Ar_local,clk,Ar_localo);

and clk_gating_g(clk_gating,en,clk);

p p3(wg,clk,wgo);
p p4(Ag_local,clk_gating,Ag_localo);
p p5(wb,clk,wbo);
p p6(Ab_local,clk_gating,Ab_localo);


lut lut1(wro,wro_inv);
lut lut2(wgo,wgo_inv);
lut lut3(wbo,wbo_inv);

assign min_r_in = wro_inv*Ar_localo;
assign min_g_in = wgo_inv*Ag_localo;
assign min_b_in = wbo_inv*Ab_localo;

min_of_3_20b min(min_r_in, min_g_in, min_b_in, shift_w);

always @(shift_w or min_r_in)
begin
	if (en == 1)
	tx_inv = shift_w>>9; //only 3 decimal places going from here
	else 
	tx_inv = min_r_in>>9;
end

endmodule





