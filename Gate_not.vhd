--N-bit single port inverter -- Inversor de n bits, puerto único
-- Repository:  -- Repositorio de origen
-- https://github.com/vasanza/MSI-VHDL -- Enlace al repositorio
-- Read more: -- Más información
-- https://vasanza.blogspot.com -- Enlace al blog

--Library -- Librería
library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

--Entity -- Entidad
entity Gate_not is -- Define la entidad para el inversor
	generic ( n: integer :=1); -- Parámetro genérico 'n', número de bits
	port(
		X: in std_logic_vector(n-1 downto 0); -- Entrada: X, vector de n bits
		S: out std_logic_vector(n-1 downto 0)); -- Salida: S, vector de n bits
end Gate_not; -- Fin de la declaración de la entidad

--Architecture -- Arquitectura
architecture solve of Gate_not is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
		s<=not(X); -- Realiza la operación NOT bit a bit sobre X, resultado en S
end solve; -- Fin de la arquitectura
