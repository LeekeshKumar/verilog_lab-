module mux(i0,i1,i2,i3,s0,s1,y);
	input i0,i1,i2,i3;
	input s0,s1;
	output reg y;
	always @(i0 or i1 or i2 or i3 or s0 or s1)begin
		if(s0  && s1)y=i3;
		else if (~s0 && s1)y=i2;
		else if (s0 && ~s1)y=i1;
		else y=i0;
	end
endmodule

module tb;
	reg i0,i1,i2,i3;
	reg s0,s1;
	wire y;
	mux dut(i0,i1,i2,i3,s0,s1,y);
	initial begin
		repeat(10)begin
			{i0,i1,i2,i3,s0,s1}=$random;
			#1;	
			$display("i0=%b,i1=%b,i2=%b,i3=%b,s0=%b,s1=%b | y=%b",i0,i1,i2,i3,s0,s1,y);
		end
	end
endmodule
// i0=1,i1=0,i2=0,i3=1,s0=0,s1=0 | y=1
// i0=0,i1=0,i2=0,i3=0,s0=0,s1=1 | y=0
// i0=0,i1=0,i2=1,i3=0,s0=0,s1=1 | y=1
// i0=1,i1=0,i2=0,i3=0,s0=1,s1=1 | y=0
// i0=0,i1=0,i2=1,i3=1,s0=0,s1=1 | y=1
// i0=0,i1=0,i2=1,i3=1,s0=0,s1=1 | y=1
// i0=1,i1=0,i2=0,i3=1,s0=0,s1=1 | y=0
// i0=0,i1=1,i2=0,i3=0,s0=1,s1=0 | y=1
// i0=0,i1=0,i2=0,i3=0,s0=0,s1=1 | y=0
// i0=0,i1=0,i2=1,i3=1,s0=0,s1=1 | y=1












