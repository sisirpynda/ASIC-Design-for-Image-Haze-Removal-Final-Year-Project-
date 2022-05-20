//`include "register_bank.v"
//`include "p.v"
//`include "Transmission_Map_Estimation.v"
//`include "Dynamic_Atmosphere_Light_Estimation.v"
//`include "restoration.v"

module p_24_bit(d,clk,q);

input [23:0]d;
input clk;
output reg [23:0]q;

always @(posedge clk)
	q = d;

endmodule

module p_72bit(in,clk,out);
input [71:0]in;
input clk;
output reg [71:0]out;

always @(posedge clk)
	out = in;
endmodule

 
module top(mode, clk, load, RGB_window, w, Ar_global_prev, Ag_global_prev, Ab_global_prev, Ar_global, Ag_global, Ab_global, O_R, O_G, O_B,tx_invxhundred, ed_bit); //w here is omega

input clk, load, mode; // 1-low , 0-normal
input [215:0] RGB_window;
input [7:0] Ar_global_prev, Ag_global_prev, Ab_global_prev;
input [4:0] w;
output [7:0] Ar_global, Ag_global, Ab_global, O_R, O_G, O_B;
output ed_bit;

wire [71:0] R_window, G_window, B_window, R_window_o, G_window_o, B_window_o;
wire [23:0] a,b,c,d,e,f,g,h,i,e3,e4,e5,e6;
wire [11:0] tx_inv;// TME1 output
wire [7:0] mr, mg, mb, min_all, I_dark;//for TME1 output
wire [7:0] Ar_local, Ag_local, Ab_local;
output wire [11:0] tx_invxhundred;

//assign tx_invxhundred =(12'b0000_0000_0000-(tx_inv*'b1000)); // try dividing it by 10 or 100
assign tx_invxhundred = tx_inv;


register_bank  register_bank1(load,RGB_window, clk,R_window, G_window, B_window);

p_72bit p1_top_rwindow(R_window, clk, R_window_o);
p_72bit p2_top_gwindow(G_window, clk, G_window_o);
p_72bit p3_top_bwindow(B_window, clk, B_window_o);

Transmission_Map_Estimation tme (mode ,a,b,c,d,e,f,g,h,i,Ar_local,Ag_local,Ab_local,clk,tx_inv, mr,mg,mb,I_dark,min_all,w,ed_bit); 
//Ac_local will come from DALE
// instantiate DALE

Dynamic_Atmosphere_Light_Estimation dale(mode, min_all,mr,mg,mb,Ar_global_prev, Ag_global_prev, Ab_global_prev, I_dark, clk, Ar_global, Ag_global, Ab_global, Ar_local, Ag_local, Ab_local);

//assign tx_invxhundred = tx_inv;

restoration Scene_Recovery(mode ,tx_invxhundred, clk,e6[23:16], e6[15:8], e6[7:0], Ar_local, Ag_local, Ab_local, O_R, O_G, O_B);

assign a = {R_window_o[71:64], G_window_o[71:64], B_window_o[71:64]};
assign b = {R_window_o[63:56], G_window_o[63:56], B_window_o[63:56]};
assign c = {R_window_o[55:48], G_window_o[55:48], B_window_o[55:48]};
assign d = {R_window_o[47:40], G_window_o[47:40], B_window_o[47:40]};
assign e = {R_window_o[39:32], G_window_o[39:32], B_window_o[39:32]};//e2
assign f = {R_window_o[31:24], G_window_o[31:24], B_window_o[31:24]};
assign g = {R_window_o[23:16], G_window_o[23:16], B_window_o[23:16]};
assign h = {R_window_o[15:8], G_window_o[15:8], B_window_o[15:8]};
assign i = {R_window_o[7:0], G_window_o[7:0], B_window_o[7:0]};

p_24_bit e23(e,clk,e3);
p_24_bit e34(e3,clk,e4);
p_24_bit e45(e4,clk,e5);
p_24_bit e56(e5,clk,e6);


endmodule












//tesebench 

module test_top;

reg clk,load, mode;
reg [215:0] RGB_window;
reg [4:0] w;
wire [7:0] Ar_fb, Ag_fb, Ab_fb;
wire [7:0] O_R, O_G, O_B; 
reg [215:0] mem[252953:0];
wire [11:0] tinv;
wire edb;
integer i,fid1;
//integer fid2;

top dut(mode, clk, load, RGB_window, w, Ar_fb, Ag_fb, Ab_fb, Ar_fb, Ag_fb, Ab_fb, O_R, O_G, O_B,tinv,edb);


initial begin 
fid1 = $fopen("mode_0_dehazed_image.txt","w");
//fid2 = $fopen("Dehazed_image_tmap_review.txt","w");
end


initial 
	begin
		$readmemb("itg2_result_full_image_binarized_final.txt",mem);
		w = 5'b10111;
		mode = 1'b0;
		load = 1'b0 ;
		clk = 1'b0;
		i = 0;
	end


always begin
	#20 clk = ~clk;
	    load = ~load;
end

always
begin
		#40 RGB_window = mem[i];
	i = i+1;

	if (i == 252954)
		begin
			$fclose(fid1);
//			$fclose(fid2);
			#300 $finish;
		end

		$fwrite(fid1,"%b%b%b\n",O_R,O_G,O_B);
//		$fwrite(fid2,"%b\n",tinv);

end

endmodule

