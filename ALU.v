module ALU(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [3:0] ALU_Sel,
    output reg [31:0] R
);

always@(*) 
	begin
		case (ALU_Sel)
			4'b0000: R = A & B;        				// AND
			4'b0001: R = A | B;        				// OR
			4'b0010: R = A + B;       				// SUMA
			4'b0110: R = A - B;        				// RESTA
			4'b0111: R = (A < B) ? 32'd1 : 32'd0; 	// Ternario A < B	
			4'b1100: R = ~(A | B);     				// NOR
			default: R = 32'd0;       				// Por defecto, resultado en 0
		endcase
	end
endmodule
