

module lut_alpha_calculation(dark_diff,denom,alpha);

input [7:0] dark_diff, denom;
output reg [11:0] alpha;
reg [15:0] temp;
integer i;

always @(dark_diff, denom)
	begin
		temp = dark_diff<<1;
		for(i=11;i>=1;i=i-1)
			begin
				alpha[i] = temp>=denom;
				temp = (temp>=denom)?((temp-denom)<<1):(temp<<1);	
			end 
		alpha[0] = temp>denom;
	end

endmodule


module lut_generator;

reg [7:0] dd,dn;
wire [11:0] al;
integer i = 1;
integer fid;
lut_alpha_calculation alc1(dd,dn,al);

initial 
begin
	dd = 8'd1;
	dn = 8'd1;
	//fid = $fopen("itg2_result_full_image_binarized_final.txt ","r");	
	for (i = 1; i<255; i =i+1)
		begin
		#20	$fwrite(fid,"8'b%b : inverse = 12'b%b;\n",dn,al);
			dn = dn + 8'd1;
		end	
end

endmodule 
