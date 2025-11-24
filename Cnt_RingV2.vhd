library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.

entity Cnt_RingV2 is -- Define la entidad llamada "Cnt_RingV2", que es la interfaz del módulo.
   port(
	   Clk,resetn,en: in std_logic; -- Entradas: reloj, reset activo bajo, habilitación
	   q: buffer std_logic_vector(3 downto 0)); -- Salida: valor del contador tipo anillo
end Cnt_RingV2;

architecture solve of Cnt_RingV2 is -- Define la arquitectura llamada "solve" para la entidad "Cnt_RingV2".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
   -- Proceso principal: contador tipo anillo versión 2
   process(resetn,clk)
	   begin
		   if resetn='0' then -- Si el reset está activo, pone la salida en cero
			   q<=(others => '0'); -- Reinicia el contador
		   elsif clk'event and clk='1' then -- Flanco de subida del reloj
			   if en='1' then
				   case q is -- Cambia el estado del contador tipo anillo
					   when "0000" => q<="1000"; -- Activa el primer bit
					   when "1000" => q<="0100"; -- Desplaza el bit activo
					   when "0100" => q<="0010"; -- Desplaza el bit activo
					   when "0010" => q<="0001"; -- Desplaza el bit activo
					   when others => q<="0000"; -- Reinicia el contador
				   end case;
			   end if;
		   end if;
   end process;
   -- Aquí podrían ir más procesos si fueran necesarios
end solve;
