----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     19:33:58 08/12/2013 
-- Design Name: 
-- Module Name:    temporizador - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Esta entidad es un temporizador que se encarga de controlar la velocidad con la que se mueven los marcianos
-- y la bala.

entity temporizador is
	 generic ( ancho : integer := 25); --Ancho es un parámetro que tiene el valor del número de bits del contador
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           cuenta : out  STD_LOGIC_VECTOR (ancho-1 downto 0)  -- Variable que se pasará a otras entidades para 
																				--comprobar que la cuenta ha llegado a su fin.
			  );
end temporizador;

architecture Behavioral of temporizador is

signal cuenta1 :  STD_LOGIC_VECTOR (ancho-1 downto 0);

begin

process (reset, clk)
begin

	if reset = '1' then
		cuenta1 <= (others => '0');
	
	elsif clk'event and clk = '1' then
		if enable = '1' then
			if clear  = '1' then
				cuenta1 <= (others  => '0');
			else
				cuenta1 <= cuenta1 + 1;
			end if;
		end if;
	end if;
end process;
cuenta <= cuenta1;

end Behavioral;

