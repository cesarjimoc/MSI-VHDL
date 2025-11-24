library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

Package Package_library is -- Define el paquete de componentes reutilizables
	component Reg is -- Componente registro de n bits
		generic ( n: integer :=8); -- Parámetro genérico 'n', número de bits
		port(
			Clk,resetn,en: in std_logic; -- Entradas: Clk (reloj), resetn (reset activo bajo), en (habilitación)
			d: in std_logic_vector(n-1 downto 0); -- Entrada de datos d
			q: out std_logic_vector(n-1 downto 0)); -- Salida: q, registro de n bits
	end component; -- Fin del componente Reg
	
	component Mux4a1 is -- Componente multiplexor de 4 a 1
		generic ( n: integer:=8); -- Parámetro genérico 'n', número de bits
		port (
			A : in std_logic_vector(n-1 downto 0); -- Entrada A
			B : in std_logic_vector(n-1 downto 0); -- Entrada B
			C : in std_logic_vector(n-1 downto 0); -- Entrada C
			D : in std_logic_vector(n-1 downto 0); -- Entrada D
			sel : in std_logic_vector(1 downto 0); -- Selección
			en: in std_logic; -- Habilitación
			Q : out std_logic_vector(n-1 downto 0)); -- Salida Q
	end component; -- Fin del componente Mux4a1
	component Comparador_3in is -- Componente comparador de tres entradas
		generic ( n: integer :=8); -- Parámetro genérico 'n', número de bits
		Port(
			A,B,C: in std_logic_vector(n-1 downto 0); -- Entradas A, B, C
			AmayorB, AmayorC, BmayorC: out std_logic; -- Salidas de comparación mayor
			AigualB, AigualC, BigualC: out std_logic; -- Salidas de comparación igual
			AmenorB, AmenorC, BmenorC: out std_logic); -- Salidas de comparación menor
	end component; -- Fin del componente Comparador_3in

	component MSS is -- Componente máquina de estados secuencial
		port(
			resetn,clk,Start,Load,Find,AmayorB,AmenorC: in std_logic; -- Entradas de control
			est: out std_logic_vector(4 downto 0); -- Salida de estado
			sel: out std_logic_vector(1 downto 0); -- Salida de selección
			Done,en0,en1,en2,enMax,enMin: out std_logic); -- Salidas de control
	end component; -- Fin del componente MSS
	
end Package_library; -- Fin del paquete

-- Paquete Package_library: define componentes reutilizables para el proyecto.
-- component Reg: registro de n bits.
-- component Mux4a1: multiplexor de 4 a 1 de n bits.
-- component Comparador_3in: comparador de tres entradas de n bits.
-- component MSS: máquina de estados secuencial para control.
