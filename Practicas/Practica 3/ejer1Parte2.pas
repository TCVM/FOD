program ejer1Parte2;
const pepeLaConstante=9999;
type
	producto=record
		cod,stockA,stockM:integer;
		nom:string;
		precio:real;
	end;
	
	productoDet=record
		cod,cant:integer;
	end;
	
	maestro=file of producto;
	detalle=file of productoDet;
	
procedure leer(var det:detalle;var reg:productoDet);
	begin
		if(not eof(det))then
			read(det,reg)
		else
			reg.cod:=pepeLaConstante;
	end;
	
procedure actualizar(var mae:maestro;var det:detalle);
	var
		reg:producto;
		regDet:productoDet;
	begin
		reset(mae);
		reset(det);
		leer(det,regDet);
		while(regDet.cod<>pepeLaConstante)do begin
			read(mae,reg);
			while(reg.cod<>regDet.cod)do read(mae,reg);//asumo que todos los registros de detalle corresponden a uno de maestro
			reg.stockA-=det.cant;
			seek(mae,filepos(mae)-1);
			write(mae,reg);
			seek(mae,0);
			leer(det,regDet);
		end;
		close(det);
		close(mae);
	end;
	
//b???
var 
	mae:maestro;
	det:detalle;
BEGIN
	assign(mae,'ejer1P2maestro');
	assign(det,'ejer1P2detalle');
	actualizar(mae,det);
END.

