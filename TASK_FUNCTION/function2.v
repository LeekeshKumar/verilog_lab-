//Implement 5 bit full adder using function
//	1. sum   -> function
//	2. carry
module tb;
	reg [4:0]a,b;
	reg cin;
	reg [4:0]sum;
	reg carry;
	integer i;
	function reg[4:0] sum_t(input reg[4:0]f_a,f_b,input reg f_cin);
		sum_t=f_a^f_b^f_cin;
	endfunction
	function reg carry_t(input reg[4:0]f_a,f_b,input reg f_cin);
		reg [5:0]co_t;
		begin
			co_t[0]=f_cin;
			for(i=0;i<6;i=i+1)begin
				$display("i=%0d, co_t[%0d]=%0d",i,i,co_t[0]);
				if(i==0)begin
					co_t[i+1]=f_a[i]&f_b[i] | f_b[i]&co_t[i] | co_t[i]&f_a[i];
					$display("i==0 i=%0d, co_t[1]=%0d",i,co_t[1]);
				end
				else begin
					co_t[i+1]=f_a[i]&f_b[i] | f_b[i]&co_t[i] | co_t[i]&f_a[i];
					$display("i>0 i=%0d, co_t[%0d]=%0d",i,i+1,co_t[i+1]);
				end
			end
			carry_t=co_t[5];
		end
	endfunction
	initial begin
		repeat(1)begin
			{a,b,cin}=$random;
			#1;
			sum=sum_t(a,b,cin);
			carry=carry_t(a,b,cin);
			$display("a=%b b=%b cin=%b | sum=%b carry=%b",a,b,cin,sum,carry);
		end
	end
endmodule





