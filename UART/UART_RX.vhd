----------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
----------------------------------------------------------------------
-- This file contains the UART Receiver.  This receiver is able to
-- receive 8 bits of serial data, one start bit, one stop bit,
-- and no parity bit.  When receive is complete o_rx_dv will be
-- driven high for one clock cycle.
-- 
-- Set Generic g_CLKS_PER_BIT as follows:
-- g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
-- Example: 10 MHz Clock, 115200 baud UART
-- (10000000)/(115200) = 87
--
library ieee; -- Importa la librería estándar IEEE para soporte de señales lógicas.
use ieee.std_logic_1164.ALL; -- Importa el paquete std_logic_1164 para tipos lógicos.
use ieee.numeric_std.all; -- Importa el paquete numeric_std para operaciones aritméticas con enteros.

entity UART_RX is -- Declaración de la entidad UART_RX para recepción serial.
  generic (
    g_CLKS_PER_BIT : integer := 115     -- Needs to be set correctly
    -- Número de ciclos de reloj por bit.
    );
  port (
    i_Clk       : in  std_logic; -- Entrada de reloj principal.
    i_RX_Serial : in  std_logic; -- Entrada serial de datos recibidos.
    o_RX_DV     : out std_logic; -- Salida que indica que se recibió un dato válido.
    o_RX_Byte   : out std_logic_vector(7 downto 0) -- Byte de datos recibido.
    );
end UART_RX; -- Fin de la declaración de la entidad UART_RX.

architecture rtl of UART_RX is -- Comienza la arquitectura RTL para la recepción UART.
  type t_SM_Main is (s_Idle, s_RX_Start_Bit, s_RX_Data_Bits,
                     s_RX_Stop_Bit, s_Cleanup); -- Define los estados de la máquina de estados principal.
  signal r_SM_Main : t_SM_Main := s_Idle; -- Señal para el estado actual de la máquina de estados.
  signal r_RX_Data_R : std_logic := '0'; -- Registro intermedio para la señal serial recibida.
  signal r_RX_Data   : std_logic := '0'; -- Registro sincronizado para la señal serial recibida.
  signal r_Clk_Count : integer range 0 to g_CLKS_PER_BIT-1 := 0; -- Contador de ciclos de reloj para cada bit.
  signal r_Bit_Index : integer range 0 to 7 := 0;  -- Índice del bit actual a recibir (0 a 7).
  signal r_RX_Byte   : std_logic_vector(7 downto 0) := (others => '0'); -- Registro para almacenar el byte recibido.
  signal r_RX_DV     : std_logic := '0'; -- Señal que indica que se recibió un dato válido.

