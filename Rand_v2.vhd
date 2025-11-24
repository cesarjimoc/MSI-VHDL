library ieee; -- Importa la librería estándar IEEE
library ieee; -- Importa la librería estándar IEEE
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164
use ieee.std_logic_1164.all; -- Importa el paquete std_logic_1164

entity Rand_v2 is -- Define la entidad para el generador de números aleatorios de 8 bits
entity Rand_v2 is -- Define la entidad para el generador de números aleatorios de 8 bits
   port (clk : in std_logic; -- Entrada de reloj
        -- Entrada de reloj
	      resetn: in std_logic;  -- Entrada de reset activo bajo
        -- Entrada de reset activo bajo
			load: in std_logic; -- Entrada de carga
        -- Entrada de carga
			seed: in std_logic_vector (7 downto 0); -- Entrada de semilla
        -- Entrada de semilla
			random: out std_logic_vector (7 downto 0)); -- Salida de número aleatorio
        -- Salida de número aleatorio
end Rand_v2; -- Fin de la declaración de la entidad
end Rand_v2; -- Fin de la declaración de la entidad

architecture funcional of Rand_v2 is -- Arquitectura principal
architecture funcional of Rand_v2 is -- Arquitectura principal
    signal lfsr_reg: std_logic_vector(7 downto 0); -- Registro de desplazamiento lineal (LFSR)
    signal lfsr_reg: std_logic_vector(7 downto 0); -- Registro de desplazamiento lineal (LFSR)
	begin
     process(clk, resetn) -- Proceso principal
     process(clk, resetn) -- Proceso principal
	  begin 
	   if (resetn = '0') then -- Si resetn es '0', inicializa el registro en cero
	   if (resetn = '0') then -- Si resetn es '0', inicializa el registro en cero
	      lfsr_reg <= (others => '0');
	      lfsr_reg <= (others => '0');
		elsif (clk'event and clk = '1') then -- Flanco de subida del reloj
		elsif (clk'event and clk = '1') then -- Flanco de subida del reloj
		  if (load = '1') then -- Si load es '1', carga la semilla
		  if (load = '1') then -- Si load es '1', carga la semilla
		    lfsr_reg <= seed;
		    lfsr_reg <= seed;
		  else
		  else
		   -- Realiza el desplazamiento y las operaciones xnor para generar la secuencia
		   -- Realiza el desplazamiento y las operaciones xnor para generar la secuencia
		   lfsr_reg(0) <= lfsr_reg(7);
		   lfsr_reg(0) <= lfsr_reg(7);
		   lfsr_reg(1) <= lfsr_reg(0);
		   lfsr_reg(1) <= lfsr_reg(0);
		   lfsr_reg(2) <= lfsr_reg(1) xnor lfsr_reg(7);
		   lfsr_reg(2) <= lfsr_reg(1) xnor lfsr_reg(7);
		   lfsr_reg(3) <= lfsr_reg(2) xnor lfsr_reg(7);
		   lfsr_reg(3) <= lfsr_reg(2) xnor lfsr_reg(7);
		   lfsr_reg(4) <= lfsr_reg(3) xnor lfsr_reg(7);
		   lfsr_reg(4) <= lfsr_reg(3) xnor lfsr_reg(7);
		   lfsr_reg(5) <= lfsr_reg(4);
		   lfsr_reg(5) <= lfsr_reg(4);
		   lfsr_reg(6) <= lfsr_reg(5);
		   lfsr_reg(6) <= lfsr_reg(5);
		   lfsr_reg(7) <= lfsr_reg(6);
		   lfsr_reg(7) <= lfsr_reg(6);
		  end if;
		  end if;
	   end if; 
	   end if; 
	  end process; 
	  end process; 
    random <= lfsr_reg; -- Asigna el valor actual del registro LFSR a la salida
    random <= lfsr_reg; -- Asigna el valor actual del registro LFSR a la salida
end funcional; -- Fin de la arquitectura
end funcional; -- Fin de la arquitectura

-- Arquitectura funcional: implementa un LFSR de 8 bits para generar números aleatorios.
-- signal lfsr_reg: registro de desplazamiento lineal.
-- process: si resetn es '0', inicializa el registro en cero; si load es '1', carga la semilla; si no, realiza el desplazamiento y las operaciones xnor para generar la secuencia.
-- random: salida del valor actual del registro LFSR.
