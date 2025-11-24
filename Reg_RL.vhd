library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Reg_RL is  -- Define la entidad para el registro de desplazamiento derecha a izquierda
    generic (n: integer:=3); -- Parámetro genérico 'n', número de bits
    port(
		Resetn,En,Ld,L,clk : in std_logic; -- Entradas: Resetn (reset), En (habilitación), Ld (carga), L (entrada izquierda), clk (reloj)
		DataIn : in std_logic_vector(n-1 downto 0); -- Entrada de datos paralelos
      Q : buffer std_logic_vector (n-1 downto 0)); -- Salida: Q, registro de n bits
end Reg_RL;  -- Fin de la declaración de la entidad

architecture solve of Reg_RL is -- Arquitectura principal
	begin
   process (Resetn, clk)
		begin  
			if Resetn = '0' then -- Si Resetn está activo, borra Q
				Q <= (others =>'0'); -- Borra el registro
			elsif clk'event and clk='1' then -- Flanco de subida del reloj
				if En='1' and Ld='0' then -- Si habilitado y no cargando
					Q<= Q(n-2 downto 0) & L; -- Desplaza Q a la izquierda, entra L
				elsif En='1' and Ld='1' then -- Si habilitado y cargando
					Q<= DataIn; -- Carga paralela desde DataIn
				end if;
			end if; 
	end Process;
end solve;

-- Arquitectura solve: implementa el registro de desplazamiento derecha a izquierda.
-- process: secuencial, borra Q si Resetn es '0'.
-- Si En='1' y Ld='0', desplaza los bits de Q hacia la izquierda y asigna L al bit más bajo.
-- Si En='1' y Ld='1', carga DataIn en Q.
