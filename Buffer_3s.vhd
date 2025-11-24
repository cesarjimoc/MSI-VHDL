library ieee;    -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all;    -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.

entity Buffer_3s is  -- Define la entidad llamada "Buffer_3s", que es la interfaz del módulo.
   generic(n: integer:=4); -- Parámetro genérico 'n', que indica el número de bits (por defecto 4).
   port(
	   ent: in std_logic_vector(n-1 downto 0); -- Entrada: ent, vector de n bits.
	  en: in std_logic; -- Entrada: en, habilitación del buffer.
	  sal: out std_logic_vector(n-1 downto 0)); -- Salida: sal, vector de n bits.
end Buffer_3s; -- Fin de la declaración de la entidad

architecture solve of Buffer_3s is -- Define la arquitectura llamada "solve" para la entidad "Buffer_3s".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin    
	   sal<=(others=>'Z') when en='0' else ent; -- Si en=0, la salida es alta impedancia ('Z'), si en=1, la salida es igual a la entrada.
end solve; -- Fin de la arquitectura
