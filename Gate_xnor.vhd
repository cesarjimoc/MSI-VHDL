library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Gate_xnor is -- Define la entidad para la compuerta XNOR
	generic ( n: integer :=8); -- Parámetro genérico 'n', número de bits
	port(
		A,B: in std_logic_vector(n-1 downto 0); -- Entradas: A y B, vectores de n bits
		F: out std_logic_vector(n-1 downto 0)); -- Salida: F, vector de n bits
end Gate_xnor; -- Fin de la declaración de la entidad

architecture solve of Gate_xnor is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
		F<= A xnor B; -- Realiza la operación XNOR bit a bit entre A y B
end solve; -- Fin de la arquitectura

-- F: realiza la operación XNOR bit a bit entre A y B.
