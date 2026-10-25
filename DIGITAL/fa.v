module fa (a,b,c,sum,carry);
	input a,b,c;
	output sum,carry;
	xor g1 (sum,a,b,c);
	and g2 (w1,a,b);
	and g3 (w2,b,c);
	and g4 (w3,c,a);
	or g5 (carry,w1,w2,w3);
endmodule
