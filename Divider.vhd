library IEEE; -- Importa la librería estándar IEEE, necesaria para trabajar con tipos de datos comunes en VHDL.
use IEEE.STD_LOGIC_1164.ALL; -- Importa todos los elementos del paquete std_logic_1164, que define tipos como std_logic y std_logic_vector.
use IEEE.NUMERIC_STD.ALL; -- Permite operaciones aritméticas con vectores de bits.

entity Divider is -- Define la entidad llamada "Divider", que es la interfaz del módulo.
 Port (  clk, reset : in STD_LOGIC; -- Entradas: reloj y reset
				 start : in STD_LOGIC; -- Entrada: señal de inicio
						 m : in  STD_LOGIC_VECTOR (15 downto 0);     -- Entrada: dividendo
						 n : in  STD_LOGIC_VECTOR (7 downto 0);    -- Entrada: divisor
				quotient : out  STD_LOGIC_VECTOR (7 downto 0);    -- Salida: cociente
			  remainder : out  STD_LOGIC_VECTOR (7 downto 0);    -- Salida: residuo
			ready, ovfl : out STD_LOGIC);    -- Salidas: fin de algoritmo y condición de overflow
end Divider;

architecture Behavioral of Divider is -- Define la arquitectura llamada "Behavioral" para la entidad "Divider".
-- Type for the FSM states
type state_type is (idle, shift, op); -- Tipo para los estados de la máquina de estados

-- Inputs/outputs of the state register and the z, d, and i registers
   signal state_reg, state_next : state_type; -- Registros de estado actual y siguiente
   signal z_reg, z_next : unsigned(16 downto 0); -- Registros para el dato extendido
   signal d_reg, d_next : unsigned(7 downto 0); -- Registros para el divisor
   signal i_reg, i_next : unsigned(3 downto 0); -- Registros para el contador de iteraciones
-- The subtraction output 
signal sub : unsigned(8 downto 0); -- Salida de la resta
  

  -- Camino de control: registros de la FSM
  process(clk, reset)
  begin
   if (reset='1') then
	   state_reg <= idle; -- Inicializa el estado en idle
   elsif (clk'event and clk='1') then
	   state_reg <= state_next; -- Actualiza el estado
   end if;
end process;

-- Camino de control: lógica para el siguiente estado de la FSM
process(state_reg, start, m, n, i_next)
begin
   case state_reg is
	   when idle =>
		   if ( start='1' ) then
			   if ( m(15 downto 8) < n ) then
			   state_next <= shift; -- Si el dividendo es menor que el divisor, pasa a shift
			   else
			   state_next <= idle; -- Si no, permanece en idle
			   end if;
		   else
			   state_next <= idle; -- Si no se inicia, permanece en idle
		   end if;
               
	   when shift =>
		   state_next <= op; -- Pasa a operación
       
	   when op =>
		   if ( i_next = "1000" ) then
			   state_next <= idle; -- Si se completaron 8 iteraciones, vuelve a idle
		   else
			   state_next <= shift; -- Si no, vuelve a shift
		   end if;
               
	   end case;
end process;
       
-- Camino de control: lógica de salida
ready <= '1' when state_reg=idle else '0'; -- Señal de listo
ovfl <= '1' when ( state_reg=idle and ( m(15 downto 8) >= n ) ) else '0'; -- Señal de overflow
                       
-- Camino de control: registros del contador de iteraciones
process(clk, reset)
begin
   if (reset='1') then
	   i_reg <= ( others=>'0' ); -- Inicializa el contador en cero
   elsif (clk'event and clk='1') then
	   i_reg <= i_next; -- Actualiza el contador
   end if;
end process;

-- Camino de control: lógica para el contador de iteraciones
process(state_reg, i_reg)
begin
   case state_reg is
	   when idle =>
		   i_next <= (others => '0'); -- Inicializa el contador en cero
	   when shift =>
		   i_next <= i_reg; -- Mantiene el valor
	   when op =>
		   i_next <= i_reg + 1; -- Incrementa el contador
   end case;
end process;
        

-- Camino de datos: registros usados en el camino de datos
process(clk, reset)
begin
   if ( reset='1' ) then
	   z_reg <= (others => '0'); -- Inicializa z en cero
	   d_reg <= (others => '0'); -- Inicializa d en cero
   elsif ( clk'event and clk='1' ) then
	   z_reg <= z_next; -- Actualiza z
	   d_reg <= d_next; -- Actualiza d
   end if;
end process;

-- Camino de datos: multiplexores del camino de datos
process( state_reg, m, n, z_reg, d_reg, sub)
begin
   d_next <= unsigned(n); -- Convierte el divisor a unsigned
   case state_reg is
	   when idle =>
		   z_next <= unsigned( '0' & m ); -- Extiende el dividendo
	   when shift =>
		   z_next <= z_reg(15 downto 0) & '0'; -- Desplaza a la izquierda
	   when op =>
		   if ( z_reg(16 downto 8) < ('0' & d_reg ) ) then
			   z_next <= z_reg; -- Si el valor es menor, mantiene z
		   else
			   z_next <=  sub(8 downto 0) & z_reg(7 downto 1) & '1'; -- Si no, realiza la resta y actualiza z
		   end if;
   end case;
end process;

-- Camino de datos: unidades funcionales
sub <= ( z_reg(16 downto 8) - unsigned('0' & n) ); -- Realiza la resta

-- Camino de datos: salida
quotient <= std_logic_vector( z_reg(7 downto 0) ); -- Asigna el cociente
remainder <= std_logic_vector( z_reg(15 downto 8) ); -- Asigna el residuo
       
end Behavioral;
