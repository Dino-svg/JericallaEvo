module mem_out(
	input  wire[31:0]direccion,
	input  wire Wen,
	input  wire Ren,
	input  wire[31:0] datoEscritura,
	output reg [31:0] datoLectura
);

reg [31:0]memr_out[0:31];

always@(*)
	begin
	//Escritura
	if(Wen && !Ren) 
	begin
		memr_out[direccion] = datoEscritura;
	end
	
	//Lectura
	if(Ren && !Wen) 
	begin
		datoLectura = memr_out[direccion];
	end
end
endmodule
