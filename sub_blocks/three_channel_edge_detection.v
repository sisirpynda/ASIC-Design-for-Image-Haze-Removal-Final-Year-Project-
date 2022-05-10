//`include "ED.v"
module three_channel_edge_detection(en,a,b,c,d,e,f,g,h,i,out);

input [23:0] a,b,c,d,e,f,g,h,i;
input en;
output reg out;

wire  EDr_o,EDg_o,EDb_o;

ED EDr(en, a[23:16],b[23:16],c[23:16],d[23:16],e[23:16],f[23:16],g[23:16],h[23:16],i[23:16],EDr_o);
ED EDg(en, a[15:8],b[15:8],c[15:8],d[15:8],e[15:8],f[15:8],g[15:8],h[15:8],i[15:8],EDg_o);
ED EDb(en, a[7:0],b[7:0],c[7:0],d[7:0],e[7:0],f[7:0],g[7:0],h[7:0],i[7:0],EDb_o);

always @(*) begin
if (en == 0 )
	out = EDr_o || EDg_o || EDb_o;
end

endmodule


