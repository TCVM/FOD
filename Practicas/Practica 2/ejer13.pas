program ejer13;
const pepeLaConstante='zzzz';
type
	vuelo:=record
		dest,fecha:string;
		hora,cant:integer;
	end;
	vueloDet=record
		dest,fecha:string;
		hora,cant:integer;
	end;
	
	maestro=file of vuelo;
	detalle=file of vueloDet;
	
	lista=^nodo;
	nodo=record
		dato:vuelo;
		sig:lista;
	end;
procedure leer(var det:detalle;var reg:vueloDet);
	begin
		if(not eof(det))then
			read(det,reg)
		else
			reg.dest:=pepeLaConstante;
	end;
	
procedure minimo(var detalle1,detalle2:detalle;var min:vueloDet;var det1,det2:vueloDet);
	begin
		if(det1.dest<det2.dest)or((det1.dest=det2.dest)and(det1.fecha<det2.fecha))or((det1.dest = det2.dest)and(det1.fecha=det2.fecha)and(det1.hora<det2.hora))then begin
			min:=det1;
			leer(detalle1,det1);
		end
		else begin
			min:=det2;
			leer(detalle2,det2);
		end;
	end;

procedure corte(var mae:maestro;var det1,det2:detalle);
	var
		fecha,descrip:string;
		hora,asientos:integer;
		min,detR1,detR2:vueloDet;
		reg:vuelo;
	begin
		leer(det1,detR1);leer(det1,detR1);
		minimo(detalle1,detalle2,min,detR1,detR2);
		while(min.dest<>pepeLaConstante)do begin
			dest:=min.dest;
			while(min.dest=dest)do begin
				fecha:=min.fecha;
				while((min.dest=dest)and(min.fecha=fecha))do begin
					asientos:=0;
					hora:=min.hora;
					while((min.dest=dest)and(min.fecha=fecha)and(min.hora=hora))do begin
						asientos-=min.cant;
						minimo(detalle1,detalle2,min,detR1,detR2);
					end;
					read(mae,reg);
					while((dest<>reg.dest) or (fecha<>reg.fecha)or(hora<>reg.hora))do
						read(mae,reg);
					seek(mae,filepos(mae)-1);
					reg.cant-=asientos;
					write(mae,reg);
				end;
			end;
		end;
		close(mae);
		close(det1);
		close(det2);
	end;
	
procedure listar(var mae:maestro;var l:lista;asientos:integer);
	procedure agregarAtras(var l,ult:lista;dato:vuelo);
		var
			aux:lista;
		begin
			new(aux);
			aux^.dato:=dato;
			aux^.sig:=nil;
			if(l = nil)then
				l:=aux
			else
				ult^.sig:=aux;
			ult:=aux;
		end;
	var
		ult:l;
		reg:vuelo;
	begin
		l:=nil;
		ult:=nil;
		reset(mae);
		while(not eof(mae))do begin
			read(mae,reg);
			if(reg.cant<asientos)then
				agregarAtras(l,ult,reg);
		end;
		close(mae);
	end;
var
	l:lista;
	mae:maestro;
	det1,det2:detalle;
	aux:integer;
BEGIN
	assign(mae,'ejer13maestro');
	assign(det1,'ejer13det1');
	assign(det2,'ejer13det2');
	corte(mae,det1,det2);
	writeln('ingrese cantidad asientos');
	readln(aux);
	listar(mae,l,aux);	
END.

