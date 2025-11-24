library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity FFjk is -- Define la entidad para el flip-flop tipo JK
	port(
		j,k,Clk,resetn: in std_logic; -- Entradas de control JK, reloj y reset activo bajo
		q: buffer std_logic); -- Salida del flip-flop
end FFjk; -- Fin de la declaración de la entidad

architecture solve of FFjk is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
	-- Proceso principal: Flip-Flop tipo JK
	process(resetn,clk)
		begin
			if resetn='0' then -- Si resetn está activo, borra q
				q<='0'; -- Borra el flip-flop
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if j='1' and k='0' then q<='1';--<-- Set
				elsif j='0' and k='1' then q<='0';--<-- Reset
				elsif j='1' and k='1' then q<=not q;--<-- Toggle
				--elsif j='0' and k='0' then q<=q;--<-- Hold
				end if;
			end if;
		end process; -- Fin del proceso
	-- Aquí podrían ir más procesos si fueran necesarios
end solve; -- Fin de la arquitectura

-- process: secuencial, borra q si resetn es '0'.
-- Si j='1' y k='0', q se pone en '1' (Set).
-- Si j='0' y k='1', q se pone en '0' (Reset).
-- Si j='1' y k='1', q se invierte (Toggle).
-- Si j='0' y k='0', q mantiene su valor (Hold, comentado).
