library ieee; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use ieee.std_logic_1164.all; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use ieee.std_logic_unsigned.all; -- Permite operaciones aritméticas con vectores de bits.

entity DecoBCD_Bin_3Dig is -- Define la entidad llamada "DecoBCD_Bin_3Dig", que es la interfaz del módulo.
	  port(BCD: in std_logic_vector (11 downto 0); -- Entrada: valor BCD de 3 dígitos (12 bits)
			  Binario: out std_logic_vector (7 downto 0)); -- Salida: valor binario de 8 bits
end DecoBCD_Bin_3Dig;

architecture Respuesta of DecoBCD_Bin_3Dig is -- Define la arquitectura llamada "Respuesta" para la entidad "DecoBCD_Bin_3Dig".
-- Signals,Constants,Variables,Components -- Aquí se pueden declarar señales, constantes, variables, componentes.
SIGNAL Unidad, Decena, Centena: std_logic_vector(7 downto 0); -- Señales para cada dígito BCD
SIGNAL UD, UDC: std_logic_vector(7 downto 0); -- Señales intermedias para sumas

BEGIN
	  Centena <= '0' & '0' & '0' & '0' & BCD(11 DOWNTO 8); -- Extrae la centena y la extiende a 8 bits
	  Decena <= '0' & '0' & '0' & '0' & BCD(7 DOWNTO 4); -- Extrae la decena y la extiende a 8 bits
	  Unidad <= '0' & '0' & '0' & '0' & BCD(3 DOWNTO 0); -- Extrae la unidad y la extiende a 8 bits
	  -- Proceso #1: suma decenas
	  process(Decena)
	  begin 
		 if (Decena = "00000000") then 
			  UD<=Unidad; -- Si decena es 0, solo la unidad
		  elsif (Decena = "00000001") then
			  UD <= Unidad+"00001010"; -- Suma 10
		  elsif (Decena = "00000010") then
			  UD <= Unidad + "00010100"; -- Suma 20
		  elsif (Decena = "00000011") then
			  UD <= Unidad + "00011110"; -- Suma 30
		  elsif (Decena = "00000100") then
			  UD <= Unidad + "00101000"; -- Suma 40
		  elsif (Decena = "00000101") then
			  UD <= Unidad + "00110010"; -- Suma 50
		  elsif (Decena = "00000110") then
			  UD <= Unidad + "00111100"; -- Suma 60
		  elsif (Decena = "00000111") then
			  UD <= Unidad + "01000110"; -- Suma 70
		  elsif (Decena = "00001000") then
			  UD <= Unidad + "01010000"; -- Suma 80
		  elsif (Decena = "00001001") then
			  UD <= Unidad + "01011010"; -- Suma 90
		  else 
			  UD <= Unidad; -- Si no es ninguna de las anteriores, solo la unidad
		  end if;  
	  end process; 
     
	 -- Proceso #2: suma centenas
	 process (Centena)
	  begin
		 if (Centena = "00000001") then
				UDC <= UD + "01100100"; -- Suma 100
		  elsif (Centena = "00000010") then
			  UDC <= UD + "11001000"; -- Suma 200
		  else 
			  UDC <= UD; -- Si no es ninguna de las anteriores, solo decenas y unidades
		  end if;
	  end process; 
	  -- Aquí podrían ir más procesos si fueran necesarios
Binario <= UDC; -- Asigna el resultado final a la salida binaria
end Respuesta;
