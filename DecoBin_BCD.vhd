library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity DecoBin_BCD is -- Define la entidad llamada "DecoBin_BCD", que es la interfaz del módulo.
	port(
		num_bin: in  std_logic_vector(8 downto 0); -- Entrada: número binario de 9 bits
		num_bcd: out std_logic_vector(10 downto 0)); -- Salida: número BCD de 11 bits (centenas, decenas, unidades)
end DecoBin_BCD;

architecture solve of DecoBin_BCD is -- Define la arquitectura llamada "solve" para la entidad "DecoBin_BCD".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
	-- Proceso principal: conversión de binario a BCD
   proceso_bcd: process(num_bin)
   variable z: std_logic_vector(19 downto 0); -- Variable auxiliar para el algoritmo de conversión
	   begin
	   -- Inicialización de datos en cero.
	   z := (others => '0'); -- Inicializa la variable auxiliar en cero
	   -- Se realizan los primeros tres corrimientos.
	   z(11 downto 3) := num_bin; -- Coloca el número binario en la posición adecuada
	   for i in 0 to 5 loop -- Realiza 6 iteraciones para convertir a BCD
		   -- Unidades (4 bits).
		   if z(12 downto 9) > 4 then
			   z(12 downto 9) := z(12 downto 9) + 3; -- Si el valor es mayor a 4, suma 3 (corrección BCD)
		   end if;
		   -- Decenas (4 bits).
		   if z(16 downto 13) > 4 then
			   z(16 downto 13) := z(16 downto 13) + 3; -- Si el valor es mayor a 4, suma 3 (corrección BCD)
		   end if;
		   -- Centenas (3 bits).
		   if z(19 downto 17) > 4 then
			   z(19 downto 17) := z(19 downto 17) + 3; -- Si el valor es mayor a 4, suma 3 (corrección BCD)
		   end if;
		   -- Corrimiento a la izquierda.
		   z(19 downto 1) := z(18 downto 0); -- Desplaza todos los bits a la izquierda
	   end loop;
	   -- Pasando datos de variable Z, correspondiente a BCD.
	   num_bcd <= z(19 downto 9); -- Asigna el resultado BCD a la salida
   end process;
   -- Aquí podrían ir más procesos si fueran necesarios
end solve;
