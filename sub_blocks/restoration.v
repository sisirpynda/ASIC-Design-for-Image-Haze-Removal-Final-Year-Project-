
module p_9bit(d,clk,q);

input [7:0]d;
input clk;
output reg [7:0]q;

always @(posedge clk)
	q = d;

endmodule

//attempt 1

/*
module restoration(t_inv, clk, er, eg, eb, Ar_local, Ag_local, Ab_local, O_R, O_G, O_B);

input [10:0] t_inv;
input [7:0] er, eg, eb, Ar_local, Ag_local, Ab_local;
input clk;
output reg [7:0] O_R, O_G, O_B;

wire [8:0] wsr, wsg, wsb, wsro, wsgo, wsbo;
//wire [19:0] r_pre_1, g_pre_1, b_pre_1;
//wire [16:0] r_pre_2, g_pre_2, b_pre_2;
//wire [7:0] r_pre_3, g_pre_3, b_pre_3;

assign wsr = (er-Ar_local);
assign wsg = (eg-Ag_local);
assign wsb = (eb-Ab_local);

p_9bit p1(wsr,clk,wsro);
p_9bit p2(wsg,clk,wsgo);
p_9bit p3(wsb,clk,wsbo);

//assign r_pre_1 = t_inv*(wsro[7:0]);
//assign g_pre_1 = t_inv*(wsgo[7:0]);
//assign b_pre_1 = t_inv*(wsbo[7:0]);

//assign r_pre_2 = r_pre_1>>3;
//assign g_pre_2 = g_pre_1>>3;
//assign b_pre_2 = b_pre_1>>3;

//assign r_pre_3 = r_pre_2 + Ar_local;
//assign g_pre_3 = g_pre_2 + Ag_local;
//assign b_pre_3 = b_pre_2 + Ab_local;

//assign r_pre_3 = ((t_inv*wsro)>>3) + Ar_local;
//assign g_pre_3 = ((t_inv*wsgo)>>3) + Ab_local;
//assign b_pre_3 = ((t_inv*wsbo)>>3) + Ab_local;

always @(*)
	begin
		O_R =(((t_inv*wsro))>>3) + 'd100;
		O_G =(((t_inv*wsgo))>>3) + 'd100;
		O_B =(((t_inv*wsbo))>>3) + 'd100;
	end
endmodule
*/


//attempt 2

module restoration(en, t_inv, clk, er, eg, eb, Ar_local, Ag_local, Ab_local, O_R, O_G, O_B);

input [11:0] t_inv;
input [7:0] er, eg, eb, Ar_local, Ag_local, Ab_local;
wire [7:0] Ag,Ab;
input clk, en;
output reg [7:0] O_R, O_G, O_B;
wire [7:0] wsrp, wsgp, wsbp, wsrop, wsgop, wsbop;
//wire [7:0] wsrn, wsgn, wsbn, wsron, wsgon, wsbon;
wire clk_clock_gating;
//wire [7:0] wireg, wireb; 

assign wsrp = Ar_local - er;
assign wsgp = Ag - eg;
assign wsbp = Ab - eb;

//assign wsrn = er - Ar_local;
//assign wsgn = er - Ag_local;
//assign wsbn = er - Ab_local;

and(clk_clock_gating,~en,clk);

p_9bit p1(wsrp,clk,wsrop);
p_9bit p2(wsgp,clk,wsgop);
p_9bit p3(wsbp,clk,wsbop);

//p_9bit p4(wsrn,clk,wsron);
//p_9bit p5(wsgn,clk,wsgon);
//p_9bit p6(wsbn,clk,wsbon);


//assign wsroxt = wsro*t_inv;

//assign wireg = en?wsrop:wsgop;
//assign wireb = en?wsrop:wsbop;

assign Ag = en?Ar_local:Ag_local;
assign Ab = en?Ar_local:Ab_local;

always @(*)
begin
  O_R = Ar_local - ((wsrop*t_inv)>>3);
  O_G = Ag - ((wsgop*t_inv)>>3);
  O_B = Ab - ((wsbop*t_inv)>>3);

end

endmodule
 
