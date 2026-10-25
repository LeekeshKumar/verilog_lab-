module comp_1bit(a,b,gt,lt,eq);
	input a;
	input b;
	output reg gt;
	output reg lt;
	output reg eq;
	always@(*)begin
		gt=0;
		lt=0;
		eq=0;
		if(a>b)gt=1;
		else if(a==b)eq=1;
		else lt=1;
	end
endmodule

module comp_nbit(a,b,gt,lt,eq);
	parameter N=4;
	input [N-1:0]a,b;
	output gt,lt,eq;
	wire[N-1:0] gt_w,lt_w,eq_w;
	wire[N:0] gt_chain,lt_chain,eq_chain;
	genvar i;
	generate
		for(i=0;i<N;i=i+1)begin
			comp_1bit uut(a[i],b[i],gt_w[i],lt_w[i],eq_w[i]);
		end
	endgenerate
	assign gt_chain[N]=1'b0;
	assign lt_chain[N]=1'b0;
	assign eq_chain[N]=1'b1;
	generate
		for(i=N-1;i>=0;i=i-1)begin
			assign gt_chain[i]=gt_chain[i+1] | (eq_chain[i+1]&gt_w[i])	;
			assign lt_chain[i]=lt_chain[i+1] | (eq_chain[i+1]&lt_w[i])	;
			assign eq_chain[i]=eq_chain[i+1]&eq_w[i];
		end
	endgenerate
	assign	gt=gt_chain[0];
	assign 	lt=lt_chain[0];
	assign 	eq=eq_chain[0];
endmodule

module tb;
	parameter N=20;
	reg [N-1:0]a,b;
	wire gt,lt,eq;
	comp_nbit #(.N(N)) dut(a,b,gt,lt,eq);
	initial begin
		repeat(5)begin
			{a,b}={$random,$random};
			#1;
			$display("a=%b b=%b | gt=%b, lt=%b, eq=%b",a,b,gt,lt,eq);
		end
	end
endmodule
//		gt_w[2] = gt_w[3] | (eq_w[3]&gt_w[2]);
