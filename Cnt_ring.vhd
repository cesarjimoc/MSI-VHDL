library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.

entity Cnt_ring is -- Define la entidad llamada "Cnt_ring", que es la interfaz del módulo.
   port(
	   Clk,resetn,en: in std_logic; -- Entradas: reloj, reset activo bajo, habilitación
	   q: buffer std_logic_vector(3 downto 0)); -- Salida: valor del contador tipo anillo
end Cnt_ring;

architecture solve of Cnt_ring is -- Define la arquitectura llamada "solve" para la entidad "Cnt_ring".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   signal temp: std_logic; -- Señal temporal para el bit de entrada del anillo
   begin
   -- Proceso #1: genera el bit de entrada del anillo
   temp <= not(q(3) or q(2) or q(1) or q(0)); -- Si todos los bits son 0, temp será 1, de lo contrario será 0
   process(resetn,clk)
	   begin
		   if resetn='0' then -- Si el reset está activo, pone la salida en cero
			   q<=(others => '0'); -- Reinicia el contador
		   elsif clk'event and clk='1' then -- Flanco de subida del reloj
			   if en='1' then
				   q<= temp&q(3 downto 1); -- Desplaza los bits y coloca temp en la posición más baja
			   end if;
		   end if;
   end process;
   -- Aquí podrían ir más procesos si fueran necesarios
end solve;
