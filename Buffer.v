module Buffer(
    input  wire[31:0] input_A,
    input  wire[31:0] input_B,
    input  wire[31:0] input_C,
    input  wire clock,
    output reg [31:0] output_A,
    output reg [31:0] output_B,
    output reg [31:0] output_C
);

always@(posedge clock)
    begin
    // Registro pipeline
    output_A = input_A;
    output_B = input_B;
    output_C = input_C;
end
endmodule
