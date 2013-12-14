--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    19:33:58 08/12/2013 
-- Design Name:   
-- Module Name:   C:/Users/Roland/Desktop/space_invaders/tb_spaceInv.vhd
-- Project Name:  space_invaders
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: spaceInv
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_spaceInv IS
END tb_spaceInv;
 
ARCHITECTURE behavior OF tb_spaceInv IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT spaceInv
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         Vsync : OUT  std_logic;
         HSync : OUT  std_logic;
         R : OUT  std_logic;
         G : OUT  std_logic;
         B : OUT  std_logic;
         test : IN  std_logic;
         inicio : IN  std_logic;
         izquierda : IN  std_logic;
         derecha : IN  std_logic;
         disparo1 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal test : std_logic := '0';
   signal inicio : std_logic := '0';
   signal izquierda : std_logic := '0';
   signal derecha : std_logic := '0';
   signal disparo1 : std_logic := '0';

 	--Outputs
   signal Vsync : std_logic;
   signal HSync : std_logic;
   signal R : std_logic;
   signal G : std_logic;
   signal B : std_logic;

   -- Clock period definitions

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spaceInv PORT MAP (
          clk => clk,
          reset => reset,
          Vsync => Vsync,
          HSync => HSync,
          R => R,
          G => G,
          B => B,
          test => test,
          inicio => inicio,
          izquierda => izquierda,
          derecha => derecha,
          disparo1 => disparo1
        );

   -- Clock process definitions
	 
	 PROCESS 
BEGIN
	clk <= NOT clk;
	WAIT FOR 10 NS;
END PROCESS;

 

   -- Stimulus process
PROCESS
BEGIN
	reset <= '1'; --Contemplamos que esté activo reset durante 50 ns
	WAIT FOR 50 NS;
	reset <= '0';
	WAIT ;
END PROCESS;

test <= '1', '0' after 80 ns ; --Contemplamos que esté activo test durante 80 ns
inicio <= '1', '0' after 16 ms; -- Activamos inicio durante 16 ms para que le dé tiempo a transcurrir todo el proceso 
derecha <= '0', '1' after 200 ns, '0' after 400 ns; --
izquierda <= '0', '1' after 600 ns, '0' after 800 ns;
disparo1 <= '0'; --para ver la bala


END;
