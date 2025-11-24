library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity MKD2V is -- Define la entidad para el decodificador de mapa de Karnaugh de 2 variables
   port(
		MK: in std_logic_vector(3 downto 0); -- Entrada de 4 bits
		Q: out std_logic_vector(11 downto 0)); -- Salida de 12 bits (agrupada en tres bloques)
end MKD2V; -- Fin de la declaración de la entidad

architecture solve of MKD2V is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
		with MK select -- Selección según el valor de MK
			Q<= "000000000000" when "0000",--ceros
				"000000000001" when "0001"|"0010"|"0100"|"1000",-- 1 uno
				"000000000010" when "1001"|"0110",-- 2 uno
				"000000010000" when "0011"|"0101"|"1010"|"1100",-- 1 dos
				"000000100000" when "0111"|"1011"|"1101"|"1110",-- 2 dos
				"000100000000" when others;-- 1 Cuatro
end solve; -- Fin de la arquitectura

-- with MK select: selecciona el valor de Q según el valor de MK.
-- Cada valor de Q representa la cantidad de unos agrupados en el mapa de Karnaugh.

