----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:58 08/12/2013 
-- Design Name: 
-- Module Name:    vga - Behavioral 
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
USE ieee.std_logic_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--Esta entidad se encarga de la sincronización con el monitor 

entity vga is
    Port ( RGB : in  STD_LOGIC_VECTOR (2 downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC;
           X : out  STD_LOGIC_VECTOR (10 downto 0);
           Y : out  STD_LOGIC_VECTOR (10 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC);
end vga;



architecture Behavioral of vga is

-- Estas son la señales de sincronismo en binario, y la componente horizontal está multiplicada
-- por dos para adpatarse a la frecuencia del monitor

	constant AH : STD_LOGIC_VECTOR (10 downto 0) := "10011111111";
	constant BH : STD_LOGIC_VECTOR (10 downto 0) := "10100011011";
	constant CH : STD_LOGIC_VECTOR (10 downto 0) := "10111011111";
	constant DH : STD_LOGIC_VECTOR (10 downto 0) := "11000111111";
	constant AV : STD_LOGIC_VECTOR (10 downto 0) := "00111011111";
	constant BV : STD_LOGIC_VECTOR (10 downto 0) := "00111101001";
	constant CV : STD_LOGIC_VECTOR (10 downto 0) := "00111101011";
	constant DV : STD_LOGIC_VECTOR (10 downto 0) := "01000001000";

	signal cuentaH, cuentaV: STD_LOGIC_VECTOR (10 downto 0);
begin

-- Diseñamos dos contadores uno horizontal y otro vertical para hacer un barrido de la pantalla
	
PROCESS (Reset, Clk)
BEGIN 
	if reset = '1' then 	
		cuentaH <= "00000000000"; 
	elsif clk'event and clk= '1' then
		if cuentaH < DH then
			cuentaH <= cuentaH + 1;
		else 
			cuentaH <= "00000000000";
		end if; 
		X <= cuentaH;
	end if;
	
end process; 
	
PROCESS (Reset, Clk)
BEGIN 
	if reset = '1' then 	
		cuentaV <= "00000000000"; 
	elsif clk'event and clk= '1' then 
		if cuentaH = "11000111111" then 
			if cuentaV < DV then
				cuentaV <= cuentaV + 1;
			else 
				cuentaV <= "00000000000";
			end if; 
		end if; 
		Y <= cuentaV;
	end if;
	 
end process;

-- En este proceso se encarga de dar los valores de color a los píxeles y sincronizar el barrido horizontal 
-- con el barrido vertical 	
	
PROCESS (cuentaH, cuentaV, RGB) 
BEGIN 
	if cuentaH < AH then 
		R <= RGB (2);
		G <= RGB (1);
		B <= RGB (0);
	else 
		R <= '0';
		G <= '0';
		B <= '0';
	end if;
	
	if cuentaH >= BH and cuentaH <= CH then
		Hsync <= '0';
	else
		Hsync <= '1';
	end if;
	if cuentaV >= BV and cuentaV <= CV then
		Vsync <= '0';
	else
		Vsync <= '1';
	end if;
end process; 

end Behavioral;
