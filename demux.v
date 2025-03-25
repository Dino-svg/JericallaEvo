module demux(
    input wire[31:0]entrada_demux,
    input wire demux_sel,
    output reg[31:0]salida_demux_1,
    output reg[31:0]salida_demux_2
);

always@(*) 
	begin
		if(!(demux_sel))
		begin
			salida_demux_1 = entrada_demux;  // La salida 0 toma el valor de la entrada.
		end
		
		else
		begin
			salida_demux_2 = entrada_demux;  // La salida 1 toma el valor de la entrada.
		end
	end
endmodule