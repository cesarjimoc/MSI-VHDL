--Multiplier of 2 numbers of n bits
-- Repository: 
-- https://github.com/vasanza/MSI-VHDL
-- Read more:
-- https://vasanza.blogspot.com
--by: Bryan Steven Espinosa

--Library
library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.numeric_std.all; -- Permite operaciones aritméticas con vectores de bits

--Entity
entity ProductV2 is -- Define la entidad para el multiplicador
    generic(N : positive :=3); -- Parámetro genérico N, número de bits
    port( a_i :  in std_logic_vector(N-1 downto 0); -- Entrada a_i
          b_i :  in std_logic_vector(N-1 downto 0); -- Entrada b_i
          clk,start : in std_logic; -- Entradas de control
          fin : out std_logic; -- Salida de finalización
          p_o : out std_logic_vector(2*N-1 downto 0) -- Salida del producto
    );
end entity ProductV2; -- Fin de la declaración de la entidad

--Architecture
architecture Arq of ProductV2 is -- Arquitectura principal
    -- Aquí se pueden declarar señales, constantes, variables, componentes
    begin
    process(start,clk)
        -- Proceso principal
        begin
            if start = '0' then -- Si start es '0', pone la salida en alta impedancia
                p_o <= "ZZZZZZ";
                fin <= '0';
            elsif (clk'event and clk='1' and start='1') then -- Flanco de subida del reloj y start activo
                p_o <= std_logic_vector(signed(a_i) * signed(b_i)); -- Multiplica a_i y b_i como signed
                fin <= '1'; -- Indica que terminó
            end if;
        end process;
        -- Fin del proceso principal
end architecture Arq; -- Fin de la arquitectura


