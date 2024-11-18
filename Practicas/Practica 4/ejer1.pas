program ejer1;
const M=;
type
	TDato=record
		nom,ape:string;
		dni,anio,legajo;integer;
	end;
	
	TNodo = record
		cant_datos:	integer;
		datos: array[1..M-1] of TDato;
		hijos: array[1..M] of integer;
	end;
	
	//512/64=M-> M = 8
	
	arbolB=file of TNodo;
var
	archivoDatos:arbolB;
BEGIN
	//c. ¿Qué impacto tiene sobre el valor de M organizar el archivo con toda la
	//	  información de los alumnos como un árbol B?
	//   
	//	 El impacto que tiene radica en que el tamaño de N, cuanto mas tamaños menos nodos
	//   mas elementos por nodo.
	//
	//d. ¿Qué dato seleccionaría como clave de identificación para organizar los
	//	  elementos (alumnos) en el árbol B? ¿Hay más de una opción?
	//	  
	//	 Se podria seleccionar el dni o legajo del alumno.
	//
	//e. Describa el proceso de búsqueda de un alumno por el criterio de ordenamiento
	//   especificado en el punto previo. ¿Cuántas lecturas de nodos se necesitan para
	//   encontrar un alumno por su clave de identificación en el peor y en el mejor de
	//   los casos? ¿Cuáles serían estos casos?
	//
	//	 El mejor de los casos la cantidad de busquedas seria 1, estando el elemento en el nodo
	//	 raiz. El peor caso seria realizar H(altura del arbol) busquedas.
	//
	//f. ¿Qué ocurre si desea buscar un alumno por un criterio diferente? ¿Cuántas
	//   lecturas serían necesarias en el peor de los casos?
	//
	//    Usando claves univocas la cantidad de lecturas seria la misma. En el caso de usar
	//	  como criterio el nombre del alumno por ejemplo, aumentaria considerablemente el 
	//	  numero de busquedas.
END.

