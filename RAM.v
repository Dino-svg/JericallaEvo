module MemoryUnit(
    
    input  wire[31:0] address,
    input  wire write_enable,
    input  wire read_enable,
    input  wire[31:0] data_in,
    output reg [31:0] data_out
);

reg [31:0] memory[0:31];

always@(*)
    begin
    
    if(write_enable && !read_enable) 
        
    begin
        memory[address] = data_in;
    end
    

    if(read_enable && !write_enable) 
        
    begin
        data_out = memory[address];
    end
        
end
    
endmodule
