library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity FFsd is -- Define la entidad para el Flip-Flop tipo SD
	port(
		s,d,Clk,resetn: in std_logic; -- Entradas: s (set), d (dato), Clk (reloj), resetn (reset activo bajo)
		q: buffer std_logic); -- Salida: q
end FFsd;

architecture solve of FFsd is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
	-- Proceso principal: Flip-Flop tipo SD
	process(resetn,clk)
		begin
			if resetn='0' then -- Si resetn está activo, pone q en '0'
				q<='0'; -- Reinicia el Flip-Flop
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if s='0' and d='0' then q<='1';--<-- Set
				elsif s='0' and d='1' then q<= not q;--<-- Toggle
				elsif s='1' and d='0' then q<=not q;--<-- Toggle
				elsif s='1' and d='1' then q<='0';--<-- Reset
				end if;
			end if;
		end process;
	-- Aquí podrían ir más procesos si fueran necesarios
end solve;

-- Arquitectura solve: implementa el Flip-Flop tipo SD.
-- process: secuencial, reinicia q a '0' si resetn es '0'.
-- Si s='0' y d='0', q se pone en '1' (Set).
-- Si s='0' y d='1', q se invierte (Toggle).
-- Si s='1' y d='0', q se invierte (Toggle).
-- Si s='1' y d='1', q se pone en '0' (Reset).
