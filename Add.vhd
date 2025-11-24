library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity Add is -- Define la entidad llamada "Add", que es la interfaz del módulo.
   generic ( n: integer :=4); -- Parámetro genérico 'n', que indica el número de bits (por defecto 4).
   port(
	   X,Y: in std_logic_vector(n-1 downto 0); -- Entradas: X y Y, cada una es un vector de n bits.
	   S: out std_logic_vector(n downto 0)); -- Salida: S, vector de n+1 bits para almacenar el resultado de la suma (incluye bit de acarreo).
end Add; -- Fin de la declaración de la entidad Add

architecture solve of Add is -- Define la arquitectura llamada "solve" para la entidad "Add".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
	   s<=('0'&x)+('0'&y); -- Suma X y Y, agregando un bit extra ('0') para evitar overflow y obtener el bit de acarreo.
	   --s<='0'&(x+y); -- Alternativa para sumar X y Y con el bit de signo.
end solve; -- Fin de la arquitectura
