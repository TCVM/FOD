program ejer6;
uses SysUtils;

const pepeLaConstante=9999;
type
	usuario=record
		cod:integer;
		fecha:string;
		tiempoTotal:real;
	end;
	
	usuarioDet=record
		cod:integer;
		fecha:string;
		tiempo:real;
	end;
	
	maestro=file of usuario;
	detalle=file of usuarioDet;
	
	vectorDet=array[1..5]of detalle;
	vectorDetReg=array[1..5]of usuarioDet;
	
procedure leer(var det:detalle; var reg:usuarioDet);
	begin
		if(not eof(det))then
			read(det,reg);
		else
			reg.cod:=pepeLaConstante;
	end;
	
procedure minimo(var vec:vectorDetReg; var vecD:vectorDet;var min:usuarioDet);
	var
		i,aux:integer;
	begin
		min.fecha:=pepeLaConstante;
		min.cod:=pepeLaConstante;
		for i:=1 to 5 do begin
			if(min.cod<vec[i].cod)then begin
				min:=vec[i];
				aux:=i;
			end
			else
				if((min.cod=vec[i].cod)then 
					if(min.fecha<=vec[i].fecha))then begin
						min:=vec[i];
						aux:=i;
				end;
		end;
		if(min.cod <> pepeLaConstante)then
			leer(vecD[i],vec[i]);
	end;
	
procedure crearMaestro(var mae:maestro; var vec:vectorDet; vecR:vectorDetReg);
	var
		min:usuarioDet;
		aux:usuario;
		i:integer;
		aux2:real;
	begin
		for i:=1 to 5 do begin
			assign(vec[i],'ejer6det' + IntToStr(i));//aca o en main?
			reset(vec[i]);
			leer(vec[i],vecR[i]);
		end;
		minimo(vec,vecD,min);
		while(min.cod<>pepeLaConstante)do begin
			aux.cod:=min.cod;
			aux.fecha:=min.fecha;
			aux.tiempoTotal:=0;
			aux2:=0;
			//no actualiza, esta creando
			while((aux.cod = min.cod )and (aux.fecha = min.fecha))do 
				aux2+=min.tiempo;
				minimo(vec,vecD,min);
			end;
			aux.tiempoTotal:=aux2;
			write(mae,aux);
		end;
		for i:=1 to 5 do close(vecR[i]);
	end;
var 
	mae:maestro;
	vec:vectorDet;
	vecR:vectorDetReg;
BEGIN
	assign(mae,'var/log/Usuarios');
	rewrite(mae);
	crearMaestro(mae,vec,vecR);
	close(mae);
END.

