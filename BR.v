module RegisterBank(
    input  wire[4:0] read_addr1,
    input  wire[4:0] read_addr2,
    input  wire[4:0] write_addr,
    input  wire reg_write,
    input  wire[31:0] data_in,
    output reg [31:0] data_out1,
    output reg [31:0] data_out2
);

reg [31:0] registers[0:31];

always@(*)
    begin
    data_out1 = registers[read_addr1];
    data_out2 = registers[read_addr2];
    
    if(reg_write) 
    begin
        registers[write_addr] = data_in;
    end
    
end
endmodule
