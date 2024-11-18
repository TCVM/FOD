program ejer5;
type 
	celular=record
		cod,stockmin,stockdis:integer;
		nombre,descrip,marca:string;
		precio:real;
	end;
	
	celulares=file of celular;
procedure CrearBinario(var cels:celulares;var carga:text);
	var			
		c:celular;
	begin
		rewrite(cels);
		reset(carga);
		while(Not eof(carga))do begin
			readln(carga,c.cod,c.precio,c.marca,c.stockdis,c.stockmin,c.descrip,c.nombre);
			write(cels,c);
		end;
		close(carga);
		close(cels);
	end;
procedure imprimir(c:celular);
	begin
		writeln('codigo: ',c.cod);
		writeln('stock disponible: ',c.stockdis);
		writeln('stock minimo: ',c.stockmin);
		writeln('nombre: ',c.nombre);
		writeln('descripcion: ',c.descrip);
		writeln('marca: ',c.marca);
	end;
procedure listarMenorStock(var cels:celulares);
	var
		c:celular;
	begin
		reset(cels);
		while(Not eof(cels))do begin
			read(cels,c);
			if(c.stockmin>c.stockdis)then imprimir(c);
		end;
		close(cels);
	end;
procedure listarConDescripcion(var cels:celulares);
	var
		c:celular;
	begin
		reset(cels);
		while(Not eof(cels))do begin
			read(cels,c);
			if(c.descrip <> '')then imprimir(c);
		end;
		close(cels);
	end;
	
procedure exportar(var cels:celulares;var carga:Text);
	var
		c:celular;
	begin
		rewrite(carga);
		reset(cels);
		while(Not eof(cels))do begin
			read(cels,c);
			writeln(carga,c.cod,' ',c.precio,' ',c.marca);
			writeln(c.stockdis,' ',c.stockmin,' ',c.descrip);
			writeln(c.nombre);
		end; 
		close(carga);
		close(cels);
	end;
procedure menu(var cels:celulares;var carga:Text);
	var
		opcion:integer;
		aux:boolean;
	begin
		aux:=true;
		while(aux=true)do begin
			writeln('1) Crear Binario a partir de un texto');
			writeln('2) Listar celulares con stock menor al minimo');
			writeln('3) Listar celulares con descripciones hechas por el usuario');
			writeln('4) exportar a texto');
			writeln('5) cerrar');
			readln(opcion);
			case opcion of
				1:crearBinario(cels,carga);
				2:listarMenorStock(cels);
				3:listarConDescripcion(cels);
				4:exportar(cels,carga);
				5:aux:=false;
				else
					writeln('Error');
				end;
		end;
	end;
var 
	cels:celulares;
	carga:Text;
	nombre:string;
BEGIN
	writeln('Ingrese nombre para el archivo');readln(nombre);
	assign(cels,nombre);
	assign(carga,'celulares.txt');
	menu(cels,carga);
END.

