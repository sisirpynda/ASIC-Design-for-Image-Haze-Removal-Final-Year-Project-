module register_bank (load, w, clk, R_window, G_window, B_window); // w here is window

input  [215:0] w;
input load,clk;
//output reg [23:0] out;
output reg [71:0] R_window, G_window, B_window;

reg [23:0] window [8:0];
//reg [3:0]count;

always @(posedge clk)
	begin
		if(load)
		begin
			R_window = {w[215:208],w[191:184],w[167:160],w[143:136],w[119:112],w[95:88],w[71:64],w[47:40],w[23:16]}; //a,b,c,d,e,f,g,h,i
			G_window = {w[207:200],w[183:176],w[159:152],w[135:128],w[111:104],w[87:80],w[63:56],w[39:32],w[15:8]}; //a,b,c,d,e,f,g,h,i
			B_window = {w[199:192],w[175:168],w[151:144],w[127:120],w[103:96],w[79:72],w[55:48],w[31:24],w[7:0]};  //a,b,c,d,e,f,g,h,i
		end

		else 
		begin
			R_window = R_window;
			G_window = G_window;
			B_window = B_window;
		end

	end
/*
always @(posedge load)
	begin
		window[0] = w[23:0]   ; //a 
		window[1] = w[47:24]  ; //b
		window[2] = w[71:48]  ; //cc
		window[3] = w[95:72]  ; //d
		window[4] = w[119:96] ; //e
		window[5] = w[143:120] ; //f
		window[6] = w[167:144] ; //g
		window[7] = w[191:168] ; //h
		window[8] = w[215:192] ; //i
		count = 'd0;
	end

always @(posedge clk)
	begin
		if (count > 9)
			count = 'd0;
		
		else
			begin
				out = window[count];
				count = count + 'd1;
			end
	end*/
	
endmodule

//testbench


module test_register_bank;

reg ld, cc;
reg [215:0]ww;
wire [71:0]rw,gw,bw;

register_bank test_register_bank(ld,ww,rw,gw,bw);

initial
	begin
		cc = 1'b0;	
		ww = 216'hAAAAAA_BBBBBB_CCCCCC_DDDDDD_EEEEEE_FFFFFF_A0A0A0_A1A1A1_A2A2A2;
		ld = 0;
		#20
		ld = 1;
		#600 $finish;
	end

always #20 cc = ~cc;

initial 
	$monitor("time = %1t, load = %d, clock = %d, RW = %d, GW = %d, BW = %d, w=%h", $time,ld, cc, rw, gw, bw, ww);

endmodule

