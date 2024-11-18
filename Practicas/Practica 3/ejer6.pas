program ejer6;
const pepeLaConstante=9999;
type
	prenda=record
		cod_prenda,stock:integer;
		descripcion,colores,tipo_prenda:string;
		precio_unitario:real;
	end;
	
	maestro=file of prenda;
	detalle=file of integer;
	aux=file of prenda;
	
procedure leer(var arch:detalle;var dato:integer);
	begin
		if(not eof(arch))then
			read(arch,dato)
		else
			dato:=pepeLaConstante;
	end;
	
procedure baja(var mae:maestro;var det:detalle);
	var
		reg:prenda;
		dato:integer;
		ok:boolean;
	begin
	reset(mae);
	reset(det);
	leer(det,dato);
	while(dato<>pepeLaConstante)do begin
		ok:=false;
		read(mae,reg);
		while(not eof(mae) and not(ok))do
			if(reg.cod_prenda==dato)then begin
				reg.stock*=-1;
				ok:=true;
				seek(mae,filepos(mae)-1);
				write(mae,reg);
				seek(mae,0);
			end;
		leer(det,dato);
	end;
	close(det);
	close(mae);
	end;

procedure listarNoObsoletos(var mae:maestro;var aux:aux);
	var
		reg:prenda;
	begin
		reset(mae);
		rewrite(aux);
		read(mae,reg);
		while(not eof(mae))do begin
			if(reg.stock>0)then
				write(aux,reg);
			read(mae,reg);
		close(aux);
		close(mae);
	end;
var 
	mae:maestro;
	det:detalle;
	aux:aux;
BEGIN
	assign(mae,'ejer6maestro');
	assign(det,'ejer6detalle');
	assign(aux,'ejer6auxiliar');
	baja(mae,det);
	listarNoObsoletos(mae,aux);
END.

