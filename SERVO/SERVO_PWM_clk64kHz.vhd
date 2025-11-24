----------------------------------------------------------------------
-- File Downloaded from 
-- https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL
----------------------------------------------------------------------

library IEEE; -- Importa la librería estándar IEEE
use IEEE.STD_LOGIC_1164.ALL; -- Importa el paquete std_logic_1164

-- Importa la librería estándar IEEE y el paquete para señales std_logic.

entity SERVO_PWM_clk64kHz is -- Entidad SERVO_PWM_clk64kHz: integra el divisor de frecuencia y el generador PWM para servomotor.
    PORT(
        clk  : IN  STD_LOGIC; -- Entrada de reloj
        reset: IN  STD_LOGIC; -- Entrada de reset
        pos  : IN  STD_LOGIC_VECTOR(6 downto 0); -- Entrada de posición
        servo: OUT STD_LOGIC -- Salida PWM para el servomotor
    );
end SERVO_PWM_clk64kHz; -- Fin de la declaración de la entidad

-- Entidad SERVO_PWM_clk64kHz: integra el divisor de frecuencia y el generador PWM para servomotor. Entradas: clk, reset, pos. Salida: servo.

architecture Behavioral of SERVO_PWM_clk64kHz is -- Arquitectura Behavioral: instancia los módulos PWM_clk64kHz y SERVO_PWM.
    COMPONENT PWM_clk64kHz
        PORT(
            clk    : in  STD_LOGIC; -- Entrada de reloj
            reset  : in  STD_LOGIC; -- Entrada de reset
            clk_out: out STD_LOGIC -- Salida de reloj dividida
        );
    END COMPONENT;
    
    COMPONENT SERVO_PWM
        PORT (
            clk   : IN  STD_LOGIC; -- Entrada de reloj
            reset : IN  STD_LOGIC; -- Entrada de reset
            pos   : IN  STD_LOGIC_VECTOR(6 downto 0); -- Entrada de posición
            servo : OUT STD_LOGIC -- Salida PWM para el servomotor
        );
    END COMPONENT;
    
    signal clk_out : STD_LOGIC := '0'; -- Señal de reloj dividida para el generador PWM
begin
    clk64kHz_map: PWM_clk64kHz PORT MAP(
        clk, reset, clk_out -- Instancia el divisor de frecuencia
    );
    
    servo_pwm_map: SERVO_PWM PORT MAP(
        clk_out, reset, pos, servo -- Instancia el generador PWM para el servomotor
    );
end Behavioral; -- Fin de la arquitectura

-- Arquitectura Behavioral: instancia los módulos PWM_clk64kHz y SERVO_PWM.
-- signal clk_out: señal de reloj dividida para el generador PWM.
-- clk64kHz_map: instancia el divisor de frecuencia, genera clk_out a partir de clk y reset.
-- servo_pwm_map: instancia el generador PWM para el servomotor, usa clk_out, reset y pos para generar la señal servo.