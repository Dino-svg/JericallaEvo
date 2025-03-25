module control(
	input  wire[1:0]  opcode,
	output reg [7:0]  salida_control
);

always@(*)
	begin
		case(opcode)
			2'b00: salida_control = 8'b1_0_0_0010_0;		//Suma aritmética.
			2'b01: salida_control = 8'b1_0_0_0110_0;		//Resta aritmética
			2'b10: salida_control = 8'b1_0_0_0111_0;		//Operación ternaria
			2'b11: salida_control = 8'b0_1_1_0000_1;		
		endcase
	end
endmodule


