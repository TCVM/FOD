program ejercicio1; 
type
	empleado=record
		num,edad,dni:integer;
		ape,nom:string;
	end;
	empleados=file of empleado;

procedure leer(var e:empleado);
	begin
			writeln('Ingrese apellido');readln(e.ape);
			writeln('Ingrese nombre');readln(e.nom);
			writeln('Ingrese dni');readln(e.dni);
			writeln('Ingrese numero');readln(e.num);
			writeln('Ingrese edad');readln(e.edad);
		end;

procedure listar(e:empleado);
	begin
		writeln(e.ape);
		writeln(e.nom);
		writeln(e.dni);
		writeln(e.num);
		writeln(e.edad);
	end;

procedure buscarNombre(var emps:empleados);
	var
		e:empleado;
		aux:string;
	begin
		reset(emps);
		writeln('Ingrese nombre o apellido a buscar');readln(aux);
		while(not eof(emps))do begin
			read(emps,e);
			if((e.ape = aux)OR(e.nom=aux))then
				listar(e);
		end;
		close(emps);
	end;

procedure mayores70(var emps:empleados);
	var
		e:empleado;
	begin				
	reset(emps);
		while(Not eof(emps))do begin
			read(emps,e);
			if(e.edad>=70)then listar(e);
		end;
	close(emps);
	end;
	
procedure listarCompleto(var emps:empleados);
	var
		e:empleado;
	begin
		reset(emps);
		while(Not eof(emps))do begin
			read(emps,e);
			listar(e);
		end;
		close(emps);
	end;
		
procedure aniadirEmpleados(var emps:empleados);
	var
		e,empreg:empleado;
		aux:boolean;
		ok:char;
	begin
		reset(emps);
		aux:=true;
		leer(e);
		while(aux)do begin
			read(emps,empreg);
			while((Not eof(emps)) AND (e.num <> empreg.num))do begin
				read(emps,empreg);
			end;
			if(e.num <> empreg.num)then begin
				write(emps,e);
			end
			else writeln('Empleado ya existente'); 
			writeln('agregar otro s/n');readln(ok);
			if(ok = 's')then begin 
				leer(e);
				seek(emps,0);
			end
			else aux:=false;
		end;
		close(emps);
	end;
	
procedure modificarEmpleado(var emps:empleados);
	var
		e:empleado;
		edad:integer;
		num:integer;
		ok:boolean;
	begin
		reset(emps);
		ok:=true;
		writeln('Ingrese numero de empleado a modificar');readln(num);
		while((Not eof(emps)) and (ok))do begin
			read(emps,e);
			if(e.num = num)then begin
				writeln('ingrese edad');readln(edad);
				e.edad:=edad;
				ok:=false;
				seek(emps,filePos(emps)-1);
				write(emps,e);
			end;
		end;
		if(ok = true)then writeln('empleado no encontrado');
		close(emps);
	end;
procedure exportar(var emp:empleados);
	var
		at:Text;
		e:empleado;
	begin
		assign(at, 'todos_empleados.txt');
		rewrite(at);
		reset(emp);
		while(Not eof(emp))do begin
			read(emp,e);
			writeln(at,e.num,' ',e.dni,' ',e.edad,' ',e.nom,' ',e.ape);
		end; 
		close(at);
		close(emp);
	end;
	
procedure exportarSinDNI(var emp:empleados);
		var
		at:Text;
		e:empleado;
	begin
		assign(at, 'faltaDNIEmpleado.txt');
		rewrite(at);
		reset(emp);
		while(Not eof(emp))do begin
			read(emp,e);
			if(e.dni = 00)then writeln(at,e.num,' ',e.dni,' ',e.edad,' ',e.nom,' ',e.ape);
		end; 
		close(at);
		close(emp);
	end;
	
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
procedure menu(var emp:empleados);
	var
		opcion:integer;
		aux:boolean;
	begin
		aux:=true;
		while(aux) do begin
			writeln('Opiciones');
			writeln('1) Buscar Nombre/apellido');
			writeln('2) Listar Empleados');
			writeln('3) Listar Empleados mayores a 70');
			writeln('4) Añadir Empleados');
			writeln('5) Modificar Empleado');
			writeln('6) Exportar a Archivo de Texto');
			writeln('7) Exportar Empleados sin DNI');
			writeln('8) Realizar Baja');
			writeln('9) Cerrar');
			readln(opcion);
			case opcion of
				1:buscarNombre(emp); 
				2:listarCompleto(emp);
				3:mayores70(emp);
				4:aniadirEmpleados(emp);
				5:modificarEmpleado(emp);
				6:exportar(emp);
				7:exportarSinDNI(emp);
				8:realizarBaja(emp);
				9: aux:=false;
				else writeln('opcion no valida');
			end;
		end;
	end;
var 
	emps:empleados;
	nombre:string;
BEGIN
	writeln('Ingrese nombre de archivo');readln(nombre);
	assign(emps,nombre);
	menu(emps);
END.
