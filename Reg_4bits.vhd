library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Reg_4bits is -- Define la entidad para el registro de 4 bits
	port(
		Clk,resetn,en: in std_logic; -- Entradas: Clk (reloj), resetn (reset activo bajo), en (habilitación)
		d3,d2,d1,d0: in std_logic; -- Entradas de datos individuales
		q3,q2,q1,q0: out std_logic); -- Salidas individuales del registro
end Reg_4bits; -- Fin de la declaración de la entidad

architecture solve of Reg_4bits is -- Arquitectura principal
	signal d,q: std_logic_vector(3 downto 0); -- Señales internas para entrada y registro
	begin
	d<=d3&d2&d1&d0; -- Forma el vector de entrada d a partir de d3-d0
	process(resetn,clk)
		begin
			if resetn='0' then -- Si resetn está activo, borra q
				q<="0000"; -- Borra el registro
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if en='1' then -- Si habilitado
					q<=d; -- Carga d en q
				end if;
			end if;
		end process;
	q3<=q(3);q2<=q(2);q1<=q(1);q0<=q(0); -- Asigna cada bit de q a las salidas individuales
end solve;

-- Arquitectura solve: implementa el registro de 4 bits.
-- signal d: vector de entrada formado por d3-d0.
-- process: secuencial, borra q si resetn es '0', de lo contrario carga d en q si en es '1' en flanco de subida de clk.
-- Asigna cada bit de q a las salidas q3, q2, q1, q0.
