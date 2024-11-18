program ejer1;

const
	PATH = '/home/thecague/Facultad/FOD/Practicas/';

type
	archivo= file of integer;
	
var 
	corte:integer;
	nombre:String;
	arch:archivo;
BEGIN
	writeln('Ingrese nombre del archivo');
	readln(nombre);
	
	WriteLn(PATH + nombre);
	
	assign(arch, PATH + nombre);
	rewrite(arch);
	writeln('Ingrese valor');
	readln(corte);
	while(corte <> 30000)do begin
		write(arch,corte);
		
		writeln('Ingrese valor');
		readln(corte);
	end;
	close(arch);
END.
