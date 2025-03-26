module control(
    input  wire[1:0]  opcode,
    output reg [7:0]  control_signals
);
	
always@(*)
    begin
        case(opcode)
            2'b00: control_signals = 8'b1_0_0_0010_1; // Suma
            2'b01: control_signals = 8'b1_0_0_0110_1; // Resta
            2'b10: control_signals = 8'b1_0_0_0111_1; // Comparación
            2'b11: control_signals = 8'b0_1_1_0000_0; // Store Word
        endcase
    end
endmodule


