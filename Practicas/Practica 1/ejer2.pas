program ejer2;
const max=1500;
type
	archivo=file of integer;
var 
	num,cant,cont:integer;
	nombre:string;
	prom:real;
	arch:archivo;
BEGIN
	cant:=0;prom:=0;cont:=0;
	writeln('ingrese nombre de archivo');
	readln(nombre);
	assign(arch,nombre);
	reset(arch);
	while(not eof(arch))do begin 
		read(arch,num);
		if(num<max)then begin 
			writeln(num);
			cant:=cant+1;
		end;
		prom:=prom + num;
		cont:=cont + 1;
	end;
	close(arch);
	writeln(cont/prom);
END.

