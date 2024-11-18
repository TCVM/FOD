program ejer9;
const pepeLaConstante=9999;
type
	reg=record
		codP,codL,num,votos:integer;
	end;
	
	maestro=file of reg;

procedure leer(mae,reg);
	begin
		if(not eof(mae))then read(mae,reg)
		else
			reg.cod:=pepeLaConstante;
	end;
	
procedure corte(var mae:maestro);
	var
		votosP,votosT,votosL:integer;
		pAct,lAct:string;
		aux:reg;
	begin
		reset(mae)
		leer(mae)
		votosT:=0;
		while(aux.codP<>pepeLaConstante)do begin
			pAct:=aux.codP;
			votosP:=0;
			writeln('');
			writeln(aux.codP);
			writeln('');
			while(aux.codP = pAct)do begin
				lAct:=aux.codL;
				votosL:=0;
				while((aux.codP = pAct)and(aux.codL = lAct))do begin
					votosL+=aux.reg;
					leer(mae,reg);
				end;
				writeln(lAct,votosL);
				votosP+=votosL;
			end;
			writeln(votosP);
			votosT+=votosP;
		end;
		writeln(votosT);
	end;
var 
	mae:maestro;
BEGIN
	assign(mae);
	corte(mae);
END.