begin
-- Comienza la sección de ejecución de la arquitectura.
  -- Purpose: Double-register the incoming data.
  -- This allows it to be used in the UART RX Clock Domain.
  -- (It removes problems caused by metastabiliy)
  p_SAMPLE : process (i_Clk)
    -- Proceso para doble registro de la señal serial recibida.
  begin
    if rising_edge(i_Clk) then -- Detecta el flanco de subida del reloj.
      r_RX_Data_R <= i_RX_Serial; -- Primer registro de la señal serial.
      r_RX_Data   <= r_RX_Data_R; -- Segundo registro para sincronización y evitar metastabilidad.
    end if; -- Fin del flanco de subida del reloj.
  end process p_SAMPLE; -- Fin del proceso de doble registro.

  -- Purpose: Control RX state machine
  p_UART_RX : process (i_Clk)
    -- Proceso principal para la recepción UART.
  begin
    if rising_edge(i_Clk) then -- Detecta el flanco de subida del reloj.
      case r_SM_Main is -- Selecciona el estado actual de la máquina de estados.
        when s_Idle => -- Estado de reposo, espera el bit de inicio.
          r_RX_DV     <= '0'; -- Indica que no hay dato válido recibido.
          r_Clk_Count <= 0; -- Reinicia el contador de ciclos de reloj.
          r_Bit_Index <= 0; -- Reinicia el índice de bit.
          if r_RX_Data = '0' then       -- Start bit detected
            -- Si se detecta el bit de inicio (start bit = 0)...
            r_SM_Main <= s_RX_Start_Bit; -- Cambia al estado de recepción de bit de inicio.
          else
            r_SM_Main <= s_Idle; -- Permanece en estado de reposo.
          end if;
        when s_RX_Start_Bit => -- Estado de verificación del bit de inicio.
          if r_Clk_Count = (g_CLKS_PER_BIT-1)/2 then -- Si se alcanza el centro del bit de inicio...
            if r_RX_Data = '0' then -- Si el bit sigue siendo bajo, es válido.
              r_Clk_Count <= 0;  -- Reinicia el contador de ciclos.
              r_SM_Main   <= s_RX_Data_Bits; -- Cambia al estado de recepción de bits de datos.
            else
              r_SM_Main   <= s_Idle; -- Si no es válido, vuelve a reposo.
            end if;
          else
            r_Clk_Count <= r_Clk_Count + 1; -- Incrementa el contador de ciclos.
            r_SM_Main   <= s_RX_Start_Bit; -- Permanece en el estado de verificación de bit de inicio.
          end if;
        when s_RX_Data_Bits => -- Estado para recibir los bits de datos.
          if r_Clk_Count < g_CLKS_PER_BIT-1 then -- Espera el número de ciclos de reloj para terminar el bit de datos.
            r_Clk_Count <= r_Clk_Count + 1; -- Incrementa el contador de ciclos.
            r_SM_Main   <= s_RX_Data_Bits; -- Permanece en el estado de recepción de bits de datos.
          else
            r_Clk_Count            <= 0; -- Reinicia el contador de ciclos.
            r_RX_Byte(r_Bit_Index) <= r_RX_Data; -- Asigna el bit recibido al byte.
            -- Check if we have sent out all bits
            if r_Bit_Index < 7 then -- Si no se han recibido todos los bits...
              r_Bit_Index <= r_Bit_Index + 1; -- Incrementa el índice de bit.
              r_SM_Main   <= s_RX_Data_Bits; -- Permanece en el estado de recepción de bits de datos.
            else
              r_Bit_Index <= 0; -- Reinicia el índice de bit.
              r_SM_Main   <= s_RX_Stop_Bit; -- Cambia al estado de recepción de bit de parada.
            end if;
          end if;
        when s_RX_Stop_Bit => -- Estado para recibir el bit de parada (stop bit = 1).
          -- Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if r_Clk_Count < g_CLKS_PER_BIT-1 then -- Espera el número de ciclos de reloj para terminar el bit de parada.
            r_Clk_Count <= r_Clk_Count + 1; -- Incrementa el contador de ciclos.
            r_SM_Main   <= s_RX_Stop_Bit; -- Permanece en el estado de recepción de bit de parada.
          else
            r_RX_DV     <= '1'; -- Indica que se recibió un dato válido.
            r_Clk_Count <= 0; -- Reinicia el contador de ciclos.
            r_SM_Main   <= s_Cleanup; -- Cambia al estado de limpieza.
          end if;
        when s_Cleanup => -- Estado de limpieza, permanece un ciclo y vuelve a idle.
          r_SM_Main <= s_Idle; -- Vuelve al estado de reposo.
          r_RX_DV   <= '0'; -- Indica que no hay dato válido en este ciclo.
        when others => -- Estado por defecto, vuelve a idle.
          r_SM_Main <= s_Idle; -- Vuelve al estado de reposo.
      end case; -- Fin de la máquina de estados.
    end if; -- Fin del flanco de subida del reloj.
  end process p_UART_RX; -- Fin del proceso principal de recepción UART.
  o_RX_DV   <= r_RX_DV; -- Asigna la señal de salida o_RX_DV cuando se recibe un dato válido.
  o_RX_Byte <= r_RX_Byte; -- Asigna la señal de salida o_RX_Byte con el byte recibido.
end rtl; -- Fin de la arquitectura RTL de recepción UART.