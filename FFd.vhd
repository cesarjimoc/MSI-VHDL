library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity FFd is -- Define la entidad para el Flip-Flop tipo D
	port(
		d,Clk,resetn: in std_logic; -- Entradas: d (dato), Clk (reloj), resetn (reset activo bajo)
		q: out std_logic); -- Salida: q
end FFd;

architecture solve of FFd is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
	-- Proceso principal: Flip-Flop tipo D
	process(resetn,clk)
		begin
			if resetn='0' then -- Si resetn está activo, pone q en '0'
				q<='0'; -- Reinicia el Flip-Flop
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				q<=d; -- Asigna el valor de d a q
			end if;
		end process;
	-- Aquí podrían ir más procesos si fueran necesarios
end solve;

-- Arquitectura solve: implementa el Flip-Flop tipo D.
-- process: secuencial, reinicia q a '0' si resetn es '0', de lo contrario asigna d a q en flanco de subida de clk.

