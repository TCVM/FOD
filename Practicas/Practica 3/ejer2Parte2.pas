program ejer2Parte2;
const pepeLaConstante=9999;

	mesa=record
		cod,nro,cant:integer;
	end;
	archivo=file of mesa;
	auxiliar=file of mesa;

procedure leer(var arc:archivo;var reg:mesa);
	begin
		if(not eof(arc))then
			read(arc,reg)
		else
			reg.cod:=pepeLaConstante;
	end;
procedure control(var arc:archivo;var aux:auxiliar);
	var
		reg,regA:mesa;
	begin
		reset(arc);
		rewrite(aux);
		leer(arc,reg);
		while(reg.cod<>pepeLaConstante)do begin
			if(not eof(aux))then begin
				read(aux,regA);
				while((not eof(aux))and(regA.cod<>reg.cod))do read(aux,regA);
				if(regA.cod=reg.cod)then begin
					reg.cant+=regA.cant;
					seek(aux,filepos(aux)-1);
				end
			end;
			write(aux,reg);
			seek(aux,0);
			leer(arc,reg);
		end;
		close(aux);
		close(arc);
	end;
	
procedure mostrar(var aux:archivo);
	var
		votosg,votosp,cod:integer;
		reg:mesa;
	begin
		votosg:=0;
		leer(aux,reg);
		while(aux.cod<>pepeLaConstante)do begin
			cod:=aux.cod;
			writeln(cod);
			while((cod=aux.cod)and(aux.cod<>pepeLaConstante))do begin
				votosp+=cod.cant;
			end;
			votosg+=votosp;
			writeln(votosp);
		end;
		writeln(votosg);
		close(aux);
	end;
var
	arc,aux:archivo;
BEGIN
	assign(arc,'ejer2p2archivo');
	assign(aux,'ejer2p2aux');
	control(arc,aux);
	mostrar(aux);
END.

