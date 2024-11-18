program ejer3;
type
	producto=record;
		cod,stockmin,stockact:integer;
		nom:string;
		precio:real;
	end;
	productoDet=record;
		cod,cantVendida:integer;
	end;
	
	maestro=file of producto;
	detalle=file of productoDet;
	
procedure ActualizarMaestro(var mae:maestro;var det:detalle);
	var
		reg:producto;
		regDet:productoDet;
	begin
		reset(det);
		reset(mae);
		while(not eof(det))do begin
			read(det,regDet);
			read(mae,reg);
			while(reg.cod<>regDet.cod)do
				read(mae,reg);
			reg.stockact-=regDet.cantVendida;
			seek(filepos(mae)-1);
			write(mae,reg);
		close(mae);
		close(det);
	end;
	
procedure exportarTextoConStockActualMenor(var mae:maestro);
	var
		at:texto;
		reg:alumno;
	begin
		assign(at,'Stock_minimo.txt');
		reset(mae);
		rewrite(at);
		while(not eof(mae))do begin
			read(mae,reg);
			if(reg.stockmin>reg.stockact)then
				write(at,reg.precio,reg.cod,reg.stockmin,reg.stockact,reg.nom);
		end;
		close(mae);
		close(at);
			
	end;	
var 
	mae:maestro;
	det:detalle;
BEGIN
	assign(mae,'maestroE3');
	assign(det,'detalleE3');
	actualizarMaestro(mae,det);
	exportarTextoConStockActualMenor(mae);
END.

