entity Accum is -- Define la entidad para el acumulador
   generic ( n: integer :=4); -- Número de bits del acumulador
   port(
       Clk,resetn,en: in std_logic; -- Entradas: reloj, reset activo bajo, habilitación
       data: in std_logic(n-1 downto 0); -- Entrada de datos a acumular
       q: buffer std_logic_vector(n-1 downto 0)); -- Salida: valor acumulado
end Accum; -- Fin de la declaración de la entidad Accum

architecture solve of Accum is -- Arquitectura principal
   -- Aquí se pueden declarar señales, constantes, variables, componentes
begin
   -- Proceso principal: acumulador secuencial
   process(resetn,clk) -- Proceso sensible a resetn y clk
       begin
           if resetn='0' then -- Si el reset está activo, pone la salida en cero
               q<=(others => '0'); -- Reinicia el acumulador
           elsif clk'event and clk='1' then -- Flanco de subida del reloj
               if en='1' then -- Si está habilitado
                   q<=q+data; -- Suma el dato de entrada al acumulador
               end if;
           end if;
   end process;
   -- Aquí podrían ir más procesos si fueran necesarios
end solve; -- Fin de la arquitectura del acumulador
