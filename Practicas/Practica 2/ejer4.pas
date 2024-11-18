program ejer4;
const pepeLaConstante='ZZZ';
type
	provincia=record
		nom:string;
		cant,total:integer;
	end;
	
	provinciaDet=record
		nom:string;
		cant,total,cod:integer;
	end;
	
	maestro=file of provincia;
	detalle=file of provinciaDet;
	
procedure leer(var det:detalle;var reg:provinciaDet);	
	begin
		if(not eof(det))then
			read(det,reg);
		else
			reg.nom:=pepeLaConstante;
	end;
	
procedure minimo(var r1,r2:provinciaDet; var min:provinciaDet;var det1,det2:detalle);
		begin
			if(r1.nom<r2.nom)then begin
				min:=r1;
				leer(det1,r1);
			end
			else begin
				min:=r2;
				leer(det2,r2);
			end;
		end;
	
var 
	mae:maestro;
	det1,det2:detalle;
	min,r1,r2:provinciaDet;
	reg:provincia;
BEGIN	
	assign(mae,'ejer4Provincias');
	assign(det1,'ejer4ProvinciasDetalle1');
	assign(det2,'ejer4ProvinciasDetalle2');
	reset(mae);
	reset(det1);
	reset(det2);
	leer(det1,r1);leer(det2,r2);
	minimo(r1,r2,min,det1,det2);
	while(min.nom<>pepeLaConstante)do begin
		read(mae,reg);
		while((min.nom<>pepeLaConstante) and (min.nom=reg.nom))do begin
			reg.cant+=min.cant;
			reg.total+=min.total;
			minimo(r1,r2,min,det1,det2);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,reg);
	end;
END.

