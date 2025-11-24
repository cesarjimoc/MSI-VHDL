----------------------------------------------------------------------
-- File Downloaded from 
-- https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL
----------------------------------------------------------------------

library IEEE; -- Importa la librería estándar IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Importa el paquete std_logic_1164
use IEEE.NUMERIC_STD.ALL; -- Importa el paquete numeric_std para operaciones aritméticas

-- Importa la librería estándar IEEE y los paquetes necesarios para señales lógicas y operaciones aritméticas con unsigned.

entity SERVO_PWM is -- Entidad SERVO_PWM: genera señal PWM para controlar un servomotor.
    PORT (
        clk   : IN  STD_LOGIC; -- Entrada de reloj
        reset : IN  STD_LOGIC; -- Entrada de reset
        pos   : IN  STD_LOGIC_VECTOR(6 downto 0); -- Entrada de posición (7 bits)
        servo : OUT STD_LOGIC -- Salida PWM para el servomotor
    );
end SERVO_PWM; -- Fin de la declaración de la entidad

-- Entidad SERVO_PWM: genera señal PWM para controlar un servomotor. Entradas: clk, reset, pos (posición). Salida: servo.

architecture Behavioral of SERVO_PWM is -- Arquitectura Behavioral: implementa la lógica PWM para el servomotor.
    -- Counter, from 0 to 1279.
    signal cnt : unsigned(10 downto 0); -- Contador de 11 bits, cuenta de 0 a 1279 para el ciclo PWM
    -- Temporal signal used to generate the PWM pulse.
    signal pwmi: unsigned(7 downto 0); -- Señal temporal para el ancho de pulso PWM
begin
    -- Minimum value should be 0.5ms.
    pwmi <= unsigned('0' & pos) + 32; -- Calcula el ancho de pulso PWM según la posición, mínimo 0.5ms
    -- Counter process, from 0 to 1279.
    counter: process (reset, clk) begin
        if (reset = '1') then -- Si reset está activo, reinicia el contador
            cnt <= (others => '0'); -- Reinicia el contador
        elsif rising_edge(clk) then -- Flanco de subida del reloj
            if (cnt = 1279) then -- Si el contador llega a 1279, reinicia
                cnt <= (others => '0'); -- Reinicia el contador
            else
                cnt <= cnt + 1; -- Incrementa el contador
            end if;
        end if;
    end process; -- Fin del proceso de contador
    -- Output signal for the servomotor.
    servo <= '1' when (cnt < pwmi) else '0'; -- Salida PWM, activa mientras cnt < pwmi
end Behavioral; -- Fin de la arquitectura

-- Arquitectura Behavioral: implementa la lógica PWM para el servomotor.
-- signal cnt: contador de 11 bits, cuenta de 0 a 1279 para el ciclo PWM.
-- signal pwmi: calcula el ancho de pulso PWM según la posición, mínimo 0.5ms.
-- counter: proceso que reinicia el contador con reset y lo incrementa en cada flanco de reloj, reinicia al llegar a 1279.
-- servo: salida PWM, activa mientras cnt < pwmi, controla el servomotor.