program ejer2;
const pepeLaConstante=9999;
type
	alumno=record
		cod,cursadas,finales:integer;
		nom,ape:string;
	end;

	alumDet=record;
		cod:integer;
		final:boolean;
	end;
	
	detalle=file of alumDet;
	maestro=file of alumno;

procedure leer(var det:detalle;var reg:alumDet);
	begin
		if(not eof(det))then read(det,reg)
		else
			reg.cod:=pepeLaConstante;
	end;
	
procedure Corte(var det:detalle;var mae:maestro);
	var
		reg:alumno;
		regDet:alumDet;
	begin
		reset(mae);
		reset(det);
		leer(det,regDet);
		while(regDet.cod<>pepeLaConstante)do begin
			read(mae,reg);
			//while(reg.cod<>regDet.cod)do read(mae,reg); ?
			while(reg.cod=regDet.cod)do begin
				if(regDet.final)then begin
					reg.finales+=1;
					reg.cursadas-=1;
				end
				else
					reg.cursadas+=1;
			end;
			seek(mae,filepos(mae)-1);
			write(mae,reg);
		end;
		close(mae);
		close(det);
	end;

procedure exportarTextoConAprobadosPorFinal(var mae:maestro);
	var
		at:texto;
		reg:alumno;
	begin
		assign(at,'AprobadosPorFinal.txt');
		reset(mae);
		rewrite(at);
		while(not eof(mae))do begin
			read(mae,reg);
			if(reg.finales>reg.cursadas)then
				write(at,reg.cod,reg.finales,reg.cursadas,reg.nom,reg.ape);
		end;
		close(mae);
		close(at);
			
	end;
var
	det=detalle;
	mae=maestro;
BEGIN
	assign(det,'detalleE2');
	assign(mae,'maestroE2');
	corte(mae,det);
	exportarTextoConAprobadosPorFinal(mae);
END.

