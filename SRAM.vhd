library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.std_logic_arith.all; -- Permite operaciones aritméticas
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits

-- Importa las librerías estándar IEEE y los paquetes para operaciones aritméticas y señales lógicas.

entity SRAM is  -- Define la entidad para la memoria RAM síncrona
	generic(n: integer:=8; -- n-bits por dato
	m: integer:=2); -- m-bits de direcciones
	port(
		clk,en,wr: in std_logic; -- Entradas: clk (reloj), en (habilitación), wr (escritura)
		addr : in std_logic_vector(m-1 downto 0); -- Entrada de dirección
		Din : in std_logic_vector(n-1 downto 0); -- Entrada de datos
		Dout : out std_logic_vector(n-1 downto 0)); -- Salida de datos
end SRAM; -- Fin de la declaración de la entidad

-- Entidad SRAM: memoria RAM síncrona de 32 palabras de 8 bits con habilitación. Parámetros: n (bits de datos), m (bits de dirección). Entradas: clk (reloj), en (habilitación), wr (escritura), addr (dirección), Din (datos de entrada). Salida: Dout (datos de salida).

architecture solve of SRAM is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	type ram_type is array (0 to (2**m)-1) of std_logic_vector(n-1 downto 0); -- Tipo de arreglo para la memoria
	signal tmp_ram: ram_type; -- Instancia la memoria
	begin
	--Process #1: -- Proceso principal
	process(clk,wr) -- Proceso sensible a clk y wr
	--Sequential programming -- Programación secuencial
		begin
			if (clk'event and clk='1') then -- Flanco de subida del reloj
				if wr='1' then -- Si escritura activa
					tmp_ram(conv_integer(addr)) <= Din; -- Escribe Din en la dirección addr
				end if;
			end if;
	end process; -- Fin del proceso
	--Process #n... -- Aquí podrían ir más procesos
	Dout<=(others=>'Z') when en='0' else tmp_ram(conv_integer(addr)); -- Salida de datos: alta impedancia si en=0, lee memoria si en=1
end solve; -- Fin de la arquitectura

-- Arquitectura solve: implementa la memoria RAM con habilitación.
-- type ram_type: define el arreglo de memoria.
-- signal tmp_ram: instancia la memoria.
-- process: en flanco de subida de clk, si wr es '1', escribe Din en la dirección addr.
-- Dout: salida de datos, si en es '0' pone alta impedancia, si en es '1' lee el valor almacenado en la dirección addr.
