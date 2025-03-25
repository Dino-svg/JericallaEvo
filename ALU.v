module ALU(
    input wire [31:0] operand_A,
    input wire [31:0] operand_B,
    input wire [3:0] operation,
    output reg [31:0] result
);

always@(*) 
    begin
        case (operation)
            4'b0000: result = operand_A & operand_B;        // AND
            4'b0001: result = operand_A | operand_B;        // OR
            4'b0010: result = operand_A + operand_B;        // SUMA
            4'b0110: result = operand_A - operand_B;        // RESTA
            4'b0111: result = (operand_A < operand_B) ? 32'd1 : 32'd0; // Comparación
            4'b1100: result = ~(operand_A | operand_B);     // NOR
            default: result = 32'd0;                       // Default
        endcase
    end
endmodule
