module demux(
    
    input wire[31:0] input_data,
    input wire selector,
    output reg[31:0] output_ch0,
    output reg[31:0] output_ch1
);

always@(*) 
    begin
        if(!selector)
            
        begin
            output_ch0 = input_data;  
            output_ch1 = 32'bz;      
        end
        
        else
        begin
            output_ch1 = input_data;  
            output_ch0 = 32'bz;      
        end
        
    end
endmodule
