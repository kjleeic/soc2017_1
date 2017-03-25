module D05_uart_apb(A, B);
	input wire A;
	output reg B;
	
	always@ (*)
		B <= ~B;

endmodule
