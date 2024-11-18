program ejer5;
const pepeLaConstante=9999;
type
	reg_flor=record
		nombre:string[45];
		codigo:integer;
	end;
	tarchflores= file of reg_flor;
	
procedure leerReg(var reg:reg_flor);
		begin
			writeln();readln(reg.nombre);
			writeln();readln(reg.codigo);
		end;

procedure leer(var arch:tarchflores;var reg:reg_flor);
	begin
		if(not eof(arch))then
			read(arch,reg);
		else	
			reg.codigo:=pepeLaConstante;
	end;

procedure eliminar(var arch:tarchflores;codigo:integer);
	var
		aux,reg:reg_flor;
		ok:boolean;
	begin
		reset(arch);
		ok:=false;
		leer(arch,aux);//cabecera
		leer(arch,reg);
		while((reg.codigo<>pepeLaConstante)and not(ok))do 
			if(reg.codigo=codigo)then begin
				ok:=true;
				reg.codigo:=aux.codigo;
				seek(arch,filepos(arch)-1);
				reg.codigo=filepos(arch)*-1;
				write(arch,aux);
				seek(arch,0);
				write(arch,reg);
			else
				leer(arch,reg);
		close(arch);
	end;

procedure alta(var arch:tarchflores;flor:reg_flor);
	var
		reg,n:reg_flor;
	begin
		reset(arch);
		leer(arch,reg);
		if(reg.codigo>0)then begin
			seek(arch,abs(reg.codigo));
			read(arch,n);
			seek(arch,filepos(arch)-1);
			leerReg(reg);
			write(arch,reg);
			seek(arch,0);
			write(arch,n);
		end
		else 
			writeln('no espacio');	
		close(arch);
	end;

procedure listar(var arch:tarchflores);
	procedure imprimir(reg:reg_flor);
	begin
		writeln(reg.nombre);
		writeln(reg.codigo);
	end;

	var
		reg:reg_flor;
	begin
		reset(arch);
		read(arch,1);
		while(not eof(arch))do begin
			if(reg.codigo>=1)then
				imprimir(reg);
				read(arch,reg);
		end;
		close(arch);
	end;
	
procedure crear(var arch:tarchflores);
	var
		reg:reg_flor;
	begin
		rewrite(arch);
		reg.codigo:=0;
		write(arch,reg);
		close(arch);
	end;
var 
	arch:tarchflores;
BEGIN
	assign(arch,'ejer4archivo');
	crear(arch);
	alta(arch);
	listar(arch);
END.

