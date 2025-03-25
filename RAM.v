`timescale 1ns/1ns

module RAM (
	input En,
	input [3:0] dirR,
	input [31:0] dataIn,
	output reg [31:0] DS
);

reg [31:0]memRam[0:15];

endmodule
