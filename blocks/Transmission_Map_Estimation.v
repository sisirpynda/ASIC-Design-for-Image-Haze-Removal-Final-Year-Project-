//`include "three_channel_edge_detection.v"
//`include "modified_dark_channel.v"
//`include "transmission_calculation.v"
//`include "p.v"
module Transmission_Map_Estimation (en,a,b,c,d,e,f,g,h,i,Ar_local, Ag_local, Ab_local,clk, tx_inv, mr, mg, mb, I_dark, min_all,w,w1);

input [23:0] a,b,c,d,e,f,g,h,i;
input clk, en;
input [4:0] w;
input [7:0] Ar_local, Ag_local, Ab_local;
output [7:0] mr, mg, mb, min_all, I_dark; //final I_dark output
output [11:0] tx_inv; 
output w1;
wire [7:0] I_dark_w, I_dark_tc;
wire en_inv, w2;
wire [7:0] Ag_local_en, Ab_local_en;

three_channel_edge_detection tced(en, a, b, c, d, e, f, g, h, i, w1);
and edge_output_control(w2, en_inv, w1);

modified_dark_channel mdc(w2,a,b,c,d,e,f,g,h,i,I_dark_w,mr,mg,mb,min_all);

p p_I_dark(I_dark_w,clk,I_dark);
p p_I_dark_to_tc(I_dark,clk,I_dark_tc);

assign Ag_local_en = en?Ar_local:Ag_local;
assign Ab_local_en = en?Ar_local:Ab_local;
assign en_inv = ~en;

transmission_calculation tc(en_inv,I_dark_tc, Ar_local, Ag_local_en, Ab_local_en,clk, tx_inv, w);

endmodule
