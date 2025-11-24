library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.std_logic_arith.all; -- Permite operaciones aritméticas
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas sin signo

entity RAM is -- Define la entidad para la memoria RAM
    generic(n: integer:=8; -- n-bits por dato
            m: integer:=2); -- m-bits de direcciones
    port(
        clk,wr: in std_logic; -- Entradas: clk (reloj), wr (escritura)
        addr : in std_logic_vector(m-1 downto 0); -- Entrada de dirección
        Din : in std_logic_vector(n-1 downto 0); -- Entrada de datos
        Dout : out std_logic_vector(n-1 downto 0) -- Salida de datos
    );
end RAM; -- Fin de la declaración de la entidad

architecture solve of RAM is -- Arquitectura principal
    type ram_type is array (0 to (2**m)-1) of std_logic_vector(n-1 downto 0); -- Tipo de datos para la memoria
    signal tmp_ram: ram_type; -- Señal para la memoria
    begin
    process(clk,wr)
        -- Proceso principal
        begin 
            if (clk'event and clk='1') then -- Flanco de subida del reloj
                if wr='1' then -- Si wr es '1', escribe en la memoria
                    tmp_ram(conv_integer(addr)) <= Din; -- Escribe Din en la dirección addr
                end if; 
            end if; 
        end process; 
    Dout <= tmp_ram(conv_integer(addr)); -- Lee el valor almacenado en la dirección addr
end solve; -- Fin de la arquitectura
