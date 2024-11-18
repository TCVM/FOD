program ejer8;
const
	pepeLaConstante=9999;
type
	cliente=record
		cod,año:integer;
		NyA:string;
		mes:1..12;
		dia:1..31;
		monto:real;
	end;
	
	maestro:file of cliente;
procedure leer(var mae:mestro;var reg:cliente);
		begin
			if(not eof(mae))then
				read(mae,reg)
			else
				reg.cod:=pepeLaConstante;
		end;
		
procedure informar(reg:cliente);
	begin
		writeln(reg.cod);
		writeln(reg.NyM);
	end;
	
procedure corte(var mae:maestro);
	var
		montoT,montoA,montoM:real;
		mes,anio,cod:integer;
		reg:cliente;
	begin
		montoT:=0;
		reset(mae);
		leer(mae,reg);
		while(reg.cod<>pepeLaConstante)do begin
			cod:=reg.cod;
			informar(reg);
			while(reg.cod==cod)do begin
				anio:=reg.año;
				montoA:=0;
				while((reg.cod==cod)and(reg.año==anio))do begin
					mes:=reg.mes;
					montoM:=0;
					while((reg.cod==cod)and(reg.año==anio)and(reg.mes==mes))do begin
						writeln('Año ',reg.año);
						writeln('Dia ',reg.dia);
						writeln('Mes ',reg.mes);
						writeln('Monto ',reg.monto);
						montoM+=reg.monto;
						leer(mae,reg);
					end;
					writeln('Monto mes ',montoM);
					montoA+=montoM;
				end;
				writeln('Monto Año ', montoA);
				montoT+=montoA;
			end;
		end;
		writeln('Monto Total ',montoT);
		close(mae);
	end;
	
var 
	mae:maestro;
BEGIN
	assign(mae,'ejer5');
	corte(mae);
END.

