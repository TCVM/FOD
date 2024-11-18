program ejer7;
const pepeLaConstante=9999;
type
	especie=record
		cod:integer;
		fam,des,geo:string;
	end;
	archivo=file of especie;

procedure leer(var arc:archivo;var reg:especie);
	begin
		if(not eof(arc))then
			read(arc,reg)
		else
			reg.cod:=pepeLaConstante;
	end;

procedure marcarParaEliminacion(var arc:archivo);
	var
		reg:especie;
		codigo:integer;
	begin
		reset(arc);
		leer(arc,reg);
		codigo:=0;
		writeln('Ingrese codigo');readln(codigo);
		while(codigo<>50000)do begin
			while((reg.cod<>pepeLaConstante)and(reg.cod<>codigo))do begin	
					leer(arc,reg);
			end;
			if(reg.cod<>pepeLaConstante)then begin
				reg.cod*=-1;
				seek(arc,filepos(arc)-1);
				write(arc,reg);
			end
			else
				writeln('Elemento no encontrado');
			seek(arc,0); 
			writeln('Ingrese codigo');readln(codigo);
		end;
		close(arc);
	end;
	
procedure eliminar(var arc:archivo);
	var
		reg,aux:especie;
	begin
		reset(arc);
		seek(arc,fileSize(arc)-1);
		leer(arc,reg);//registro reservado para eliminacion
		seek(arc,0);
		leer(arc,aux);//buscador
		while(aux.cod<>pepeLaConstante)do begin
			if(reg.cod<0)then begin
				seek(arc,filepos(arc)-1);
				write(arc,reg);
				truncate(arc,fileSize(arc)-1);
				seek(arc,fileSize(arc)-1);
				leer(arc,reg);
				seek(arc,0);
			end;
			leer(arc,aux);
		end;
		close(arc);
	end;
{	
procedure realizarBaja(var emp:empleado;num:integer);
	var
		reg:empleado;
		pos:integer;
	begin
		reset(emp);
		read(emp,reg)
		while(not eof(emp)and(reg.num<>num))do 
			read(emp,reg);
		if(not eof(emp))then begin
			seek(emp,filepos(emp)-1);
			pos:=filepos(emp);
			while(not eof(emp))do read(emp,reg);
			truncate(emp,filepos(emp)-1);
			seek(emp,pos);
			write(emp,reg);
		end
		else
			writeln('empleado no encontrado');
	end;
}

var 
	arc:archivo;
BEGIN
	assign(arc,'ejer7archivo');
	crear(arc);
	marcarParaEliminacion(arc);
	eliminar(arc);
END.

