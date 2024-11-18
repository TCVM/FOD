program ejer2;
const pepeLaConstante=9999;
type
	asistente=record
		nro,tel,dni,email:integer;
		AyN:string;
	end;

	archivo=file of asistente;
	
procedure leerReg(var a:asistente);
	begin
		writeln();readln(a.nro);
		writeln();readln(a.tel);
		writeln();readln(a.dni);
		writeln();readln(a.email);
		writeln();readln(a.AyN);
	end;
	
procedure leer(var arch:archivo;var reg:asistente);
	begin
		if(not eof(arch))then
			read(arch,reg);
		else
			reg.nro:=pepeLaConstante;
	end;
	
procedure cargar(var arch:archivo);
	var
		reg:asistente;
	begin
		rewrite(arch);
		leerReg(reg);
		while(reg.nro<>pepeLaConstante)do begin
			write(arch,reg);
			leerReg(reg);
		end;
		close(arch);
	end;
	
procedure eliminar(var arch:archivo);
	var
		reg:asistente;
	begin
		reset(arch);
		leer(arch,reg);
		while(nro.nro<>pepeLaConstante)do begin
			if(reg.nro<1000)then
				reg.nro:='@eliminar';
				seek(arch,filepos(arch)-1);
				write(arch,reg);
			leer(arch,reg);
		end;
		close(arch);
	end;
var 
 arch:archivo;
BEGIN
	assign(arch,'ejer2Archivo');
	cargar(arch);
	eliminar(arch);
END.

