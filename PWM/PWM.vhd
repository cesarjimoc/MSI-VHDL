----------------------------------------------------------------------
-- File Downloaded from 
-- https://community.intel.com/t5/Intel-Quartus-Prime-Software/Servomotor-PWM-and-VHDL/td-p/130784
----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

-- Importa la librería estándar IEEE y los paquetes necesarios para señales y operaciones aritméticas con vectores.

-- Importa la librería estándar IEEE y los paquetes necesarios para señales y operaciones aritméticas con vectores.
-----------------------------------------------------
entity PWM is
    port(
        clr : in std_logic;
        clk : in std_logic;
        duty : in std_logic_vector (7 downto 0);
        period : in std_logic_vector (7 downto 0);
        pwm : out std_logic
    );
end PWM;

-- Entidad PWM: genera una señal PWM.
-- Entradas: clr (reset), clk (reloj), duty (ciclo de trabajo), period (periodo).
-- Salida: pwm.

-- Entidad PWM: genera una señal PWM. Entradas: clr (reset), clk (reloj), duty (ciclo de trabajo), period (periodo). Salida: pwm.
-----------------------------------------------------
architecture Behavioral of PWM is
signal count : std_logic_vector(7 downto 0);
begin
    cnt: process(clk, clr) -- 4 bit counter
    begin
        if clr = '1' then
            count <= "00000000";
        elsif clk'event and clk = '1' then
            if count = period -1 then
                count <= "00000000";
            else
                count <= count +1;
            end if;
        end if;
    end process cnt;
    pwmout: process(count, duty)
    begin
        if count < duty then
            pwm <= '1';
        else
            pwm <= '0';
        end if;
    end process pwmout;
end Behavioral;

-- Arquitectura Behavioral: implementa la lógica PWM.
-- signal count: contador de 8 bits para el ciclo PWM.
-- cnt: proceso que incrementa el contador en cada flanco de reloj, lo reinicia con clr o cuando llega al periodo.
-- pwmout: proceso que compara el contador con el ciclo de trabajo (duty) y genera la salida PWM.

-- Arquitectura Behavioral: implementa la lógica PWM.
-- signal count: contador de 8 bits para el ciclo PWM.
-- cnt: proceso que incrementa el contador en cada flanco de reloj, lo reinicia con clr o cuando llega al periodo.
-- pwmout: proceso que compara el contador con el ciclo de trabajo (duty) y genera la salida PWM.