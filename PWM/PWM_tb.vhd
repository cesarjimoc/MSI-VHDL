----------------------------------------------------------------------
-- File Downloaded from 
-- https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL
----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

-- Importa la librería estándar IEEE y los paquetes necesarios para señales y operaciones aritméticas con vectores.

-- Importa la librería estándar IEEE y los paquetes necesarios para señales y operaciones aritméticas con vectores.

entity PWM_tb is
    port(
        clr : in std_logic;
        clk : in std_logic;
        duty : in std_logic_vector (7 downto 0);
        pwm : out std_logic
    );
end PWM_tb;

-- Entidad PWM_tb: banco de pruebas para el módulo PWM.
-- Entradas: clr, clk, duty.
-- Salida: pwm.

-- Entidad PWM_tb: banco de pruebas para el módulo PWM. Entradas: clr, clk, duty. Salida: pwm.
-----------------------------------------------------
architecture Behavioral of PWM_tb is
signal new_clock : std_logic;
begin
clk_div: entity work.clk64kHz
        port map(
            clk => clk, reset => '0', clk_out => new_clock);
Pulse: entity work.pwm
        port map(
            clr => clr, clk => new_clock, duty => duty, period => "11001000", pwm => pwm);            
            
end Behavioral;

-- Arquitectura Behavioral: instancia los módulos clk64kHz y pwm.
-- signal new_clock: señal de reloj dividida para PWM.
-- clk_div: instancia el divisor de frecuencia, genera new_clock a partir de clk.
-- Pulse: instancia el generador PWM, usa new_clock, clr, duty y periodo fijo para generar la señal pwm.

-- Arquitectura Behavioral: instancia los módulos clk64kHz y pwm.
-- signal new_clock: señal de reloj dividida para PWM.
-- clk_div: instancia el divisor de frecuencia, genera new_clock a partir de clk.
-- Pulse: instancia el generador PWM, usa new_clock, clr, duty y periodo fijo para generar la señal pwm.