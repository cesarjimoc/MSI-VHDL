library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity Cnt is -- Define la entidad llamada "Cnt", que es la interfaz del módulo.
   generic ( n: integer :=4); -- Parámetro genérico 'n', que indica el número de bits (por defecto 4).
   port(
	   Clk,resetn,en: in std_logic; -- Entradas: reloj, reset activo bajo, habilitación
	   q: buffer std_logic_vector(n-1 downto 0)); -- Salida: valor del contador
end Cnt;

architecture solve of Cnt is -- Define la arquitectura llamada "solve" para la entidad "Cnt".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
   -- Proceso principal: contador secuencial
   process(resetn,clk)
	   begin
		   if resetn='0' then -- Si el reset está activo, pone la salida en cero
			   q<=(others => '0'); -- Reinicia el contador
		   elsif clk'event and clk='1' then -- Flanco de subida del reloj
			   if en='1' then q<=q+1; -- Si está habilitado, incrementa el contador
			   end if;
		   end if;
   end process;
   -- Aquí podrían ir más procesos si fueran necesarios
end solve;
