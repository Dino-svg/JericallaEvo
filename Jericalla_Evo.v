`timescale 1ns/1ns

module JericallaEvo(
    
    input   [16:0] instruction,
    input    clock,
    output  [31:0] output_data
);


wire [31:0] write_data;      
wire [7:0]  control_signals; 
wire [31:0] read_data1;      
wire [31:0] read_data2;      
wire [31:0] mem_address;     
wire [31:0] alu_operandA;    
wire [31:0] alu_operandB;   
wire [31:0] alu_result;      
wire [31:0] demux_out1;      
wire [31:0] mem_write_data;  
wire [31:0] pipe1_outA;      
wire [31:0] pipe1_outC;     


RegisterFile     register_bank(
    
    .read_addr1(instruction[9:5]),
    .read_addr2(instruction[4:0]),
    .write_addr(instruction[14:10]),
    .write_enable(control_signals[0]),
    .data_in(reg_write_data),
    .data_out1(reg_read_data1),
    .data_out2(reg_read_data2)
);

MemoryUnit       memory_module(
    
    .address(mem_address),
    .write_enable(control_signals[6]),
    .read_enable(control_signals[7]),
    .data_in(mem_write_data),
    .data_out(result_out)
);

ALU   alu_module(
    
    .operand_A(alu_operandA),
    .operand_B(alu_operandB),
    .operation(control_signals[4:1]),
    .result(alu_result)
);

demux        demux_module(
    
    .input_data(demux_input),
    .selector(control_signals[5]),
    .output_ch0(alu_operandA),
    .output_ch1(demux_output2)
);

Buffer pipe_stage1(
    
    .input_A(reg_read_data1),
    .input_B(reg_read_data2),
    .input_C(pipe_feedback),
    .clock(clock),
    .output_A(demux_input),
    .output_B(alu_operandB),
    .output_C(pipe_feedback)
);

Buffer pipe_stage2(
    
    .input_A(demux_output2),
    .input_B(alu_result),
    .input_C(alu_operandB),
    .clock(clock),
    .output_A(mem_address),
    .output_B(reg_write_data),
    .output_C(mem_write_data)
);

control      control_module(
    
    .opcode(instruction[16:15]),
    .control_signals(control_signals)
);
endmodule

module JericallaEvo_TB();

reg   [16:0] instruction;
reg   clock;
wire  [31:0] output_data;

JericallaEvo dut(.instruction(instruction), .clock(clock), .output_data(output_data));


always #25 clock=~clock;
initial
    begin
        clock=0;
        $readmemb("datos.txt", dut.reg_file.registers);
        instruction = 17'b00_00100_00000_00001;    
        #100;
        instruction = 17'b01_00101_00001_00010;    
        #100;
        instruction = 17'b10_00110_00010_00011;    
        #100;
        instruction = 17'b11_00000_00111_00100;    
        #100;
        instruction = 17'b11_00000_01000_00101;   
        #100;
        instruction = 17'b11_00000_01001_00110;    
        #100;
        $stop;
    end
    
endmodule
