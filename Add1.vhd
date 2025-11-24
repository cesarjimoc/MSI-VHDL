library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity Add1 is -- Define la entidad llamada "Add1", que es la interfaz del módulo.
   generic ( n: integer :=8); -- Parámetro genérico 'n', que indica el número de bits (por defecto 8).
   port(
	   X: in std_logic_vector(n-1 downto 0); -- Entrada: X, vector de n bits.
	   S: out std_logic_vector(n downto 0)); -- Salida: S, vector de n+1 bits para almacenar el resultado de la suma (incluye bit de acarreo).
end Add1; -- Fin de la declaración de la entidad Add1

architecture solve of Add1 is -- Define la arquitectura llamada "solve" para la entidad "Add1".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
	   s<='0'&(x+1); -- Suma 1 al valor de X y agrega un bit extra ('0') para el bit de acarreo.
end solve; -- Fin de la arquitectura
