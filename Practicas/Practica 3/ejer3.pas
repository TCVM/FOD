program ejer3;
const
	pepeLaConstante=9999;
type
	novela=record
		cod,dura:integer;
		gen,nom,direc:string;
		pre:real;
	end;
	archivo=file of novela;

procedure leerReg(var reg:novela);
	begin
		writeln();readln(a.cod);
			if(a.cod<>pepeLaConstante)then begin
				writeln();readln(a.dura);
				writeln();readln(a.direc);
				writeln();readln(a.nom);
				writeln();readln(a.gen);
				writeln();readln(a.pre);
			end;
	end;

procedure leer(var arch:archivo;var reg:novela);
	begin
		if(not eof(arch))then
			read(arch,reg)
		else
			reg.cod:=pepeLaConstante;
	end;

procedure cargar(var arch:archivo);
	var
		reg:novela;
	begin
		rewrite(arch);
		reg.cod:=0;
		write(arch,reg);
		leerReg(reg);
		while(reg.cod<>pepeLaConstante)do begin
			write(arch,reg);
			leerReg(reg);
		end;
		close(arch);
	end;
	
procedure agregar(var arch:archivo);
	var
		reg,indice:novela;
	begin
		reset(arch,reg);
		leer(arch,reg);
		if(reg.cod > 0)then begin
			seek(arch,abs(reg.cod));
			read(arch,indice);
			seek(arch,filepos(arch)-1);
			leerReg(reg);
			write(arch,reg);
			seek(arch,0);
			write(arch,indice);
		end
		else
			seek(arch,fileSize(arch));
			leer(reg);
			write(arch,reg);
	end;

procedure modificar(var arch:archivo);
	var
		nro,pos,opcion:integer;
		reg:novela;
	begin
		reset(arch);
		pos:=-1;
		writeln('ingrese numero de novela');readln(nro);
		buscar(arch,nro,pos);
		if(pos<>-1)then begin
			seek(arch,pos);
			read(arch,reg);
			writeln('1)modificar duracion');
			writeln('2)modificar direccion');
			writeln('3)modificar nombre');
			writeln('4)modificar genero');
			writeln('5)modificar precio');
			readln(opcion);
			case opcion of
				1: writeln('Ingrese modificacion');
					readln(reg.dura);
				2: writeln('Ingrese modificacion');
					readln(reg.direc);
				3: writeln('Ingrese modificacion');
					readln(reg.nom);
				4: writeln('Ingrese modificacion');
					readln(reg.gen);
				5: writeln('Ingrese modificacion');
					readln(reg.pre);
			else
				break;
			seek(arch,filepos(arch)-1);
			write(arch,reg);
		end;
		close(arch);
	end;
	
procedure eliminar(var arch:archivo);
	var
		ok:boolean;
		cod:integer;
		reg,aux:novela;
	begin
		ok:=false;
		reset(arch);
		writeln();readln(cod);
		leer(arch,reg);//lee cabecera
		leer(arch,aux);
		while((reg.cod<>pepeLaConstante)and not(ok))do begin
			if(reg.cod=codigo)then begin
				ok:=true;
				aux.cod:=reg.cod;//copio indice de cabecera a registro a eliminar
				seek(arch,filepos(arch)-1);
				reg.cod=filepos(arch)*-1;//indice a negativo
				write(arch,aux);
				seek(arch,0);
				write(arch,reg);//reemplaza cabercera con registro eliminado
			end
			else
				leer(arch,aux);
		end;
		close(arch);
	end;
	
procedure listar(var arch:archivo;var txt:Text);
	var
		reg:novela;
	begin
		reset(arch);
		rewrite(txt);
		seek(arch,1);
		leer(arch,reg);
		while(reg.cod<>pepeLaConstante)do begin
			writeln(txt,reg.cod,reg.dura,reg.gen);
			writeln(reg.nom);
			writeln(reg.direc);
		pre:real;);
			leer(arch,reg);
		end;
		close(txt);
		close(arch);
	end;

procedure menu(var arch:archivo;var txt:Text);
	var
		aux:boolean;
		opcion:integer;
	begin
		aux:=true;
		while(aux)do begin
			writeln('1) cargar');
			writeln('2) abrir');
			writeln('3) salir');
			readln(opcion);
			case opcion of
				1:cargar(arch);
				2:
					writeln('1)Dar de Alta Novela');
					writeln('2)Modificar Novela');
					writeln('3)Eliminar Novela');
					writeln('4)Listar Novela');
					writeln('5)Atras');
					readln(opcion);
					case opcion of
						1:agregar(arch);
						2:modificar(arch);
						3:eliminar(arch);
						4:listar(arch);
						5:break;
				3:aux:=false;
			else
				writeln('numero de opcion no valido');
		end;
	end;
var
	nombre:string;
	arch:archivo;
	txt:Text;
BEGIN
	writeln('ingrese nombre de archivo');readln(nombre);
	assign(arch,nombre);
	assign(txt,'novelas.txt');
	menu(arch,txt);
END.

