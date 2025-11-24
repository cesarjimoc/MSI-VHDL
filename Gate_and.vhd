library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

-- Importa la librería estándar IEEE y el paquete para señales std_logic.

entity Gate_and is -- Define la entidad para la compuerta AND
	generic ( n: integer :=1); -- Parámetro genérico 'n', número de bits
	port(
		A,B: in std_logic_vector(n-1 downto 0); -- Entradas: A y B, vectores de n bits
		F: out std_logic_vector(n-1 downto 0)); -- Salida: F, vector de n bits
end Gate_and; -- Fin de la declaración de la entidad

-- Entidad Gate_and: compuerta AND de n bits. Parámetro n define el ancho. Entradas: A, B. Salida: F.

architecture solve of Gate_and is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
		F<= A and B; -- Realiza la operación AND bit a bit entre A y B, resultado en F
end solve; -- Fin de la arquitectura

-- Arquitectura solve: realiza la operación AND bit a bit entre A y B, resultado en F.
