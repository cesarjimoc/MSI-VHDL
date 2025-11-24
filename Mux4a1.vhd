library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Mux4a1 is -- Define la entidad para el multiplexor 4 a 1
	generic ( n: integer:=4);--<-- nbits
	port (
		A : in std_logic_vector(n-1 downto 0);
		B : in std_logic_vector(n-1 downto 0);
		C : in std_logic_vector(n-1 downto 0);
		D : in std_logic_vector(n-1 downto 0);
		sel : in std_logic_vector(1 downto 0);
		en: in std_logic;
		Q : out std_logic_vector(n-1 downto 0));
end Mux4a1;

architecture solve of Mux4a1 is
	signal f: std_logic_vector(n-1 downto 0);
	begin
		with sel select 
		f<= A when "00",
			 B when "01",
			 C when "10",
			 D when others;
		Q<= f when en='1' else (others=>'0');	 
end solve;

-- signal f: almacena el dato seleccionado por sel.
-- with sel select: selecciona entre A, B, C, D según el valor de sel.
-- Q: si en es '1', Q toma el valor de f; si en es '0', Q se pone en cero.
