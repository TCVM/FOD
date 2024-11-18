program ejer5;
const pepeLaConstante='9999';
type
	producto=record
		nom,descrip:string;
		cod,stockmin,stockact:integer;
		precio:real;
	end;
	
	productoDet=record
		cod,cant:integer;
	end;
	
	maestro=file of producto;
	detalle=file of productoDet;
	
	vectorDet=array[1..30] of detalle;
	vectorRegDet=array[1..30]of productoDet;
	
procedure leer(var det:detalle; reg:productoDet);
		begin
			if(not eof(det))then read(det,reg)
			else reg.cod:=pepeLaConstante;
		end;
procedure minimo(var vec:vectorDet;var vecD:vectorRegDet;var min:productoDet);
	var 
		i,aux:integer;
	begin
		min.cod:=pepeLaConstante;
		for i:=1 to 30 do begin
			if(min.cod>vecD[i].cod)then begin
				min:=vectD[i];
				aux:=i;
			end;
		leer(vec[aux],vecD[aux]);
		end;
	end;
procedure corte(var mae:maestro; var vec:vectorDet;var vecD:vectorRegDet);
	var
		min:productoDet;
		reg:producto;
		i:integer;
	begin
		reset(mae);
		for i:= 1 to 30 do begin 
			reset(vec[i]);
			leer(vec[i],vecD[i]);
		end;
		minimo(vec,vecD,min);
		while(min.cod<>pepeLaConstante)do begin
			read(mae,reg);
			while(reg.cod=min.cod)do begin
				reg.stockact-=min.cant;
				minimo(vec,vecD,min);
			end;
			write(mae,reg);
		end;
		close(mae);
		for i:= 1 to 30 do close(vec[i]);
	end;
	
procedure exportarTexto(var mae:maestro);
	var
		at:Text;
		reg:producto;
	begin
		reset(mae);
		rewrite(at);
		while(not eof(mae))do begin
			read(mae,reg)
			if(reg.stockact<reg.stockmin)
				write(at,reg.precio,reg.stockact,reg.nom,reg.descrip);
		end;
		close(mae);
		close(at);
	end;
var 
	vec:vectorDet;
	vecD:vectorRegDet;
	mae:maestro;
	i:integer;
BEGIN
	assign(mae,'ejer5maestro');
	for i:=1 to 30 do assign(vec[i],'ejer5det'+i);
	corte(mae,vec,vecD);
	exportarTexto(mae);
END.

