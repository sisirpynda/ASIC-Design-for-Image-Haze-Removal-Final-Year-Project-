//`include "local_atmospheric_light_calculation.v"
//`include "global_atmospheric_light_calculation.v"
module Dynamic_Atmosphere_Light_Estimation (en, min_all, rmin, gmin, bmin,Ar_global_in, Ag_global_in, Ab_global_in,I_dark, clk, Ar_global_o, Ag_global_o, Ab_global_o,Ar_local_o, Ag_local_o, Ab_local_o);

input [7:0] Ar_global_in, Ag_global_in, Ab_global_in, I_dark, min_all, rmin, gmin, bmin;
input clk, en;

output [7:0] Ar_local_o, Ag_local_o, Ab_local_o, Ar_global_o, Ag_global_o, Ab_global_o;
wire [7:0] min_all_o, rmin_o, gmin_o, bmin_o;
wire [7:0] Ar_global, Ag_global, Ab_global, Ar_local_tomux;
wire en_inv, clk_to_LALC;

assign en_inv = ~en;

and lalc_CLK_GATING(clk_to_LALC,en_inv,clk);

local_atmospheric_light_calculation_alternate lalc(Ar_global_in, Ag_global_in, Ab_global_in, I_dark, clk_to_LALC, Ar_local_tomux, Ag_local_o, Ab_local_o);

assign Ar_local_o = en?Ar_global_in:Ar_local_tomux;

p p_DALE_to_GALC_1(min_all,clk,min_all_o);
p p_DALE_to_GALC_2(rmin,clk,rmin_o);
p p_DALE_to_GALC_3(gmin,clk,gmin_o);
p p_DALE_to_GALC_4(bmin,clk,bmin_o);

global_atmospheric_light_calculation galc(min_all_o, rmin_o, gmin_o, bmin_o, Ar_global, Ag_global, Ab_global);

p p_DALE_from_GALC_1(Ar_global,clk,Ar_global_o);
p p_DALE_from_GALC_2(Ag_global,clk_to_LALC,Ag_global_o);
p p_DALE_from_GALC_3(Ab_global,clk_to_LALC,Ab_global_o);

endmodule


