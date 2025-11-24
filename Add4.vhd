library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity Add4 is -- Define la entidad llamada "Add4", que es la interfaz del módulo.
   generic ( n: integer :=4); -- Parámetro genérico 'n', que indica el número de bits (por defecto 4).
   port(
	   A,B,C,D: in std_logic_vector(n-1 downto 0); -- Entradas: A, B, C, D, cada una es un vector de n bits.
	   S: out std_logic_vector(n+1 downto 0)); -- Salida: S, vector de n+2 bits para almacenar el resultado de la suma (incluye bits de acarreo).
end Add4; -- Fin de la declaración de la entidad Add4

architecture solve of add4 is -- Define la arquitectura llamada "solve" para la entidad "Add4".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
	   s<=("00"&A)+("00"&B)+("00"&C)+("00"&D); -- Suma A, B, C y D, agregando dos bits extra ('00') para evitar overflow y obtener los bits de acarreo.
	   --Without the sign bit -- Comentario sobre la suma sin bit de signo.
end solve; -- Fin de la arquitectura
