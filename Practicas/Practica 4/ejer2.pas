program ejer2;
const M=;
type
	TDato=record
		nom,ape:string;
		dni,anio,legajo;integer;
	end;
	
	TNodo=record
		cant_claves=integer;
		claves:array[1..M-1]of longint;
		enlaces:array[1..M]of integer;
		hijos:array[1..M]of integer;
	end;
	
	//512=(M-1) * 64 + M * (M-1) + 4 -> 512=65M -60-> 572/65=M -> 8,8=M
	
	arbolB=file of TNodo;
	tArchivoDato=file of TDato;
var
	archivoDatos:arbolB;
BEGIN	
	{
		c. ¿Qué implica que el orden del árbol B sea mayor que en el caso del ejercicio 1?
		* El arbol es mas chato, cada nodo puede almacenar mas elementos.
		d. Describa con sus palabras el proceso para buscar el alumno con el DNI 12345678
		   usando el índice definido en este punto. 
		   * 
		   El algoritmo comienza comparando con el nodo raiz, en caso de que no sea el elemento
		   buscado, continua comparando con el subarbol izquierdo o derecho dependiendo de si es
		   mayor o menor que el nodo raiz. Repite este proceso hasta encontrar el elemento o
		   llegar a un nodo hoja que no sea el elemento buscado.
		   * 
		e. ¿Qué ocurre si desea buscar un alumno por su número de legajo? ¿Tiene sentido
			usar el índice que organiza el acceso al archivo de alumnos por DNI? ¿Cómo
			haría para brindar acceso indizado al archivo de alumnos por número de legajo?
			*
			Dada la estructura actual del arbol, la cual esta organizada por dni, si se intenta
			buscar usando numero de legajo no se encontrara ningun nodo o uno incorrecto.
			Tiene sentido usar el DNI como clave organizadora ya que es univoco.
			Intercambiaria el criterio que organiza la estructura del arbol por el legajo.
		
		f. Suponga que desea buscar los alumnas que tienen DNI en el rango entre
		   40000000 y 45000000. ¿Qué problemas tiene este tipo de búsquedas con apoyo
		   de un árbol B que solo provee acceso indizado por DNI al archivo de alumnos?
		   * 
		   Las busquedas por rango son costosas ya que requeriria encontrar el primer valor del 
		   rango y luego a partir de ahi hace recorridos en profundidad buscando cada uno de los
		   valores dentro del arbol. Es una busqueda ineficiente.
	}
END.

