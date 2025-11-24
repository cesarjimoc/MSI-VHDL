library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Comparador_3in is -- Define la entidad para el comparador de tres entradas
   generic ( n: integer :=4); -- Parámetro genérico 'n', número de bits
   port(
	   A,B,C: in std_logic_vector(n-1 downto 0); -- Entradas: A, B, C, vectores de n bits
	   AmayorB, AmayorC, BmayorC: out std_logic; -- Salidas: comparaciones de mayor
	   AigualB, AigualC, BigualC: out std_logic; -- Salidas: comparaciones de igualdad
	   AmenorB, AmenorC, BmenorC: out std_logic); -- Salidas: comparaciones de menor
end Comparador_3in; -- Fin de la declaración de la entidad

-- Entidad Comparador_3in: compara tres vectores de n bits. Entradas: A, B, C. Salidas: señales de mayor, igual y menor entre cada par.

architecture solve of Comparador_3in is -- Arquitectura principal
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
	   AmayorB<='1' when A>B else '0'; -- A mayor que B
	   AmayorC<='1' when A>C else '0'; -- A mayor que C
	   BmayorC<='1' when B>C else '0'; -- B mayor que C
       
	   AigualB<='1' when A=B else '0'; -- A igual a B
	   AigualC<='1' when A=C else '0'; -- A igual a C
	   BigualC<='1' when B=C else '0'; -- B igual a C
       
	   AmenorB<='1' when A<B else '0'; -- A menor que B
	   AmenorC<='1' when A<C else '0'; -- A menor que C
	   BmenorC<='1' when B<C else '0'; -- B menor que C
end solve; -- Fin de la arquitectura

-- Arquitectura solve: implementa la lógica de comparación entre tres entradas.
-- AmayorB, AmayorC, BmayorC: señales que indican si una entrada es mayor que otra.
-- AigualB, AigualC, BigualC: señales que indican si dos entradas son iguales.
-- AmenorB, AmenorC, BmenorC: señales que indican si una entrada es menor que otra.
