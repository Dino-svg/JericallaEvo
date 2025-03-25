module memory_output(
    input  wire[31:0] address,
    input  wire write_en,
    input  wire read_en,
    input  wire[31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] memory[0:31];

always@(*)
    begin
    // Escritura
    if(write_en && !read_en) 
    begin
        memory[address] = write_data;
    end
    
    // Lectura
    if(read_en && !write_en) 
    begin
        read_data = memory[address];
    end
end
endmodule
