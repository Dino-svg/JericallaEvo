`timescale 1ns/1ns

module JericallaEvo(
    input   [16:0] instruction,
    input    clock,
    output  [31:0] output_data
);

// Conexiones entre módulos
wire [31:0] write_data;      // Dato escritura RegisterFile y salida_B PipelineReg2
wire [7:0]  control_signals; // Señales de control
wire [31:0] read_data1;      // Dato lectura 1 RegisterFile
wire [31:0] read_data2;      // Dato lectura 2 RegisterFile
wire [31:0] mem_address;     // Dirección memoria
wire [31:0] alu_operandA;    // Operando A ALU
wire [31:0] alu_operandB;    // Operando B ALU
wire [31:0] alu_result;      // Resultado ALU
wire [31:0] demux_out1;      // Salida demux
wire [31:0] mem_write_data;  // Dato escritura memoria
wire [31:0] pipe1_outA;      // Salida A PipelineReg1
wire [31:0] pipe1_outC;      // Salida C PipelineReg1 (feedback)

// Instancias
RegisterFile     reg_file(.read_addr1(instruction[9:5]), .read_addr2(instruction[4:0]), 
                         .write_addr(instruction[14:10]), .write_enable(control_signals[0]), 
                         .data_in(write_data), .data_out1(read_data1), .data_out2(read_data2));
MemoryUnit       memory(.address(mem_address), .write_enable(control_signals[6]), 
                       .read_enable(control_signals[7]), .data_in(mem_write_data), 
                       .data_out(output_data));
ALU   alu(.operand_A(alu_operandA), .operand_B(alu_operandB), 
                     .operation(control_signals[4:1]), .result(alu_result));
demux            demux(.entrada_demux(pipe1_outA), .demux_sel(control_signals[5]), 
                       .salida_demux_1(alu_operandA), .salida_demux_2(demux_out1));
Buffer pipe_reg1(.input_A(read_data1), .input_B(read_data2), .input_C(pipe1_outC), 
                           .clock(clock), .output_A(pipe1_outA), .output_B(alu_operandB), 
                           .output_C(pipe1_outC));
PipelineRegister pipe_reg2(.input_A(demux_out1), .input_B(alu_result), .input_C(alu_operandB), 
                           .clock(clock), .output_A(mem_address), .output_B(write_data), 
                           .output_C(mem_write_data));
control          control_unit(.opcode(instruction[16:15]), .salida_control(control_signals));
endmodule

module JericallaEvo_TB();

reg   [16:0] instruction;
reg   clock;
wire  [31:0] output_data;

JericallaEvo dut(.instruction(instruction), .clock(clock), .output_data(output_data));

// Testbench
always #25 clk=~clk;
initial
    begin
        clock=0;
        $readmemb("datos.txt", dut.reg_file.registers);
        instruction = 17'b00_00100_00000_00001;    // Suma aritmética
        #100;
        instruction = 17'b01_00101_00001_00010;    // Resta aritmética
        #100;
        instruction = 17'b10_00110_00010_00011;    // Operación ternaria
        #100;
        instruction = 17'b11_00000_00111_00100;    // SW
        #100;
        instruction = 17'b11_00000_01000_00101;    // SW
        #100;
        instruction = 17'b11_00000_01001_00110;    // SW
        #100;
        $stop;
    end
endmodule
