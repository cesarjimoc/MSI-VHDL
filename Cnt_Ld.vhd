library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity Cnt_Ld is -- Define la entidad llamada "Cnt_Ld", que es la interfaz del módulo.
   generic ( n: integer :=4); -- Parámetro genérico 'n', que indica el número de bits (por defecto 4).
   port(
	   Clk,resetn,en,ld: in std_logic; -- Entradas: reloj, reset activo bajo, habilitación, carga
	   D: in std_logic_vector(n-1 downto 0); -- Entrada de datos para cargar
	   q: buffer std_logic_vector(n-1 downto 0)); -- Salida: valor del contador
end Cnt_Ld;

architecture solve of Cnt_Ld is -- Define la arquitectura llamada "solve" para la entidad "Cnt_Ld".
   -- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
   begin
   -- Proceso principal: contador con carga
   process(resetn,clk)
	   begin
		   if resetn='0' then -- Si el reset está activo, pone la salida en cero
			   q<=(others => '0'); -- Reinicia el contador
		   elsif clk'event and clk='1' then -- Flanco de subida del reloj
			   if en='1' and ld='0' then
				   q<=q+1; -- Si está habilitado y no se carga, incrementa el contador
			   elsif en='1' and ld='1' then
				   q<= D; -- Si está habilitado y se carga, carga el valor de D
			   end if;
		   end if;
   end process;
   -- Aquí podrían ir más procesos si fueran necesarios
end solve;
