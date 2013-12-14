----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:16 12/03/2012 
-- Design Name: 
-- Module Name:    formatoVGA - Behavioral 
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

-- Esta entidad va a ser la encargada de sacarnos por pantalla lo que ocurre durante el juego. 

entity formatoVGA is
	
    Port ( test: in STD_LOGIC;
			  RGB : out  STD_LOGIC_VECTOR (2 downto 0);
           X : in  STD_LOGIC_VECTOR (10 downto 0);
           Y : in  STD_LOGIC_VECTOR (10 downto 0)
			  );	
			
end formatoVGA;

architecture Behavioral of formatoVGA is

begin

PROCESS (X, Y, test)

begin 

-- En esta primera condición dibujamos el tablero de ajedrez usando coordenadas de punto gordo

	if test = '1' then 
		if X(6) = '0' then 
			if Y(5) = '0' then
				RGB <= "111" ;
			else 
				RGB <= "000"; 
			end if;
		else 
			if Y(5) = '1' then	
				RGB <= "111"; 
			else 
				RGB <= "000"; 
			end if;
		end if;
	else
		RGB<= "100";
	end if;
		
end process; 


end Behavioral;

