program ejer12;
const pepeLaConstante=9999;
type
	log=record
		nro,cant:integer;
		user,nom,ape:string;
	end;
	
	logDet=record
		nro,dest,msg:string;
	end;
	maestro=file of log;
	detalle=file of logDet;
procedure leer(var det:detalle;var reg:logDet);
	begin
		if(not eof(det))then
			read(det,reg);
		else
			reg.nro:=pepeLaConstante;
	end;
procedure corte(var mae:maestro;var det:detalle);
	var
		nro,total:integer;
		reg:logDet;
		regm:log;
	begin
		reset(mae);
		reset(det);
		leer(det,reg);
		while(logDet.nro<>pepeLaConstante)do begin //recorro los regs de usuarioDetalle
			reg.nro:=nro;
			total:=0;
			while(reg.nro=nro)do begin
				total++; //ordenado por num de user. Acumula mensajes de cada user en particular
				leer(det,reg);
			end;
			read(mae,regm); //leer primer reg de maestro
			while(reg.nro<>regm.nro)do read(mae,regm); //busco usuario en maestro  
			seek(mae,filepos(mae)-1); //cuando lo encuentro busco al ultimo leido
			regm.cant+=total;//sumo la cantidad de msgs con el total acumulado
			write(mae,regm); //Actualizo entrada del usuario en el maestro
		end;
		close(det);
		close(mae);
	end;
procedure exportarTexto(var mae:maestro;var txt:Text);
	var
		reg:log;
	begin
		reset(mae);
		rewrite(txt);
		while(not eof(mae))do begin
			read(mae,reg);
			write(txt,reg.nro,'.....',reg.cant);
		end;
		writeln('SE EXPORTO CON EXITO');
		close(txt);
		close(mae);
	end;
var 
	mae:maestro;
	det:detalle;
	txt:Text;
BEGIN
	assign(mae,'/var/log/logmail.dat');
	assign(det,'ejer12det');
	assign(txt,'informe.txt');
	corte(mae,det);
	exportarTexto(mae,txt);
END.

