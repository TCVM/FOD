Program ejer3Parte2;
const pepeLaConstante=9999;
type
	log=record
		cod:integer;
		fecha:string;
		tiempo:real;
	end;
	
	maestro=file of log;
	detalle=file of log;
	
	vector=array[1..5]of detalle;
	
procedure leer(var det:detall;var reg:log);
	begin
		if(not eof(det))then
			read(det,reg)
		else
			reg.cod:=pepeLaConstante;
	end;
	
procedure cargar(var mae:maestro;var v:vector);
	var
		reg,aux:log;
		i:integer;
	begin
		rewrite(mae);
		for i:=1 to 5 do begin 
			reset(v[i]);
			leer(v[i],aux);
			while(aux.cod<>pepeLaConstante)do begin
				if(not eof(mae))then begin
					read(mae,reg);
					while(reg.cod<>aux.cod)do read(mae,reg);
					if(reg.cod=aux.cod)then begin
						reg.tiempo+=aux.tiempo;
						seek(mae,filePos(mae)-1);
					end;
				end
				write(mae,aux);
				seek(mae,0);
				leer(v[i],aux);
			end;
			close(vector[i]);
		end;
		close(mae);
	end;
var 
	mae:maestro;
	v:vector;
	i:integer;
BEGIN
	assign(mae,'ejer3P2maestro');
	for i:=1 to 5 do assign(v[i],'ejer3P2detalle' + i);
	cargar(mae,v);	
END.

