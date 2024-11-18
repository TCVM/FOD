program ejer11;
const pepeLaConstante=9999;
type
	acceso=record
		anio:integer;
		mes:1..12;
		dia:1..31;
		id:string;
		tiempo:real;
	end;
	
	maestre=file of acceso;
	
procedure leer(var mae:maestro;var reg:acceso);
	begin
		if(not eof(mae))then
			read(mae,reg);
		else
			reg.anio:=pepeLaConstante;
	end;
procedure corte(var mae:maestro;anio:integer);
	var
		reg:acceso;
		id,mes,dia,anio,hsdia,hsmes,hsanio,hstotal=integer;
		ok:boolean;
	begin
		hstotal:=0;
		ok:=true;
		reset(mae);
		leer(mae,reg);
		while((reg.anio <> pepeLaConstante)and(reg.anio<>anio)) do leer(mae,reg);
		while(reg.anio = anio)do begin
			writeln('anio', anio);
			mes:=reg.mes;
			ok:=true;
			hsmes:=0;
			while((reg.anio = anio) and (reg.mes= mes))do begin
				writeln('mes', mes);
				dia:=reg.dia;
				hsdia:=0;
				while((reg.anio = anio) and (reg.mes= mes) and (reg.dia = dia))do begin
					writeln('dia ',dia);
					id:=reg.id;
					hsanio:=0;
					while((reg.anio = anio) and (reg.mes= mes) and (reg.dia = dia) and (reg.id = id))do begin
						hstotal+=reg.tiempo;
						leer(mae,reg);
					end;
					writeln('userID ',id);
					writeln('Total Horas id ',hstotal);
					hsdias+=hstotal;
				end;
				writeln('Total Horas Dia ',hsdia);
				hsmes+=hsdia;
			end;
			writeln('Total Horas Mes ',hsmes);
			hsanio+=hsmes;
		end;
		if(ok)then
			writeln('Total Horas año', hsanio);
		else
			writeln('año no encontrado');
		close(mae);
	end;
var 
	mae:maestro;
	anio:integer;
BEGIN
	assign(mae,'ejer11maestro');
	writeln('ingrese año');
	readln(anio);
	corte(mae,anio);
END.
