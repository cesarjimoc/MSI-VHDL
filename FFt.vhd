library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity FFt is -- Define la entidad para el Flip-Flop tipo T
	port(
		t,Clk,resetn: in std_logic; -- Entradas: t (toggle), Clk (reloj), resetn (reset activo bajo)
		q: buffer std_logic); -- Salida: q
end FFt;

architecture solve of FFt is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
	-- Proceso principal: Flip-Flop tipo T
	process(resetn,clk)
		begin
			if resetn='0' then -- Si resetn está activo, pone q en '0'
				q<='0'; -- Reinicia el Flip-Flop
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if t='1' then q<= not q;--<-- Toggle
				--elsif t='0' then q<=q;--<-- Hold
				end if;
			end if;
		end process;
	-- Aquí podrían ir más procesos si fueran necesarios
end solve;

-- Arquitectura solve: implementa el Flip-Flop tipo T.
-- process: secuencial, reinicia q a '0' si resetn es '0'.
-- Si t='1', q se invierte (toggle).
-- Si t='0', q mantiene su valor (Hold, comentado).
