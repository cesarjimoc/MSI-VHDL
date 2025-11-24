library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity DecoDecimal_BCD is -- Define la entidad llamada "DecoDecimal_BCD", que es la interfaz del módulo.
	  port(Decimal: in std_logic_vector (9 downto 0); -- Entrada: número decimal de 10 bits
				 BCD: out std_logic_vector (3 downto 0)); -- Salida: número BCD de 4 bits
end DecoDecimal_BCD;

architecture Respuesta of DecoDecimal_BCD is -- Define la arquitectura llamada "Respuesta" para la entidad "DecoDecimal_BCD".
-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
SIGNAL or4, or3, or2, or1: std_logic; -- Señales auxiliares para cada bit BCD

BEGIN
   or4 <= Decimal(9) or Decimal(5) or Decimal(7) or Decimal(3) or Decimal(1); -- Calcula el bit 4 del BCD
   or3 <= Decimal(6) or Decimal(7) or Decimal(3) or Decimal(2); -- Calcula el bit 3 del BCD
   or2 <= Decimal(5) or Decimal(6) or Decimal(7) or Decimal(4); -- Calcula el bit 2 del BCD
   or1 <= Decimal(9) or Decimal(8); -- Calcula el bit 1 del BCD
	BCD <= (or1 & or2 & or3 & or4); -- Asigna el resultado a la salida BCD
end Respuesta;
