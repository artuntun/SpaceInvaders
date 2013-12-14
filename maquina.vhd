----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     19:33:58 08/12/2013 
-- Design Name: 
-- Module Name:    maquina - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--maquina de estados de MOORE que se encagar de controlar en qué estado se encuentra el juego en cada momento

entity maquina is

Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           test : in  STD_LOGIC;
           inicio : in  STD_LOGIC;
           ganado  : in  STD_LOGIC;
           perdido : in  STD_LOGIC;
           estado : out  STD_LOGIC_VECTOR (1 downto 0));
end maquina;


architecture Behavioral of maquina is

TYPE estado1 IS (test1, inicio1, ganado1, perdido1); 
SIGNAL estado_actual, estado_siguiente : estado1;

begin
process (clk, reset)
begin 
	if reset = '1' then	
		
		estado_actual <= test1;
						
	elsif clk' event and clk = '1' then	
		
		estado_actual <= estado_siguiente; 		
		
	end if;
end process;


process (test, inicio, ganado, perdido, estado_actual) 

	begin
	
	
	case estado_actual IS
	
		--el estado de test es la tabla de ajedrez
		
		when test1 => estado <= "00";	
			
			if test = '0' and inicio = '0' then 
			
				estado_siguiente <= test1;
				
			elsif test = '0' and inicio = '1' then 
			
				estado_siguiente <= inicio1;
				
			else
			
				estado_siguiente <= test1;
				
			end if;
			
						--El estado inicio1 es en el que está jugando.
		
		when inicio1 => estado <= "01";
					
			if test = '1' then
				
				estado_siguiente <= test1;
				
			elsif ganado = '0' and perdido = '0' then
			
				estado_siguiente <= inicio1;
				
			elsif ganado = '1' and perdido = '0' then
			
				estado_siguiente <= ganado1;
				
			elsif ganado = '0' and perdido = '1' then 
			
				estado_siguiente <= perdido1;
				
			else
			
				estado_siguiente <= inicio1;
				
			end if;
		
			
		when ganado1 => estado <= "10";
			
			-- El estado ganado se activa cuando se ha conseguido matar a todos los marcianos
			
			if test = '1' then
			
				estado_siguiente <= test1;
				
			elsif inicio = '1' then
			
				estado_siguiente <= inicio1;
								
			else 
			
				estado_siguiente <= ganado1;
				
			end if;
		
		when perdido1 => estado <= "11"; 
				
			-- El estado perdido se activa cuando no hemos conseguido matar a todos los marcianos antes de llegar
			--a la fila de la nave.
				
			if test = '1' then
			
				estado_siguiente <= test1;
				
			elsif inicio = '1' then
			
				estado_siguiente <= inicio1;
						
			else 
			
				estado_siguiente <= perdido1;
				
			end if;
			
		when others => estado_siguiente <= inicio1;
		
	end case;
		
end process;



end Behavioral;
