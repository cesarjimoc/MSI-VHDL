library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use work.Package_library.all; -- Importa el paquete de componentes definidos por el usuario

-- Importa la librería estándar IEEE, el paquete para señales std_logic y el paquete de componentes definidos por el usuario.

entity Structural is -- Define la entidad para la implementación estructural
	library ieee; -- Importa la librería estándar IEEE
	use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
	use work.Package_library.all; -- Importa el paquete de componentes definidos por el usuario
	entity Structural is -- Define la entidad para la implementación estructural
-- Entidad Structural: implementación estructural de un sistema. Entradas: resetn, Start, Load, Find, clk, Datos. Salidas: Done, Qmax, Qmin.
	        resetn,Start,Load,Find,clk: in std_logic; -- Entradas de control y reloj
	        Datos: in std_logic_vector(7 downto 0); -- Entrada de datos
	        Done: out std_logic; -- Salida de estado de finalización
	        Qmax,Qmin: buffer std_logic_vector(7 downto 0)); -- Salidas de valores máximo y mínimo
	end Structural; -- Fin de la declaración de la entidad
	architecture solve of Structural is -- Arquitectura principal
	begin
	    signal en0,en1,en2,enMax,enMin,AmayorB,AmenorC: std_logic; -- Señales de control y comparación
	    signal est: std_logic_vector(4 downto 0); -- Señal de estado
	    signal sel: std_logic_vector(1 downto 0); -- Señal de selección
	    signal Qreg1,Qreg2,Qreg3,Qreg: std_logic_vector(7 downto 0); -- Registros de datos
	    signal nc: std_logic_vector(0 to 6); -- Señales auxiliares
		multiplexer: Mux4a1 port map (Qreg1,Qreg2,Qreg3,"00000000",sel,'1',Qreg); -- Instancia el multiplexor para seleccionar entre registros
	    -- Implementación concurrente
	    Controller: MSS port map (resetn,clk,Start,Load,Find,AmayorB,AmenorC,est,sel,Done,en0,en1,en2,enMax,enMin); -- Instancia el controlador principal
	    Bloque_Amarillo: Comparador_3in port map (Qreg,Qmax,Qmin,AmayorB,nc(0),nc(1),nc(2),nc(3),nc(4),nc(5),AmenorC,nc(6)); -- Instancia el comparador de tres entradas
	    Registro1: Reg port map (clk,resetn,en0,Datos,Qreg1); -- Instancia de registro para almacenar datos
	    Registro2: Reg port map (clk,resetn,en1,Datos,Qreg2); -- Instancia de registro para almacenar datos
	    Registro3: Reg port map (clk,resetn,en2,Datos,Qreg3); -- Instancia de registro para almacenar datos
	    multiplexer: Mux4a1 port map (Qreg1,Qreg2,Qreg3,"00000000",sel,'1',Qreg); -- Instancia el multiplexor para seleccionar entre registros
	    RegistroMax: Reg port map (clk,resetn,enMax,Qreg,Qmax); -- Instancia de registro para almacenar valor máximo
	    RegistroMin: Reg port map (clk,resetn,enMin,Qreg,Qmin); -- Instancia de registro para almacenar valor mínimo
	end solve; -- Fin de la arquitectura
-- Bloque_Amarillo: instancia el comparador de tres entradas.
-- Registro1, Registro2, Registro3: instancias de registros para almacenar datos.
-- multiplexer: instancia el multiplexor para seleccionar entre registros.
-- RegistroMax, RegistroMin: instancias de registros para almacenar valores máximo y mínimo.
