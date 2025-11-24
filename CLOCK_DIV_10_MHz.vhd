
LIBRARY IEEE; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
USE IEEE.STD_LOGIC_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
USE IEEE.STD_LOGIC_ARITH.all; -- Permite operaciones aritméticas con vectores de bits.
USE IEEE.STD_LOGIC_UNSIGNED.all; -- Permite operaciones aritméticas sin signo.

ENTITY CLOCK_DIV_10_MHz IS -- Define la entidad para el divisor de reloj.
    PORT
    (  CLOCK_10MHz     :IN   STD_LOGIC; -- Entrada: reloj de 10 MHz
       CLOCK_1MHz     :OUT  STD_LOGIC; -- Salida: reloj de 1 MHz
       CLOCK_100KHz   :OUT  STD_LOGIC; -- Salida: reloj de 100 KHz
       CLOCK_10KHz    :OUT  STD_LOGIC; -- Salida: reloj de 10 KHz
       CLOCK_1KHz     :OUT  STD_LOGIC; -- Salida: reloj de 1 KHz
       CLOCK_100Hz    :OUT  STD_LOGIC; -- Salida: reloj de 100 Hz
       CLOCK_10Hz     :OUT  STD_LOGIC; -- Salida: reloj de 10 Hz
       CLOCK_1Hz      :OUT  STD_LOGIC); -- Salida: reloj de 1 Hz
END CLOCK_DIV_10_MHz;

ARCHITECTURE a OF CLOCK_DIV_10_MHz IS -- Define la arquitectura para el divisor de reloj.
    SIGNAL   count_1Mhz: STD_LOGIC_VECTOR(3 DOWNTO 0); -- Contador para dividir a 1 MHz
    SIGNAL   count_100Khz, count_10Khz, count_1Khz: STD_LOGIC_VECTOR(2 DOWNTO 0); -- Contadores para dividir a 100 KHz, 10 KHz y 1 KHz
    SIGNAL   count_100hz, count_10hz, count_1hz: STD_LOGIC_VECTOR(2 DOWNTO 0); -- Contadores para dividir a 100 Hz, 10 Hz y 1 Hz
    SIGNAL   clock_1Mhz_int, clock_100Khz_int, clock_10Khz_int, clock_1Khz_int: STD_LOGIC; -- Señales internas de reloj
    SIGNAL   clock_100hz_int, clock_10hz_int, clock_1hz_int: STD_LOGIC; -- Señales internas de reloj

BEGIN
	-- Signals,Constants,Variables,Components
    PROCESS -- Proceso principal para dividir el reloj de 10 MHz
    BEGIN
	-- Divide by 10
       WAIT UNTIL clock_10Mhz'EVENT and clock_10Mhz = '0';  -- 10 Mhz
          IF count_1Mhz < 9 THEN
             count_1Mhz <= count_1Mhz + 1; -- Incrementa el contador
          ELSE
             count_1Mhz <= "0000"; -- Reinicia el contador
          END IF;
          IF count_1Mhz < 4 THEN
             clock_1Mhz_int <= '0'; -- Genera pulso bajo
          ELSE
             clock_1Mhz_int <= '1'; -- Genera pulso alto
          END IF;
       -- Ripple clocks are used in this code to save prescalar hardware
       -- Sync all clock prescalar outputs back to master clock signal
          clock_1Mhz <= clock_1Mhz_int; -- Sincroniza salida
          clock_100Khz <= clock_100Khz_int;
          clock_10Khz <= clock_10Khz_int;
          clock_1Khz <= clock_1Khz_int;
          clock_100hz <= clock_100hz_int;
          clock_10hz <= clock_10hz_int;
          clock_1hz <= clock_1hz_int;
       END PROCESS;
       -- Process 1: Divide by 10
       PROCESS -- Divide el reloj de 1 MHz a 100 KHz
       BEGIN
          WAIT UNTIL clock_1Mhz_int'EVENT and clock_1Mhz_int = '0';
             IF count_100Khz /= 4 THEN
                count_100Khz <= count_100Khz + 1; -- Incrementa el contador
             ELSE
                count_100Khz <= "000"; -- Reinicia el contador
                clock_100Khz_int <= NOT clock_100Khz_int; -- Cambia el estado del reloj
             END IF;
       END PROCESS;
       -- Process 2: Divide by 10
       PROCESS -- Divide el reloj de 100 KHz a 10 KHz
       BEGIN
          WAIT UNTIL clock_100Khz_int'EVENT and clock_100Khz_int = '0';
             IF count_10Khz /= 4 THEN
                count_10Khz <= count_10Khz + 1; -- Incrementa el contador
             ELSE
                count_10Khz <= "000"; -- Reinicia el contador
                clock_10Khz_int <= NOT clock_10Khz_int; -- Cambia el estado del reloj
             END IF;
       END PROCESS;
       -- Process 3: Divide by 10
       PROCESS -- Divide el reloj de 10 KHz a 1 KHz
       BEGIN
          WAIT UNTIL clock_10Khz_int'EVENT and clock_10Khz_int = '0';
             IF count_1Khz /= 4 THEN
                count_1Khz <= count_1Khz + 1; -- Incrementa el contador
             ELSE
                count_1Khz <= "000"; -- Reinicia el contador
                clock_1Khz_int <= NOT clock_1Khz_int; -- Cambia el estado del reloj
             END IF;
       END PROCESS;
       -- Process 4: Divide by 10
       PROCESS -- Divide el reloj de 1 KHz a 100 Hz
       BEGIN
          WAIT UNTIL clock_1Khz_int'EVENT and clock_1Khz_int = '0';
             IF count_100hz /= 4 THEN
                count_100hz <= count_100hz + 1; -- Incrementa el contador
             ELSE
                count_100hz <= "000"; -- Reinicia el contador
                clock_100hz_int <= NOT clock_100hz_int; -- Cambia el estado del reloj
             END IF;
       END PROCESS;
       -- Process 5: Divide by 10
       PROCESS -- Divide el reloj de 100 Hz a 10 Hz
       BEGIN
          WAIT UNTIL clock_100hz_int'EVENT and clock_100hz_int = '0';
             IF count_10hz /= 4 THEN
                count_10hz <= count_10hz + 1; -- Incrementa el contador
             ELSE
                count_10hz <= "000"; -- Reinicia el contador
                clock_10hz_int <= NOT clock_10hz_int; -- Cambia el estado del reloj
             END IF;
       END PROCESS;
       -- Process 6: Divide by 10
       PROCESS -- Divide el reloj de 10 Hz a 1 Hz
       BEGIN
          WAIT UNTIL clock_10hz_int'EVENT and clock_10hz_int = '0';
             IF count_1hz /= 4 THEN
                count_1hz <= count_1hz + 1; -- Incrementa el contador
             ELSE
                count_1hz <= "000"; -- Reinicia el contador
                clock_1hz_int <= NOT clock_1hz_int; -- Cambia el estado del reloj
             END IF;
       END PROCESS;
	   --Process #n...
END a;
