----------------------------------------------------------------------
-- File Downloaded from 
-- https://www.codeproject.com/Articles/513169/Servomotor-Control-with-PWM-and-VHDL
----------------------------------------------------------------------
LIBRARY ieee; -- Importa la librería estándar IEEE
USE ieee.std_logic_1164.ALL; -- Importa el paquete std_logic_1164

-- Importa la librería estándar IEEE y el paquete para señales std_logic.

ENTITY SERVO_PWM_clk64kHz_tb IS -- Entidad de banco de pruebas para SERVO_PWM_clk64kHz.
END SERVO_PWM_clk64kHz_tb; -- Fin de la declaración de la entidad

-- Entidad de banco de pruebas para SERVO_PWM_clk64kHz.

ARCHITECTURE behavior OF SERVO_PWM_clk64kHz_tb IS -- Arquitectura behavior: banco de pruebas para SERVO_PWM_clk64kHz.
    -- Unit under test.
    COMPONENT SERVO_PWM_clk64kHz
        PORT(
            clk   : IN  std_logic; -- Entrada de reloj
            reset : IN  std_logic; -- Entrada de reset
            pos   : IN  std_logic_vector(6 downto 0); -- Entrada de posición
            servo : OUT std_logic -- Salida PWM para el servomotor
        );
    END COMPONENT;

    -- Inputs.
    signal clk  : std_logic := '0'; -- Señal de reloj para simulación
    signal reset: std_logic := '0'; -- Señal de reset para simulación
    signal pos  : std_logic_vector(6 downto 0) := (others => '0'); -- Señal de posición para simulación
    -- Outputs.
    signal servo : std_logic; -- Señal de salida del módulo bajo prueba
    -- Clock definition.
    constant clk_period : time := 10 ns; -- Periodo de reloj para simulación
BEGIN
    -- Instance of the unit under test.
    uut: SERVO_PWM_clk64kHz PORT MAP (
        clk => clk,
        reset => reset,
        pos => pos,
        servo => servo
    ); -- Instancia el módulo bajo prueba

   -- Definition of the clock process.
   clk_process :process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process; -- Proceso para generar el reloj de simulación
 
    -- Stimuli process.
    stimuli: process begin
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        wait for 50 ns;
        pos <= "0000000";
        wait for 20 ms;
        pos <= "0101000";
        wait for 20 ms;
        pos <= "1010000";
        wait for 20 ms;
        pos <= "1111000";
        wait for 20 ms;
        pos <= "1111111";
        wait;
    end process; -- Proceso que aplica diferentes valores de posición y reset para probar el comportamiento del módulo
END; -- Fin de la arquitectura

-- Arquitectura behavior: banco de pruebas para SERVO_PWM_clk64kHz.
-- COMPONENT: instancia el módulo bajo prueba.
-- signal clk, reset, pos: señales de entrada para la simulación.
-- signal servo: salida del módulo bajo prueba.
-- clk_process: genera el reloj de simulación.
-- stimuli: proceso que aplica diferentes valores de posición y reset para probar el comportamiento del módulo.