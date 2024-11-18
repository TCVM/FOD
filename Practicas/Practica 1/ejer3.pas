program ejer3;
type
	empleado=record
		num,edad,dni:integer;
		ape,nom:string;
	end;
	empleados=file of empleado;

procedure leer(var e:empleado);
	begin
		writeln('Ingrese apellido');readln(e.ape);
		if(e.ape<>'fin')then begin
			writeln('Ingrese nombre');readln(e.nom);
			writeln('Ingrese dni');readln(e.dni);
			writeln('Ingrese numero');readln(e.num);
			writeln('Ingrese edad');readln(e.edad);
		end;
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
	
procedure cargarArchivo(var emps:empleados);
	var
		e:empleado;
	begin
		rewrite(emps);
		leer(e);
		while(e.ape <> 'fin')do begin
			write(emps,e);
			leer(e);
		end;
		close(emps);
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
			writeln('4) Cerrar');
			readln(opcion);
			case opcion of
				1:buscarNombre(emp); 
				2:listarCompleto(emp);
				3:mayores70(emp);
				4: aux:=false;
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
	cargarArchivo(emps);
	menu(emps);
END.

