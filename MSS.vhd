library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity MSS is -- Define la entidad para la máquina de estados secuencial
	port(
		resetn,clk,d,n: in std_logic; -- Entradas: resetn, clk, d, n
		est: out std_logic_vector(2 downto 0); -- Salida de estado
		c: out std_logic); -- Salida de control
end MSS; -- Fin de la declaración de la entidad

architecture solve of MSS is -- Arquitectura principal
	type estado is (s1,s2,s3,s4,s5); -- Tipo de datos para los estados
	signal y: estado; -- Señal para almacenar el estado actual
	begin
	process(resetn,clk)
		begin
			if resetn = '0' then y<= s1; -- Si resetn está activo, estado inicial s1
			elsif (clk'event and clk = '1') then -- Flanco de subida del reloj
				case y is
					when s1 => 
						if d='0' and n='0' then y <= s1; -- Permanece en s1
						elsif d='0' and n='1' then y <= s3; -- Va a s3
						elsif d='1' and n='0' then y <= s2; -- Va a s2
						else y <= s1; end if; -- Permanece en s1
					when s2 => 
						if d='0' and n='0' then y <= s2; -- Permanece en s2
						elsif d='0' and n='1' then y <= s4; -- Va a s4
						elsif d='1' and n='0' then y <= s5; -- Va a s5
						else y <= s2; end if; -- Permanece en s2
					when s3 => 
						if d='0' and n='0' then y <= s3; -- Permanece en s3
						elsif d='0' and n='1' then y <= s2; -- Va a s2
						elsif d='1' and n='0' then y <= s4; -- Va a s4
						else y <= s3; end if; -- Permanece en s3
					when s4 => y <= s1; -- Va a s1
					when s5 => y <= s3; -- Va a s3
				end case;
			end if;
		end process; -- Fin del proceso de estados
	process(y)
		begin
			c<='0'; -- Inicializa la salida c
			case y is
				when s1 => est<="001"; -- Estado s1
				when s2 => est<="010"; -- Estado s2
				when s3 => est<="011"; -- Estado s3
				when s4 => c<='1';est<="100"; -- Estado s4, activa c
				when s5 => c<='1';est<="101"; -- Estado s5, activa c
			end case;
		end process; -- Fin del proceso de salidas
end solve; -- Fin de la arquitectura

-- Arquitectura solve: implementa la máquina de estados secuencial.
-- type estado: define los estados posibles.
-- signal y: almacena el estado actual.
-- process(resetn,clk): decodifica el siguiente estado y almacena el estado actual.
-- process(y): decodifica las salidas según el estado actual.
