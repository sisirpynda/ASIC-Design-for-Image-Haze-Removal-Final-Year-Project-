module global_atmospheric_light_calculation(min_all, rmin, gmin, bmin, Ar_global, Ag_global, Ab_global);

input [7:0] min_all, rmin, gmin, bmin;
output reg [7:0] Ar_global, Ag_global, Ab_global;
reg [7:0] maxt;

always @(*)
	begin
		if(maxt > min_all)
			begin
				maxt = maxt;
				Ar_global = Ar_global;
				Ag_global = Ag_global;
				Ab_global = Ab_global;
			end
		else
			begin
				maxt = min_all;
				Ar_global = rmin;
				Ag_global = gmin;
				Ab_global = bmin;
			end 
	//(maxt>min_all)? maxt = maxt; Ar_global = Ar_global; Ag_global = Ag_global; Ab_global = Ab_global;: maxt = min_all; Ar_global = rmin; Ag_global = gmin; Ab_global = bmin;


	end
	

endmodule
