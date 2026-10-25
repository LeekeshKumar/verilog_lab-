`timescale 1ns/1ns     // 1000 parts
module tb;
	reg clk;
	initial begin
		clk=0;
		repeat(5)begin
			#5 clk= !clk;  //freq = 100MHz
		end
	end
endmodule
