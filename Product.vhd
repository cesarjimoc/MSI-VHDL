
library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.numeric_std.all; -- Permite operaciones aritméticas con vectores de bits

entity Product is -- Define la entidad para el multiplicador
	generic ( n: integer :=4);--<------- nbits
	port(
		A,B: in std_logic_vector(n-1 downto 0); -- Entradas A y B
		clk,ResetnMult,start: in std_logic; -- Entradas de control
		q: out std_logic_vector(2*n-1 downto 0); -- Salida del producto
		fin: out std_logic); -- Salida de finalización
end Product; -- Fin de la declaración de la entidad

architecture solve of Product is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
	process(ResetnMult,clk)
		begin
			if ResetnMult='0' then -- Si ResetnMult está activo, inicializa la salida
				q<="00000000";
				fin<='0';
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if start='1' then -- Si start es '1', realiza la multiplicación
					q<=std_logic_vector(signed(A)*signed(B)); -- Multiplica A y B como signed
					fin<='1'; -- Indica que terminó
				else 
					q<="00000000";
					fin<='0';
				end if;
			end if;
	end process;
end solve; -- Fin de la arquitectura
