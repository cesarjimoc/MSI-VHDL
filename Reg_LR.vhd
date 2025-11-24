library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Reg_LR is -- Define la entidad para el registro de desplazamiento izquierda a derecha
	generic (n: integer:= 3); -- Parámetro genérico 'n', número de bits
	port(
		Resetn,En,Ld,R,clk : in std_logic; -- Entradas: Resetn (reset), En (habilitación), Ld (carga), R (entrada derecha), clk (reloj)
		DataIn : in std_logic_vector(n-1 downto 0); -- Entrada de datos paralelos
		Q: buffer std_logic_vector (n-1 downto 0)); -- Salida: Q, registro de n bits
end Reg_LR; -- Fin de la declaración de la entidad

architecture solve of Reg_LR is -- Arquitectura principal
	library ieee; -- Importa la librería estándar IEEE
	use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
	entity Reg_LR is -- Define la entidad para el registro de desplazamiento izquierda a derecha
				Q <= (others =>'0'); -- Borra el registro
	    -- Parámetro genérico 'n', número de bits
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
	        Resetn,En,Ld,R,clk : in std_logic; -- Entradas: Resetn (reset), En (habilitación), Ld (carga), R (entrada derecha), clk (reloj)
					for i in 0 to n-2 loop -- Bucle para desplazar los bits
	        DataIn : in std_logic_vector(n-1 downto 0); -- Entrada de datos paralelos
						Q(i)<= Q(i+1); -- Desplaza Q a la derecha
	        Q: buffer std_logic_vector (n-1 downto 0); -- Salida: Q, registro de n bits
	end Reg_LR; -- Fin de la declaración de la entidad
	architecture solve of Reg_LR is -- Arquitectura principal
					Q<= DataIn; -- Carga paralela desde DataIn
	    process (Resetn, clk)
	        begin 
	            if resetn = '0' then -- Si Resetn está activo, borra Q
	                Q <= (others =>'0'); -- Borra el registro
	            elsif clk'event and clk='1' then -- Flanco de subida del reloj
	                if en='1' and ld='0' then -- Si habilitado y no cargando
	                    for i in 0 to n-2 loop -- Bucle para desplazar los bits
	                        Q(i)<= Q(i+1); -- Desplaza Q a la derecha
	                    end loop;
	                    Q(n-1)<= R; -- Asigna R al bit más alto
	                elsif en='1' and ld='1' then -- Si habilitado y cargando
	                    Q<= DataIn; -- Carga paralela desde DataIn
	                end if;
	            end if;
	        end process;
	end solve; -- Fin de la arquitectura
