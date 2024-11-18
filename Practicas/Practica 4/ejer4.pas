program ejer4;

procedure buscar(NRR, clave, NRR_encontrado, pos_encontrada, resultado)
	var clave_encontrada: boolean;
	begin
		if (nodo = null)
			resultado := false; {clave no encontrada}
		else
		posicionarYLeerNodo(A, nodo, NRR);
		claveEncontrada(A, nodo, clave, pos, clave_encontrada);
		if (clave_encontrada) then begin
			NRR_encontrado := NRR; { NRR actual }
			pos_encontrada := pos; { posicion dentro del array }
			resultado := true;
		end
		else
			buscar(nodo.hijos[pos], clave, NRR_encontrado, pos_encontrada,resultado)
	end;

var 

BEGIN
	{
		4. Dado el algoritmo de búsqueda en un árbol B 
		   Asuma que para la primera llamada, el parámetro NRR contiene la posición de la raíz
	       del árbol. Responda detalladamente:
			
			a. PosicionarYLeerNodo(): Indique qué hace y la forma en que deben ser
			   enviados los parámetros (valor o referencia). Implemente este módulo en Pascal.
			
			   Posiciona y lee un nodo en un arbol B. Avanza por cada subarbol comparando en
			   case de existencia. Se pasan por valor nrr y clave, lo demas por referencia
			
			b. claveEncontrada(): Indique qué hace y la forma en que deben ser enviados los
			   parámetros (valor o referencia). ¿Cómo lo implementaría?
			    
			   Devuelve True o False dependiendo de si la clave que se encuentra en el nodo 
			   posicionado corresponde con la clave enviada por parametro. A, nodo y clave se
			   pasan por valor, el resto por referencia. 
	
			c. ¿Existe algún error en este código? En caso afirmativo, modifique lo que
			   considere necesario.
			   * 
			d. ¿Qué cambios son necesarios en el procedimiento de búsqueda implementado
			   sobre un árbol B para que funcione en un árbol B+?
			   * 
			   Los cambios que se deben realizar en el manejo de nodos y la busqueda.
	}
END.

