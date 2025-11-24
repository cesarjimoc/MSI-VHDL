library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.numeric_std.all; -- Permite operaciones aritméticas
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits

-- Importa las librerías estándar IEEE y los paquetes para operaciones aritméticas y señales lógicas.

entity SRAMv2 is -- Define la entidad para la memoria RAM síncrona
generic ( n: integer:=8; -- n-bits por dato
		m:integer:=8 ); -- m-bits de direcciones
port(clock, WE: in std_logic; -- Entradas: clock (reloj), WE (escritura)
		Data: in std_logic_vector(n-1 downto 0); -- Entrada de datos
		Address: in std_logic_vector(m-1 downto 0); -- Entrada de dirección
		Q: out std_logic_vector(n-1 downto 0)); -- Salida de datos
end SRAMv2; -- Fin de la declaración de la entidad

-- Entidad SRAMv2: memoria RAM síncrona de 255 palabras de 8 bits. Parámetros: n (bits de datos), m (bits de dirección). Entradas: clock (reloj), WE (escritura), Data (datos de entrada), Address (dirección). Salida: Q (datos de salida).

architecture comp of SRAMv2 is -- Arquitectura principal
	type ram_type is array (254 downto 0) of std_logic_vector (7 downto 0); -- Tipo de arreglo para la memoria
	signal memram: ram_type; -- Instancia la memoria
	begin
	process(clock) -- Proceso sensible a clock
		begin
			if (clock'event and clock='1') then -- Flanco de subida del reloj
				if WE='1' then -- Si escritura activa
					memram(conv_integer(address)) <= Data; -- Escribe Data en la dirección Address
				else -- Si no está escribiendo
					Q <= memram(conv_integer(address)); -- Lee memoria y asigna a Q
				end if;
			end if;
		end process; -- Fin del proceso
end comp; -- Fin de la arquitectura

-- Arquitectura comp: implementa la memoria RAM.
-- type ram_type: define el arreglo de memoria de 255 posiciones.
-- signal memram: instancia la memoria.
-- process: en flanco de subida de clock, si WE es '1', escribe Data en la dirección Address; si no, lee el valor almacenado en la dirección Address y lo asigna a Q.
