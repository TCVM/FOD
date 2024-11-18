program ejer3;
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
	
	arbolBM=file of TNodo;
	tArchivoDato=file of TDato;
var
	archivoDatos:arbolB;

BEGIN
	
	{
	* a. ¿Cómo se organizan los elementos (claves) de un árbol B+? ¿Qué elementos se
		  encuentran en los nodos internos y que elementos se encuentran en los nodos
		  hojas?
	* 
	* En los arboles B+, los nodos hoja almacenan las claves indizadas, en los nodos
	* internos hay copias de las claves separadoras, esto permite el acceso secuencial
	* de todas las claves usando solamente sus nodos hojas del arbol.
	* 
	* b. ¿Qué característica distintiva presentan los nodos hojas de un árbol B+? ¿Por
	     qué?
	   
	  Todas las claves se encuentran en las hojas y estas se vinculan para facilitar el 
	  recorrido secuencial rápido. 
	  * 
	  d. Describa, con sus palabras, el proceso de búsqueda de un alumno con un DNI
		 específico haciendo uso de la estructura auxiliar (índice) que se organiza como
		 un árbol B+. ¿Qué diferencia encuentra respecto a la búsqueda en un índice
		 estructurado como un árbol B?
		
	  El algoritmo comienza comparando con el nodo raiz, en caso de que no sea el elemento
	  buscado, continua comparando con el subarbol izquierdo o derecho dependiendo de si es
	  mayor o menor que el nodo raiz. Repite este proceso hasta llegar a un nodo hoja, a
	  partir de este punto se realiza una busqueda lineal dado que dicho nodo esta organizado
	  como una lista.
	  La diferencia radica en que las claves se encuentran almacenadas en los nodos hoja del arbol
	  en vez de tenerlos desperdigados a lo largo de todo el arbol como pasa con el B.
	  
	  e. Explique con sus palabras el proceso de búsqueda de los alumnos que tienen DNI
		 en el rango entre 40000000 y 45000000, apoyando la búsqueda en un índice
		 organizado como un árbol B+. ¿Qué ventajas encuentra respecto a este tipo de
		 búsquedas en un árbol B?
		 * 
	 El algoritmo comienza comparando el valor inicial del rango con el nodo raiz, en caso
	 de que no sea el elemento buscado, continua comparando con el subarbol izquierdo o 
	 derecho dependiendo de si es mayor o menor que el nodo raiz. Repite este proceso hasta 
	 llegar a un nodo hoja, a partir de este punto se realiza una busqueda lineal de los
	 elementos que se encuentran en el rango.
	 Las ventajas estan en que hay menos profundidad respecto a un arbol B y que al tener
	 los nodos hojas enlazados y ordenados se facilita la busqueda.
	 * 
	 * 
	 * 
	* }
END.

