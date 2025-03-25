`timescale 1ns/1ns

module JericallaEvo(
    input   [16:0] instruction,
    input    clock,
    output  [31:0] result_out
);

wire [31:0] w1;     
wire [7:0]  w2;     
wire [31:0] w3;     
wire [31:0] w4; 
wire [31:0] w5;     
wire [31:0] w6;     
wire [31:0] w7;     
wire [31:0] w8;     
wire [31:0] w9;     
wire [31:0] w10;    
wire [31:0] w11;    
wire [31:0] w12;    

RegisterBank      register_bank(.read_addr1(instruction[9:5]), .read_addr2(instruction[4:0]), .write_addr(instruction[14:10]), .reg_write(w2[0]), .data_in(w1), .data_out1(w3), .data_out2(w4));
memory_output     memory_unit(.address(w5), .write_en(w2[6]), .read_en(w2[7]), .write_data(w10), .read_data(result_out));
ALU alu_unit(.operand_A(w6), .operand_B(w7), .operation(w2[4:1]), .result(w8));
demux             demux_unit(.entrada_demux(w11), .demux_sel(w2[5]), .salida_demux_1(w6), .salida_demux_2(w9));
PipelineRegister  pipe_reg1(.input1(w3), .input2(w4), .input3(w12), .clock(clock), .output1(w11), .output2(w7), .output3(w12));
PipelineRegister  pipe_reg2(.input1(w9), .input2(w8), .input3(w7), .clock(clock), .output1(w5), .output2(w1), .output3(w10));
control           control_unit(.opcode(instruction[16:15]), .salida_control(w2));
endmodule

module JericallaEvo_TB();

reg   [16:0] instruction;
reg   clock;
wire  [31:0] result_out;

JericallaEvo dut(.instruction(instruction), .clock(clock), .result_out(result_out));

// Testbench
always #25 clock=~clock;
initial
    begin
        clock=0;
        $readmemb("datos.txt", dut.register_bank.registers);
        instruction = 17'b00_00100_00000_00001;    // Suma aritmética
        #100;
        instruction = 17'b01_00101_00001_00010;    // Resta aritmética
        #100;
        instruction = 17'b10_00110_00010_00011;    // Operación ternaria
        #100;
        $stop;
    end
endmodule
