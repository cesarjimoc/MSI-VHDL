library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Reg_Univ is -- Define la entidad para el registro universal
	generic(n: integer:= 4); -- Parámetro genérico 'n', número de bits
	port(
		S: in std_logic_vector(1 downto 0); -- Entrada de selección S (2 bits)
		clear,clk,L,R: in std_logic; -- Entradas: clear (borrado), clk (reloj), L (entrada izquierda), R (entrada derecha)
		P: in std_logic_vector(n-1 downto 0); -- Entrada paralela P
		Q: buffer std_logic_vector(n-1 downto 0)); -- Salida: Q, registro de n bits
end Reg_Univ; -- Fin de la declaración de la entidad

architecture solve of Reg_Univ is -- Arquitectura principal
	library ieee; -- Importa la librería estándar IEEE
	use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
	entity Reg_Univ is -- Define la entidad para el registro universal
				Q <= (others =>'0'); -- Borra el registro
	    -- Parámetro genérico 'n', número de bits
			elsif clk'event AND clk='1' then -- Flanco de subida del reloj
	        S: in std_logic_vector(1 downto 0); -- Entrada de selección S (2 bits)
					Q<= R&Q(n-1 downto 1); -- Desplaza Q a la derecha, entra R
	        clear,clk,L,R: in std_logic; -- Entradas: clear (borrado), clk (reloj), L (entrada izquierda), R (entrada derecha)
				elsif S(1)='1' AND S(0)='0' then -- S = "10": desplazamiento a la izquierda
	        P: in std_logic_vector(n-1 downto 0); -- Entrada paralela P
					Q<= Q(n-2 downto 0) & L; -- Desplaza Q a la izquierda, entra L
	        Q: buffer std_logic_vector(n-1 downto 0); -- Salida: Q, registro de n bits
	end Reg_Univ; -- Fin de la declaración de la entidad
	architecture solve of Reg_Univ is -- Arquitectura principal
			end if;
	    process (clear,clk)
	        begin
	            if clear = '0' then -- Si clear está activo, borra Q
	                Q <= (others =>'0'); -- Borra el registro
	            elsif clk'event AND clk='1' then -- Flanco de subida del reloj
	                if S(1)='0' AND S(0)='1' then -- S = "01": desplazamiento a la derecha
	                    Q<= R&Q(n-1 downto 1); -- Desplaza Q a la derecha, entra R
	                elsif S(1)='1' AND S(0)='0' then -- S = "10": desplazamiento a la izquierda
	                    Q<= Q(n-2 downto 0) & L; -- Desplaza Q a la izquierda, entra L
	                elsif S(1)='1' AND S(0)='1' then -- S = "11": carga paralela
	                    Q<= P; -- Carga paralela desde P
	                end if;
	            end if;
	        end process;
	end solve; -- Fin de la arquitectura
