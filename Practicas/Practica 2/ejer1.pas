program ejer1;
const valorAlto= 9999;

procedure compactar(var emps:empleados;var eNuevos:empleadosN);
	procedure leer(var emps:empleados;var emp:empleado);
		begin
			if(Not eof(emps))then read(emps,emp) 
			else emp.cod:=valorAlto;
		end;
	var
		total:real;
		cod:String;
		emp:Empleado;
		empN:EmpleadoN;
	begin
		reset(emps);
		assign(eNuevos,'Empleados_actualizado.txt');
		rewrite(eNuevos);
		leer(emps,emp);
		while(emp.cod<>valorAlto)do begin
			cod:= emp.cod;
			total:=0;
			while(cod == emp.cod)do begin
				total:=total + emp.comision;
				leer(emps,emp);
			end;
			empN.nombre:=emp.nombre;empN.cod:=emp.cod;empN.total:=total;
			write(eNuevo,empN);
		end;
	end;
//registro nuevo de emp
var 

BEGIN
	
	
END.

