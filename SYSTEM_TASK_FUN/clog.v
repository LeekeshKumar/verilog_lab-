module tb;
	real N;
	initial begin
		N=$clog2(1025);
		$display("N=%0.2f",N);
	end
endmodule
