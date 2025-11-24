--N-bit single or gate -- Compuerta OR de n bits
-- Repository:  -- Repositorio de origen
-- https://github.com/vasanza/MSI-VHDL -- Enlace al repositorio
-- Read more: -- Más información
-- https://vasanza.blogspot.com -- Enlace al blog

--Library -- Librería
library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

--Entity -- Entidad
entity Gate_or is -- Define la entidad para la compuerta OR
	generic ( n: integer :=1); -- Parámetro genérico 'n', número de bits
	port(
		A,B: in std_logic_vector(n-1 downto 0); -- Entradas: A y B, vectores de n bits
		F: out std_logic_vector(n-1 downto 0)); -- Salida: F, vector de n bits
end Gate_or; -- Fin de la declaración de la entidad

--Architecture -- Arquitectura
architecture solve of Gate_or is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
		F<= A or B; -- Realiza la operación OR bit a bit entre A y B, resultado en F
end solve; -- Fin de la arquitectura
