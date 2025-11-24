library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.

entity ALU is -- Define la entidad llamada "ALU", que es la interfaz del módulo.
	generic ( n: integer:=8); -- Parámetro genérico 'n', que indica el número de bits (por defecto 8).
	port(
		 A : in std_logic_vector(n-1 downto 0); -- Entrada A, vector de n bits.
		 B : in std_logic_vector(n-1 downto 0); -- Entrada B, vector de n bits.
		 sel : in std_logic_vector(2 downto 0); -- Selector de operación, 3 bits.
		 en: in std_logic; -- Habilitación de la ALU.
		 Q : out std_logic_vector(n downto 0)); -- Salida Q, vector de n+1 bits para resultado (incluye bit de acarreo).
end ALU; -- Fin de la declaración de la entidad

architecture solve of ALU is -- Define la arquitectura llamada "solve" para la entidad "ALU".
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
	signal X: std_logic_vector(n-1 downto 0); -- Señal interna X, vector de n bits.
	begin
		 -- Aquí se implementarían las operaciones de la ALU según el selector 'sel'.
end solve; -- Fin de la arquitectura
