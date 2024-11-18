program ejer10;
const 
	pepeLaConstante='zzzz';
type
	categ=1..15;
	empleado=record
		depto,division:string;
		num,horas:integer;
		categoria:categ;
	end;
	
	cat=record
		nro:categ;
		monto:real;
	end;
	
	maestro=file of empleado;

	vector=array[categ]of real;
	
procedure leer(var mae:maestro;var reg:empleado);
	begin
		if(not eof(mae))then
			read(mae,reg)
		else
			reg.depto:=pepeLaConstante;
	end;
	
procedure corte(var mae:maestro;vec:vector);
	var
		reg:empleado;
		depto,division:string;
		num,hsdepto,hsdiv,hstotales:integer;
		montodiv,montodepto,montototal:real;
	begin
		leer(mae,reg);
		while(reg.depto<>pepeLaConstante)do begin
			depto:=reg.depto;
			hsdepto:=0;
			monto:=0;
			while(reg.depto=depto)do begin
				division:=reg.division;
				hsdiv:=0;
				montodiv:=0;
				while((reg.depto=depto) and (reg.division = division))do begin
					num:=reg.num;
					hstotales:=0;
					montototal:=0;
					while((reg.depto = depto) and (reg.division = division) and (reg.num = num))do begin
						montototal+=vec[reg.categ].horas;
						leer(mae,reg);
					end;
					hsdiv+=montototal;
					montodiv+=montototal;
				end;
				hsdepto+=hsdiv;
				montodepto+=montodiv;
			end;
		end;
		close(mae);
	end;
	
procedure importarTexto(var txt:Text; var vec:vector);
	var
		i:integer;
		c:cat;
	begin
		reset(cat);
		for i:=1 to n do begin
			readln(carga,c.nro,c.monto);
			vec[c.nro]:=c.monto;
		end;
	close(txt);
	end;
var 
	txt:Text;
	mae:maestro;
BEGIN
	assign(mae,'ejer10maestro');
	assign(txt,'ejer10texto');
	importarTexto(txt,vec);
	corte(mae,vec);
END.

