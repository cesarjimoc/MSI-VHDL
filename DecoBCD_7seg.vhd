library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.

entity DecoBCD_7seg is -- Define la entidad llamada "DecoBCD_7seg", que es la interfaz del módulo.
   port(
	   BCD: in std_logic_vector(3 downto 0); -- Entrada: valor BCD de 4 bits
	   anodo7: out std_logic_vector(6 downto 0)); -- Salida: segmentos del display de 7 segmentos
end DecoBCD_7seg;

architecture solve of DecoBCD_7seg is -- Define la arquitectura llamada "solve" para la entidad "DecoBCD_7seg".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
   -- Proceso principal: decodificador BCD a display de 7 segmentos
   process(BCD)
	   begin
		   case BCD is -- Selecciona el valor de BCD y asigna el patrón de segmentos
			   when "0000" => anodo7<="1111110"; -- Muestra 0
			   when "0001" => anodo7<="0110000"; -- Muestra 1
			   when "0010" => anodo7<="1101101"; -- Muestra 2
			   when "0011" => anodo7<="1111001"; -- Muestra 3
			   when "0100" => anodo7<="0110011"; -- Muestra 4
			   when "0101" => anodo7<="1011011"; -- Muestra 5
			   when "0110" => anodo7<="0011111"; -- Muestra 6
			   when "0111" => anodo7<="1110000"; -- Muestra 7
			   when "1000" => anodo7<="1111111"; -- Muestra 8
			   when "1001" => anodo7<="1110011"; -- Muestra 9
			   when others => anodo7<="0000000"; -- Apaga todos los segmentos
		   end case;
   end process;
   -- Aquí podrían ir más procesos si fueran necesarios
end solve;
