library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity FFsr is -- Define la entidad para el Flip-Flop tipo SR
	port(
		s,r,Clk,resetn: in std_logic; -- Entradas: s (set), r (reset), Clk (reloj), resetn (reset activo bajo)
		q: buffer std_logic); -- Salida: q
end FFsr;

architecture solve of FFsr is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
	-- Proceso principal: Flip-Flop tipo SR
	process(resetn,clk)
		begin
			if resetn='0' then -- Si resetn está activo, pone q en '0'
				q<='0'; -- Reinicia el Flip-Flop
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if s='1' and r='0' then q<='1';--<-- Set
				elsif s='0' and r='1' then q<='0';--<-- Reset
				elsif s='0' and r='0' then q<=q;--<-- Hold
				--elsif s='1' and r='1' then -- Estado no definido
				end if;
			end if;
		end process;
	-- Aquí podrían ir más procesos si fueran necesarios
end solve;

-- Arquitectura solve: implementa el Flip-Flop tipo SR.
-- process: secuencial, reinicia q a '0' si resetn es '0'.
-- Si s='1' y r='0', q se pone en '1' (Set).
-- Si s='0' y r='1', q se pone en '0' (Reset).
-- Si s='0' y r='0', q mantiene su valor (Hold).
-- Si s='1' y r='1', estado no definido (comentado).
