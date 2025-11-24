----------------------------------------------------------------------
-- File Downloaded from 
-- https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Importa la librería estándar IEEE y el paquete para señales std_logic.

-- Importa la librería estándar IEEE y el paquete para señales std_logic.
 
entity PWM_clk64kHz is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end PWM_clk64kHz;

-- Entidad PWM_clk64kHz: genera una señal de reloj de 64kHz a partir de clk.
-- Entradas: clk, reset.
-- Salida: clk_out.

-- Entidad PWM_clk64kHz: genera una señal de reloj de 64kHz a partir de clk. Entradas: clk, reset. Salida: clk_out.
 
architecture Behavioral of PWM_clk64kHz is
    signal temporal: STD_LOGIC;
    signal counter : integer range 0 to 780 := 0;
begin
    freq_divider: process (reset, clk) begin
        if (reset = '1') then
            temporal <= '0';
            counter  <= 0;
        elsif rising_edge(clk) then
            if (counter = 780) then
                temporal <= NOT(temporal);
                counter  <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
 
    clk_out <= temporal;
end Behavioral;

-- Arquitectura Behavioral: implementa el divisor de frecuencia.
-- signal temporal: almacena el estado del reloj dividido.
-- signal counter: cuenta los ciclos de reloj hasta 780.
-- freq_divider: proceso que reinicia el contador con reset, y alterna temporal cada 781 ciclos para generar clk_out.

-- Arquitectura Behavioral: implementa el divisor de frecuencia.
-- signal temporal: almacena el estado del reloj dividido.
-- signal counter: cuenta los ciclos de reloj hasta 780.
-- freq_divider: proceso que reinicia el contador con reset, y alterna temporal cada 781 ciclos para generar clk_out.