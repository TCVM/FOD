program ejer6;
type 
	celular=record
		cod,stockmin,stockdis:integer;
		nombre,descrip,marca:string;
		precio:real;
	end;
	
	celulares=file of celular;
procedure CrearBinario(var cels:celulares;var carga:Text);
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
	
procedure leer(var c:celular);
	begin
			writeln('Ingrese codigo');readln(c.cod);
			writeln('Ingrese Stock minimo');readln(c.stockmin);
			writeln('Ingrese Stock disponible');readln(c.stockdis);
			writeln('Ingrese nombre');readln(c.nombre);
			writeln('Ingrese descripcion');readln(c.descrip);
			writeln('Ingrese marca');readln(c.marca);
			writeln('Ingrese precio');readln(c.precio);
		end;
	
		
procedure agregarCel(var cels:celulares);
	var
		c,celreg:celular;
		aux:boolean;
		ok:char;
	begin
		reset(cels);
		aux:=true;
		leer(c);
		while(aux)do begin
			if(eof(cels))then write(cels,c)
			else begin
				read(cels,celreg);
				while((Not eof(cels)) AND (c.nombre <> celreg.nombre))do begin
					read(cels,celreg);
				end;
				if(c.nombre <> celreg.nombre)then begin
					write(cels,c);
				end
				else writeln('Celular ya existente');
			end; 
			writeln('agregar otro s/n');readln(ok);
			if(ok = 's')then begin 
				leer(c);
				seek(cels,0);
			end
			else aux:=false;
		end;
		close(cels);
	end;

procedure modificarStock(var cels:celulares);
	var
		c:celular;
		stock:integer;
		nombre:string;
		ok:boolean;
	begin
		reset(cels);
		ok:=true;
		writeln('Ingrese nombre de celular a modificar');readln(nombre);
		while((Not eof(cels)) and (ok))do begin
			read(cels,c);
			if(c.nombre = nombre)then begin
				writeln('ingrese stock');readln(stock);
				c.stockdis:=stock;
				ok:=false;
				seek(cels,filePos(cels)-1);
				write(cels,c);
			end;
		end;
		if(ok = true)then writeln('celular no encontrado');
		close(cels);
	end;
	
procedure exportarSinStock(var cels:celulares);
		var
		at:Text;
		c:celular;
	begin
		assign(at,'SinStock.txt');
		rewrite(at);
		reset(cels);
		while(Not eof(cels))do begin
			read(cels,c);
			if(c.stockdis = 0)then writeln(at,c.cod,' ',c.precio,' ',c.marca);
									writeln(c.stockdis,' ',c.stockmin,' ',c.descrip);
									writeln(c.nombre);
		end; 
		close(at);
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
			writeln('5) Agregar Celulares');
			writeln('6) Modificar Stock de Celular');
			writeln('7) Exportar sin Stock');
			writeln('8) cerrar');
			readln(opcion);
			case opcion of
				1:crearBinario(cels,carga);
				2:listarMenorStock(cels);
				3:listarConDescripcion(cels);
				4:exportar(cels,carga);
				5:agregarCel(cels);
				6:modificarStock(cels);
				7:exportarSinStock(cels);
				8:aux:=false;
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


