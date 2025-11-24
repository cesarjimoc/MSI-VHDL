library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Gray is -- Define la entidad para el convertidor binario a Gray
	port(
		X: in std_logic_vector(3 downto 0); -- Entrada binaria de 4 bits
		S: out std_logic_vector(3 downto 0)); -- Salida en código Gray de 4 bits
end Gray; -- Fin de la declaración de la entidad

architecture solve of Gray is -- Arquitectura principal
	-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes
	begin
		s(3)<=x(3)xor'0'; -- Bit más significativo, igual a x(3) xor '0' (es x(3))
		s(2)<=x(2)xor x(3); -- s(2): x(2) xor x(3)
		s(1)<=x(1)xor x(2); -- s(1): x(1) xor x(2)
		s(0)<=x(0)xor x(1); -- s(0): x(0) xor x(1)
end solve; -- Fin de la arquitectura

-- s(3): bit más significativo, igual a x(3) xor '0' (es x(3)).
-- s(2): x(2) xor x(3).
-- s(1): x(1) xor x(2).
-- s(0): x(0) xor x(1).
