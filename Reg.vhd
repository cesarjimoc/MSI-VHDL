library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Reg is -- Define la entidad para el registro
	generic ( n: integer :=8); -- Parámetro genérico 'n', número de bits
	port(
		Clk,resetn,en: in std_logic; -- Entradas: Clk (reloj), resetn (reset activo bajo), en (habilitación)
		d: in std_logic_vector(n-1 downto 0); -- Entrada de datos d
		q: out std_logic_vector(n-1 downto 0)); -- Salida: q, registro de n bits
end Reg; -- Fin de la declaración de la entidad

architecture solve of Reg is -- Arquitectura principal
	begin
	process(resetn,clk)
		begin
			if resetn='0' then -- Si resetn está activo, borra q
				q<=(others => '0'); -- Borra el registro
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if en='1' then -- Si habilitado
					q<=d; -- Carga d en q
				end if;
			end if;
		end process;
end solve;

-- Arquitectura solve: implementa el registro de n bits.
-- process: secuencial, borra q si resetn es '0', de lo contrario carga d en q si en es '1' en flanco de subida de clk.

