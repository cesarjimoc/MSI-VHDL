----------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
----------------------------------------------------------------------
-- This file contains the UART Transmitter.  This transmitter is able
-- to transmit 8 bits of serial data, one start bit, one stop bit,
-- and no parity bit.  When transmit is complete o_TX_Done will be
-- driven high for one clock cycle.
--
-- Set Generic g_CLKS_PER_BIT as follows:
-- g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
-- Example: 10 MHz Clock, 115200 baud UART
-- (10000000)/(115200) = 87
--
library ieee; -- Importa la librería estándar IEEE para soporte de señales lógicas.
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164 para tipos lógicos.
use ieee.numeric_std.all; -- Importa el paquete numeric_std para operaciones aritméticas con enteros.

entity UART_TX is -- Declaración de la entidad UART_TX para transmisión serial.
  generic (
    g_CLKS_PER_BIT : integer := 115     -- Needs to be set correctamente
    -- Número de ciclos de reloj por bit.
    );
  port (
    i_Clk       : in  std_logic; -- Entrada de reloj principal.
    i_TX_DV     : in  std_logic; -- Señal para indicar que se va a transmitir un dato.
    i_TX_Byte   : in  std_logic_vector(7 downto 0); -- Byte de datos a transmitir.
    o_TX_Active : out std_logic; -- Salida que indica si la transmisión está activa.
    o_TX_Serial : out std_logic; -- Salida serial de datos transmitidos.
    o_TX_Done   : out std_logic -- Salida que indica que la transmisión ha terminado.
    );
end UART_TX; -- Fin de la declaración de la entidad UART_TX.

architecture RTL of UART_TX is -- Comienza la arquitectura RTL para la transmisión UART.
  type t_SM_Main is (s_Idle, s_TX_Start_Bit, s_TX_Data_Bits,
                     s_TX_Stop_Bit, s_Cleanup); -- Define los estados de la máquina de estados principal.
  signal r_SM_Main : t_SM_Main := s_Idle; -- Señal para el estado actual de la máquina de estados.
  signal r_Clk_Count : integer range 0 to g_CLKS_PER_BIT-1 := 0; -- Contador de ciclos de reloj para cada bit.
  signal r_Bit_Index : integer range 0 to 7 := 0;  -- Índice del bit actual a transmitir (0 a 7).
  signal r_TX_Data   : std_logic_vector(7 downto 0) := (others => '0'); -- Registro para almacenar el byte a transmitir.
  signal r_TX_Done   : std_logic := '0'; -- Señal que indica que la transmisión ha terminado.

begin
-- Comienza la sección de ejecución de la arquitectura.
  p_UART_TX : process (i_Clk)
    -- Proceso principal para la transmisión UART.
  begin
    if rising_edge(i_Clk) then -- Detecta el flanco de subida del reloj.
      case r_SM_Main is -- Selecciona el estado actual de la máquina de estados.
        when s_Idle => -- Estado de reposo, espera el bit de inicio y carga el byte a transmitir.
          o_TX_Active <= '0'; -- Desactiva la señal de transmisión activa.
          o_TX_Serial <= '1'; -- Línea serial en alto cuando está en reposo.
          r_TX_Done   <= '0'; -- Indica que la transmisión no ha terminado.
          r_Clk_Count <= 0; -- Reinicia el contador de ciclos de reloj.
          r_Bit_Index <= 0; -- Reinicia el índice de bit.
          if i_TX_DV = '1' then -- Si la señal de transmisión está activa...
            r_TX_Data <= i_TX_Byte; -- Carga el byte a transmitir.
            r_SM_Main <= s_TX_Start_Bit; -- Cambia al estado de transmisión de bit de inicio.
          else
            r_SM_Main <= s_Idle; -- Permanece en estado de reposo.
          end if;
        when s_TX_Start_Bit => -- Estado para transmitir el bit de inicio (start bit = 0).
          o_TX_Active <= '1'; -- Activa la señal de transmisión.
          o_TX_Serial <= '0'; -- Línea serial en bajo para el bit de inicio.
          -- Wait g_CLKS_PER_BIT-1 clock cycles for start bit to finish
          if r_Clk_Count < g_CLKS_PER_BIT-1 then -- Espera el número de ciclos de reloj para terminar el bit de inicio.
            r_Clk_Count <= r_Clk_Count + 1; -- Incrementa el contador de ciclos.
            r_SM_Main   <= s_TX_Start_Bit; -- Permanece en el estado de transmisión de bit de inicio.
          else
            r_Clk_Count <= 0; -- Reinicia el contador de ciclos.
            r_SM_Main   <= s_TX_Data_Bits; -- Cambia al estado de transmisión de bits de datos.
          end if;
        when s_TX_Data_Bits => -- Estado para transmitir los bits de datos.
          o_TX_Serial <= r_TX_Data(r_Bit_Index); -- Asigna el bit actual del byte a la línea serial.
          if r_Clk_Count < g_CLKS_PER_BIT-1 then -- Espera el número de ciclos de reloj para terminar el bit de datos.
            r_Clk_Count <= r_Clk_Count + 1; -- Incrementa el contador de ciclos.
            r_SM_Main   <= s_TX_Data_Bits; -- Permanece en el estado de transmisión de bits de datos.
          else
            r_Clk_Count <= 0; -- Reinicia el contador de ciclos.
            -- Check if we have sent out all bits
            if r_Bit_Index < 7 then -- Si no se han transmitido todos los bits...
              r_Bit_Index <= r_Bit_Index + 1; -- Incrementa el índice de bit.
              r_SM_Main   <= s_TX_Data_Bits; -- Permanece en el estado de transmisión de bits de datos.
            else
              r_Bit_Index <= 0; -- Reinicia el índice de bit.
              r_SM_Main   <= s_TX_Stop_Bit; -- Cambia al estado de transmisión de bit de parada.
            end if;
          end if;
        when s_TX_Stop_Bit => -- Estado para transmitir el bit de parada (stop bit = 1).
          o_TX_Serial <= '1'; -- Línea serial en alto para el bit de parada.
          -- Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if r_Clk_Count < g_CLKS_PER_BIT-1 then -- Espera el número de ciclos de reloj para terminar el bit de parada.
            r_Clk_Count <= r_Clk_Count + 1; -- Incrementa el contador de ciclos.
            r_SM_Main   <= s_TX_Stop_Bit; -- Permanece en el estado de transmisión de bit de parada.
          else
            r_TX_Done   <= '1'; -- Indica que la transmisión ha terminado.
            r_Clk_Count <= 0; -- Reinicia el contador de ciclos.
            r_SM_Main   <= s_Cleanup; -- Cambia al estado de limpieza.
          end if;
        when s_Cleanup => -- Estado de limpieza, permanece un ciclo y vuelve a idle.
          o_TX_Active <= '0'; -- Desactiva la señal de transmisión activa.
          r_TX_Done   <= '1'; -- Indica que la transmisión ha terminado.
          r_SM_Main   <= s_Idle; -- Vuelve al estado de reposo.
        when others => -- Estado por defecto, vuelve a idle.
          r_SM_Main <= s_Idle; -- Vuelve al estado de reposo.
      end case; -- Fin de la máquina de estados.
    end if; -- Fin del flanco de subida del reloj.
  end process p_UART_TX;
  -- Fin del proceso principal de transmisión UART.
  o_TX_Done <= r_TX_Done; -- Asigna la señal de salida o_TX_Done cuando la transmisión ha finalizado.
end RTL; -- Fin de la arquitectura RTL de transmisión UART.