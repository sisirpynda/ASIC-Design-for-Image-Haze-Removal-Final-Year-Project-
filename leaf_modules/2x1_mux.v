module mux( in0, in1, select, out );

input select;
input [7:0] in0, in1;
output reg [7:0] out;

always @(*)
	out = (select)?in1:in0;

endmodule

// testbench

module test_mux;
      reg sel;
      reg [7:0] i0, i1;
      wire [7:0] o;
  
      initial
	begin
           i0 = 8'b11110000;
           i1 = 8'b10101010;
	   sel = 1'b0;
	   #20
	   sel = 1'b1;
	   #100  $finish;
       end

      mux test_2x1_mux(i0,i1,sel,o);

      initial
       $monitor("time = %1t, sel = %b, in0 = %b, in1 = %b, out = %b", $time, sel, i0, i1, o);
endmodule

