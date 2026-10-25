module mux2x1(i,s,y);
	input  [31:0]i[1:0];
	input s;
	output reg [31:0]y;
	always@(*)begin
		y=s?i[1]:i[0];
	end
endmodule

module mux3x1(i,s,y);
	input [31:0]i[2:0];
	input [1:0]s;
	output reg [31:0]y;
	always@(*)begin
		y=(s==2'b00)?i[0]:(s==2'b01)?i[1]:(s==2'b10)?i[2]:32'bz;
	end
endmodule

module sum(a,b,sum);
	input [31:0]a,b;
	output reg [31:0]sum;
	always@(*)begin
		sum=a+b;
	end
endmodule
module sub(a,b,diff);
	input [31:0]a,b;
	output reg [31:0]diff;
	always@(*)begin
		diff=a-b;
	end
endmodule
module prod(a,b,mul);
	input [31:0]a,b;
	output reg [31:0]mul;
	always @(*)begin
		mul=a*b;
	end
endmodule
module ALU (A,B,F,R);
	input [31:0]A,B;
	input [2:0]F;
	output [31:0]R;
	wire [31:0]c=32'd1;
	wire [31:0]y1,y2,y3,y4,y5;

	mux2x1 uut1 (.i({c,B}),.s(F[0]),.y(y1));
	mux2x1 uut12 (.i({c,B}),.s(F[0]),.y(y2));
	sum    uut3 (.a(A),.b(y1),.sum(y3));
	sub    uut4 (.a(A),.b(y2),.diff(y4));
	prod   uut5 (.a(A),.b(B),.mul(y5));
	mux3x1 uut2 (.i({y5,y4,y3}),.s(F[2:1]),.y(R));
endmodule




