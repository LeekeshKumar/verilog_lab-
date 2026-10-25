module tb;
	reg a,b,c;
	wire sum,carry;
	fa dut (a,b,c,sum,carry);
	initial begin
		repeat(20)begin
			{a,b,c}=$random;
			#1 $display("a=%b,b=%b,c=%b,sum=%b,carry=%b",a,b,c,sum,carry);
		end	
	end
endmodule
