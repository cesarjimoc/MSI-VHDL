library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Mux2a1 is -- Define la entidad para el multiplexor 2 a 1
	generic ( n: integer:=4); -- Parámetro genérico 'n', número de bits
	port( A: in std_logic_vector(n-1 downto 0); -- Entrada A
		B: in std_logic_vector(n-1 downto 0); -- Entrada B
		Sel: in std_logic; -- Selección de entrada
		en: in std_logic; -- Habilitación de salida
		Q: out std_logic_vector(n-1 downto 0)); -- Salida multiplexada
end Mux2a1; -- Fin de la declaración de la entidad

architecture solve of Mux2a1 is -- Arquitectura principal
	signal f: std_logic_vector(n-1 downto 0); -- Señal interna para almacenar el dato seleccionado
	begin
		with Sel select -- Selección de entrada según Sel
			f<= A when '0', -- Si Sel='0', selecciona A
				 B when others; -- Si Sel='1', selecciona B
		Q<= f when en='1' else (others=>'0'); -- Si en='1', Q toma el valor de f; si en='0', Q se pone en cero
end solve; -- Fin de la arquitectura

-- signal f: almacena el dato seleccionado.
-- with Sel select: selecciona A si Sel='0', B si Sel='1'.
-- Q: si en='1', Q toma el valor de f; si en='0', Q se pone en cero.
