library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits

entity AddBCD is -- Define la entidad para el sumador BCD
	port( A,B: in std_logic_vector(3 downto 0); -- Entradas: dos números BCD de 4 bits
		D,U: out std_logic_vector(3 downto 0)); -- Salidas: decenas y unidades
end AddBCD; -- Fin de la declaración de la entidad

architecture solve of AddBCD is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	signal temp,temp2: std_logic_vector(7 downto 0); -- Señales internas para almacenar resultados intermedios
	begin
		temp <= (("0000"&A)+("0000"&B)); -- Suma los dos números BCD, extendiendo a 8 bits
		temp2 <= temp + "00000110" when temp>9 else temp; -- Si la suma es mayor a 9, ajusta con 6 para formato BCD
		D<= temp2(7 downto 4); -- Decenas: toma los 4 bits más altos
		U<= temp2(3 downto 0); -- Unidades: toma los 4 bits más bajos
end solve; -- Fin de la arquitectura
