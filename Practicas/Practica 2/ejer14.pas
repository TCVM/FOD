program ejer14;
const pepeLaConstante=9999;
type
	rMaestro=record
		codP,codL,vL,vG,vC,vA,vS:integer;
		nom:string;
	end;
	rDetalle=record
		codP,codL,vL,vC,vA,vG,eS:integer;
	end;
	
	maestro=file of rMaestro;
	detalle=file of rDetalle;
	
	vector=array[1..10]of detalle;
	vectorReg=array[1..10]of rDetalle;
	
procedure leer(var det:detalle;var reg:rDetalle);
	begin
		if(not eof(det))then
			read(det,reg);
		else 
			reg.codP:=pepeLaConstante;
	end;
	
procedure minimo(var v:vector;var vr:vectorReg;var min:rDetalle);
	var
		aux,i:integer;
	begin
		aux:=0;
		min.codP:=pepeLaConstante;
		for i:=1 to 10 do begin
			if(vr[i].codP<>pepeLaConstante)then
				if((min.codP>vr[i].codP)or(min.codP=vr[i].codP)and(min.codL<vr[i].codL))then begin
					min:=v[i];
					aux:=i;
				end;
		end;
		if(aux<>0)then leer(v[aux],vr[aux]);
	end;
	
procedure corte(var mae:maestro;var v:vector;var vr:vectorR);
	var
		min:rDetalle;
		reg:rMaestro;
		codP,codL,vL,vC,vA,vG,eS,i:integer;
	begin
		reset(mae);
		for i:=1 to 10 do begin
			assign(v[i],'ejer14detalle' + 1);
			reset(v[i]);
			leer(v[i],vr[i]);
		end;
		minimo(v,vr,min);
		while(min.codP<>pepeLaConstante)do begin
			codP:=min.codP;
			while(codP=min.codP)do begin
				codL:=min.codL;
				vL:=0;
				vC:=0;
				vA:=0;
				vG:=0;
				eS:=0;
				while((codP=min.codP)and(codL=min.codL))do begin
					vL+=min.vL;
					vC+=min.vC;
					vA+=min.vA;
					vG+=min.vG;
					eS+=min.eS;	
					minimo(v,vr,min);
				end;
				read(mae,reg);
				while((reg.codP<>min.codP)or(reg.codL<>min.codL))do read(mae,reg);
				reg.vL-=vL;
				reg.vC-=vC;
				reg.vA-=vA;
				reg.vG-=vG;
				reg.vS-=eS;
				seek(mae,filePos(mae)-1);
				write(mae,reg);
			end;
		end;
		for i:=1 to 10 do close(v[i]);
		close(mae);
	end;

var 
	reg:rMaestro;
	mae:maestro;
	v:vector;
	vr:vectorR;
	cant:integer;
BEGIN
	assign(mae,'ejer14maestro');
	cant:=0;
	corte(mae,v,vr);
	reset(mae);
	while (not eof(mae))do begin
		read(mae,reg);
		if(reg.vC = 0)then cant++;
	end;
	writeln(cant);
END.

