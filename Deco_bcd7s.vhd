library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_arith.ALL; -- Permite operaciones aritméticas con vectores de bits.
use ieee.std_logic_unsigned.ALL; -- Permite operaciones aritméticas sin signo.
 
entity Deco_bcd7s is -- Define la entidad llamada "Deco_bcd7s", que es la interfaz del módulo.
   port(
	   BCD: in std_logic_vector(3 downto 0); -- Entrada: valor BCD de 4 bits
	   SEG7: out std_logic_vector(1 to 7)); -- Salida: segmentos del display de 7 segmentos (ánodo común)
end Deco_bcd7s;

architecture solve of Deco_bcd7s is -- Define la arquitectura llamada "solve" para la entidad "Deco_bcd7s".
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
	 begin
		 SEG7 <=  "0000001"   when BCD = "0000" ELSE -- Muestra 0
			  "1001111"      when BCD = "0001" ELSE  -- Muestra 1
			  "0010010"     when BCD = "0010" ELSE  -- Muestra 2
			  "0000110"   when BCD = "0011" ELSE  -- Muestra 3
			  "1001100"   when BCD = "0100" ELSE  -- Muestra 4
			  "0100100"   when BCD = "0101" ELSE  -- Muestra 5
			  "0100000"   when BCD = "0110" ELSE  -- Muestra 6
			  "0001111"   when BCD = "0111" ELSE  -- Muestra 7
			  "0000000"   when BCD = "1000" ELSE  -- Muestra 8
			  "0000100"   when BCD = "1001" ELSE  -- Muestra 9
			  "1111111" ; -- Apaga todos los segmentos
end solve;
