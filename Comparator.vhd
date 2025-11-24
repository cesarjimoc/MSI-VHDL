library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.

entity Comparator is -- Define la entidad llamada "Comparator", que es la interfaz del módulo.
   generic ( n: integer :=4); -- Parámetro genérico 'n', que indica el número de bits (por defecto 4).
   port(
	   A: in std_logic_vector(n-1 downto 0); -- Entrada: A, vector de n bits.
	   B: in std_logic_vector(n-1 downto 0); -- Entrada: B, vector de n bits.
	   AmenorB, AmayorB, AigualB: out std_logic); -- Salidas: comparaciones menor, mayor, igual
end Comparator;

architecture solve of Comparator is -- Define la arquitectura llamada "solve" para la entidad "Comparator".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
	   AmenorB<='1' when A<B else '0'; -- A menor que B
	   AmayorB<='1' when A>B else '0'; -- A mayor que B
	   AigualB<='1' when A=B else '0'; -- A igual a B
end solve;
