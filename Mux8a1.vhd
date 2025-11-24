library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Mux8a1 is -- Define la entidad para el multiplexor 8 a 1
	generic ( n: integer:=4); -- Parámetro genérico 'n', número de bits
	port(
		A : in std_logic_vector(n-1 downto 0); -- Entrada A
		B : in std_logic_vector(n-1 downto 0); -- Entrada B
		C : in std_logic_vector(n-1 downto 0); -- Entrada C
		D : in std_logic_vector(n-1 downto 0); -- Entrada D
		E : in std_logic_vector(n-1 downto 0); -- Entrada E
		F : in std_logic_vector(n-1 downto 0); -- Entrada F
		G : in std_logic_vector(n-1 downto 0); -- Entrada G
		H : in std_logic_vector(n-1 downto 0); -- Entrada H
		sel : in std_logic_vector(2 downto 0); -- Selección de entrada (3 bits)
		en: in std_logic; -- Habilitación de salida
		Q : out std_logic_vector(n-1 downto 0)); -- Salida multiplexada
end Mux8a1; -- Fin de la declaración de la entidad

architecture solve of Mux8a1 is -- Arquitectura principal
	signal X: std_logic_vector(n-1 downto 0); -- Señal interna para almacenar el dato seleccionado
	begin
		with sel select -- Selección de entrada según sel
			X<= A when "000", -- Si sel="000", selecciona A
				 B when "001", -- Si sel="001", selecciona B
				 C when "010", -- Si sel="010", selecciona C
				 D when "011", -- Si sel="011", selecciona D
				 E when "100", -- Si sel="100", selecciona E
				 F when "101", -- Si sel="101", selecciona F
				 G when "110", -- Si sel="110", selecciona G
				 H when others; -- Si sel es otro valor, selecciona H
		Q<= X when en='1' else (others=>'0'); -- Si en='1', Q toma el valor de X; si en='0', Q se pone en cero
end solve; -- Fin de la arquitectura

-- signal X: almacena el dato seleccionado.
-- with sel select: selecciona entre A-H según el valor de sel.
-- Q: si en='1', Q toma el valor de X; si en='0', Q se pone en cero.
