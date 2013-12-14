----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:58 12/03/2013
-- Design Name: 
-- Module Name:    spaceInv - Behavioral 
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
entity SpaceInvaders is
    Port ( clk : in  STD_LOGIC;
			  test: in STD_LOGIC;
           reset : in  STD_LOGIC;
           Vsync : out STD_LOGIC;
           HSync : out STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end SpaceInvaders;



architecture Behavioral of SpaceInvaders is

component vga
		     Port ( 
			  RGB : in  STD_LOGIC_VECTOR (2 downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC;
           X : out  STD_LOGIC_VECTOR (10 downto 0);
           Y : out  STD_LOGIC_VECTOR (10 downto 0);
           Hsync : out  STD_LOGIC;
           Vsync : out  STD_LOGIC);
end component;


component formatoVGA
		    Port ( 
			  test: in STD_LOGIC;
			  RGB : out  STD_LOGIC_VECTOR (2 downto 0);
           X : in  STD_LOGIC_VECTOR (10 downto 0);
           Y : in  STD_LOGIC_VECTOR (10 downto 0)
			  );	
end component;

component temporizador is
	generic ( ancho : integer := 25);
	Port ( clk : in  STD_LOGIC;
          reset : in  STD_LOGIC;
          clear : in  STD_LOGIC;
          enable : in  STD_LOGIC;
          cuenta : out  STD_LOGIC_VECTOR ((ancho-1) downto 0)); 
end component;

signal RGB_aux : std_logic_vector (2 downto 0);
signal X_aux, Y_aux: std_logic_vector (10 downto 0);
signal cuenta_aux: std_logic_vector (25-1 downto 0);


begin
vga2:vga 
	port map (RGB_aux, clk, reset, R, G, B, X_aux, Y_aux, Hsync, Vsync);

formatoVGA2: formatoVGA 
	PORT MAP (test => test, RGB => RGB_aux, X => X_aux, Y => Y_aux);
	
temporizador_inv : temporizador 
generic map(ancho => 25)
port map (clk => clk, 
			reset => reset, 
			clear => '0', 
			enable => '1',
			cuenta => cuenta_aux
			);




end Behavioral;