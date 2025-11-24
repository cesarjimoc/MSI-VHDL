library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity AsubtractB is -- Define la entidad llamada "AsubtractB", que es la interfaz del módulo.
   generic ( n: integer :=4); -- Parámetro genérico 'n', que indica el número de bits (por defecto 4).
   port(
	   A,B: in std_logic_vector(n-1 downto 0); -- Entradas: A y B, cada una es un vector de n bits.
	   S: out std_logic_vector(n downto 0)); -- Salida: S, vector de n+1 bits para almacenar el resultado de la resta (incluye bit de signo/acarre).
end AsubtractB; -- Fin de la declaración de la entidad

architecture solve of AsubtractB is -- Define la arquitectura llamada "solve" para la entidad "AsubtractB".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
	   s<=('0'&A)-('0'&B); -- Resta A y B, agregando un bit extra ('0') para evitar overflow y obtener el bit de signo/acarre.
	   --s<='0'&(x+y); -- Alternativa para sumar X y Y con el bit de signo.
end solve; -- Fin de la arquitectura
