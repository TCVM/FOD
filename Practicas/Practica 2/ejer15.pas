program ejer15;
const pepeLaConstante='zzzz';
type
	rMaestro=record
		fecha,nom,desc:string;
		cod,eT,eV:integer;
		precio:real;
	end;
	rDetalle=record
		fecha:string;
		cod,eV:integer;
	end;
	maestro=file of rMaestro;
	detalle=file of rDetalle;
	
	vector=array[1..100]of detalle;
	vectorR=array[1..100]of rDetalle;
	
procedure leer(var det:detalle;var reg:rDetalle);
	begin
		if(not eof(det))then
			read(det,reg)
		else
			reg.fecha:=pepeLaConstante;
	end;
procedure minimo(var v:vector;var vr:vectorR;var min:rDetalle);
	var
		aux,i:integer;
	begin
		min.fecha=pepeLaConstante;
		aux:=0;
		for i:=1 to 100 do begin
			if((min.fecha>vr[i].fecha)or((min.fecha=vr[i].fecha)and(min.cod>vr[i].cod)))then begin
				min:=vr[i];
				aux:=i;
			end;
		end;
		if(aux<>0)then
			leer(v[aux],vr[aux]);
	end;

procedure corte(var mae:maestro;var v:vector;var vr:vectorR);
	var
		min:rDetalle;
		i,cod,eV:integer;
		fecha:string;
		reg:rMaestro;
	begin
		reset(mae);
		for i:=1 to 100 do begin
			assign(v[i],'ejer15detalle'+1);
			reset¨(v[i]);
		end;
		minimo(v,vr,min);
		while(min.fecha<>pepeLaConstante)do begin
			fecha:=min.fecha;
			while(min.fecha=fecha)do begin
				cod:=min.cod;
				eV:=0;
				while((min.fecha=fecha)and(min.cod=cod))do begin
					eV+=min.eV;
					minimo(v,vr,min);
				end;
				read(mae,reg);
				while((fecha<>reg.fecha)or(cod<>reg.cod))do read(mae,reg);
				reg.eV+=eV;
				reg.eT-=eV;
				seek(mae,filePos(mae)-1);
				write(mae,reg);
			end;
		end;
		close(mae);
		for i:=1 to 100 do close(v[i]);
	end;
var
	mae:maestro;
	v:vector;
	vr:vectorR;
	reg,maxR,minR:rMaestro;
	max,min:integer;
BEGIN
	assign(mae,'ejer15maestro');
	corte(mae,v,vr);
	reset(mae);
	max:=0;
	min:=9999;
	read(mae,reg);
	while(not eof(mae))do begin
		if(reg.eV>max)then maxR:=reg
		else
			if(reg.eV<min)then minR:=reg;
		read(mae,reg);
	end;
END.

