library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.

entity Deco3to8 is -- Define la entidad llamada "Deco3to8", que es la interfaz del módulo.
   port (
	   sel : in std_logic_vector(2 downto 0); -- Entrada: selector de 3 bits
	   en: in std_logic; -- Entrada: habilitación
	   Q : out std_logic_vector(7 downto 0)); -- Salida: decodificación de 8 bits
end Deco3to8;

architecture solve of Deco3to8 is -- Define la arquitectura llamada "solve" para la entidad "Deco3to8".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   signal f: std_logic_vector(7 downto 0); -- Señal interna para decodificación
   begin
	   with sel select  -- Decodifica el selector de 3 bits en una salida de 8 bits
	   f<= "00000001" when "000", -- Activa el bit 0
			"00000010" when "001", -- Activa el bit 1
			"00000100" when "010", -- Activa el bit 2
			"00001000" when "011", -- Activa el bit 3
			"00010000" when "100", -- Activa el bit 4
			"00100000" when "101", -- Activa el bit 5
			"01000000" when "110", -- Activa el bit 6
			"10000000" when others; -- Activa el bit 7 para cualquier otro valor
	   Q<= f when en='1' else (others=>'0'); -- Si está habilitado, Q toma el valor de f, si no, Q es todo ceros
end solve;
