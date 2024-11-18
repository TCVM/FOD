program ejer8;
const pepeLaConstante= 9999;
type
	distro=record
		nombre,des:string;
		año,version,devs:integer;
	end;
	archivo=file of distro;

procedure leer(var arc:archivo;var reg:distro);
		begin
			if(not eof(arc))then
				read(arc,reg)
			else
				reg.nombre:=pepeLaConstante;
		end;
	
procedure existeDistribucion(var arc:archivo;nombre:string;var existe:boolean);
	var
		reg:distro;
	begin
		reset(arc);
		leer(arc,reg);
		while((reg.cant<>pepeLaConstante)and(reg.nombre<>nombre)) do leer(arc,reg);
		if(reg.nombre==nombre)then
			existe:=true
		else
			existe:=false;
		close(arc);
	end;
	
procedure leerReg(var reg:distro);
		begin
			writeln();readln(reg.nombre);
			writeln();readln(reg.des);
			writeln();readln(reg.año);
			writeln();readln(reg.devs);
			writeln();readln(reg.version);
		end;

procedure altaDistribucion(var arc:archivo);
	var
		reg,aux:distro;
	begin
		leerReg(aux);
		leer(arc,reg);
		while((not eof(arc))and(reg.nombre==aux.nombre))do leer(arc,reg);
		if(reg.nombre<>aux.nombre)then begin
			seek(arc,0);
			leer(arc,reg)
			if(reg.cant<>0)then begin
				seek(arc,abs(reg.cant));
				write(arc,aux);
			end
			else
				writeln('no hay espacio');
		end
		else
			writeln('ya existe el registro');
	end;
	
procedure bajaDistribucion(var arc:archivo);
	var
		reg,aux:distro;
		nombre:string;
		existe:boolean;
	begin
		writeln();readln(nombre);
		existeDistribucion(arc,nombre,existe);
		if(existe)then begin
			reset(arc);
			leer(arc,reg);//cabecera
			leer(arc,aux);
			while(aux.nombre<>nombre)do begin
				leer(arc,aux);
			end;
			seek(arc,filePos(arc)-1);
			write(arc,reg);
			aux.cant=filePos(arc)*-1;
			seek(arc,0);
			write(arc,aux);
			close(arc);//esta bien asi o es preferible modificar unicamente el indice cant?
		end;
	end;
	
procedure crear(var arc:archivo);
	var
		reg:distro;
	begin
		reset(arc);
		leer(arc,reg);
		reg.cant:=0;
		seek(arc,filepos(arc)-1);
		write(arc,reg);
		close(arc);
	end;
var 
	nombre:string;
	existe:boolean;
	arc:archivo;
BEGIN
	assign(arc,'ejer8archivo');
	crear(arc);
	existeDistribucion(arc,nombre,existe);
	altaDistribucion(arc);
	bajaDistribucion(arc);
END.

