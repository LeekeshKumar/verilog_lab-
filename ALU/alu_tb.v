`include "alu.v"
module tb;
	reg [31:0]A,B;
	reg [2:0]F;
	wire[31:0]R;
	
	ALU dut (A,B,F,R);
	initial begin
		A=0;
		B=0;
		F=0;
		repeat(5)begin
			A=$urandom_range(10,20);
			B=$urandom_range(1,9);
			F=$random;
			#1;
			$display("A=%0d B=%0d c=%0d F[2:1]=%b f[0]=%b | R=%0d",A,B,dut.c,F[2:1],F[0],R);
		end	
	end
endmodule

//# A=17 B=2 F=100 | R=34
//# A=18 B=9 F=001 | R=19
//# A=15 B=2 F=001 | R=16
//# A=13 B=8 F=011 | R=12
//# A=16 B=2 F=101 | R=32




