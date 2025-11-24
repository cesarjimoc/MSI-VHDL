library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits

-- Importa la librería estándar IEEE y los paquetes necesarios para señales lógicas y operaciones aritméticas con vectores.

entity Subtract1 is -- Define la entidad para el módulo de resta
	generic ( n: integer :=8); -- Parámetro genérico 'n', número de bits
	port(
		X: in std_logic_vector(n-1 downto 0); -- Entrada: X, vector de n bits
		S: out std_logic_vector(n downto 0)); -- Salida: S, vector de n+1 bits para almacenar el resultado (incluye bit de signo)
end Subtract1; -- Fin de la declaración de la entidad

-- Entidad Subtract1: resta 1 a un número de n bits. Entrada: X. Salida: S (resultado con bit de signo).

architecture solve of Subtract1 is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
		s<='0'&(x-1); -- Resta 1 al valor de X y agrega un bit extra ('0') para el bit de signo
end solve; -- Fin de la arquitectura

-- Arquitectura solve: realiza la resta de 1 a X y concatena un bit de signo '0' al resultado.
