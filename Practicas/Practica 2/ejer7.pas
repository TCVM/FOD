program ejer7;
const pepeLaConstante=9999;
type
	archivoDet=record
		codL,codC,act,nue,recus,fal:integer;
	end;
	archivo=record
		codL,codC,act,nue,recus,fal:integer;
		nomC,nomL:string;
	end;
	
	maestro=file of archivo;
	detalle=file of archivoDet;
	
	vectorDet=array[1..10]of detalle;
	vectorDetReg=array[1..10]of archivoDet;
	
procedure leer(var det:detalle; var reg:archivoDet);
	begin
		if(not eof(det))then
			read(det,reg);
		else
			reg.cod:=pepeLaConstante;
	end;
procedure minimo(var vecD:vectorDet;var vecR:vectorDetReg;var min:archivoDet);
	var
		i,aux:integer;
	begin
		min.codL:=pepeLaConstante;
		min.codC:=pepeLaConstante;
		for i:=1 to 10 do begin
			if(min.codL<vecD[i].codL)then begin
				min:=vecD[i];
				aux:=i;
			end
			else
				if((min.codL=vecD[i].codL)then 
					if(min.codC <= vec[i].codC))then begin
						min:=vec[i];
						aux:=i;
				end;
		end;
		if(min.codL <> pepeLaConstante)then
			leer(vecD[i],vec[i]);
	end;

procedure corte(var mae:maestro; var vec:vectorDet; vecR:vectorDetReg);
	var
		aux:archivo;
		min:archivoDet;
	begin
		reset(mae);
		for i:= 1 to 10 do begin 
			reset(vec[i]);
			leer(vec[i],vecD[i]);
		end;
		minimo(vec,vecR,min);
		while(min<>pepeLaConstante)do begin
			read(mae,aux);
			while((min.codL=aux.codL) and (min.codC = aux.codC)) do begin
				aux.fal+=min.fal;
				aux.recus+=min.recus;
				aux.act:=min.act;
				aux.nue:=min.nue;
				minimo(vec,vecR,min);
			end;
		end;
	end;
	
procedure imprimir(var mae:maestro);
	var
		reg:archivo;
		aux:integer;
	begin
		aux:=0;
		reset(mae);
		while(not eof(mae))do begin
			read(mae,reg)
			if(reg.act>50)then
				aux:=1;
		end;
		close(mae);
		writeln(aux);
	end;

var 
	mae:maestro;
	vec:vectorDet;
	vecR:vectorDetReg;
BEGIN
	assign(mae, 'ejer7maestro');
	for i:=1 to 10 do assign(vec[i],'ejer7det'+i);
	corte(mae,vec,vecD);
	imprimir(mae);
END.

