module PipelineRegister(
    input  wire[31:0] input1,
    input  wire[31:0] input2,
    input  wire[31:0] input3,
    input  wire clock,
    output reg [31:0] output1,
    output reg [31:0] output2,
    output reg [31:0] output3
);

always@(posedge clock)
    begin
    output1 = input1;
    output2 = input2;
    output3 = input3;
end
endmodule
