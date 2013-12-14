----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:58 08/12/2013 
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
entity spaceInv is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Vsync : out STD_LOGIC;
           HSync : out STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC;
			  test : in std_logic;
			  inicio : in std_logic;
			  izquierda , derecha : in std_logic;
			  disparo_aux :in STD_LOGIC);
end spaceInv;



architecture Behavioral of spaceInv is

component vga
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
end component;


component formatoVGA
		    Port ( RGB : out  STD_LOGIC_VECTOR (2 downto 0);
           X : in  STD_LOGIC_VECTOR (10 downto 0);
           Y : in  STD_LOGIC_VECTOR (10 downto 0);
			  col_nave : in integer range 0 to 19;
			  fila_invasores : in integer range 0 to 14;
			  invasores : in std_logic_vector (0 to 19);
			  x_bala : in integer range 0 to 20;
			  y_bala : in integer range 0 to 14;
			  choque : in  STD_LOGIC;
			  test : in std_logic;
			  estado : in STD_LOGIC_VECTOR (1 downto 0));	
end component;

component nave
    Port ( derecha : in  STD_LOGIC;
           izquierda : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;           
           inicio: in  STD_LOGIC;
			  col_nave : out integer range 0 to 19
			  );
		  
end component;

component invasores
Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  inicializacion : in STD_LOGIC;
			  fila_invasores : out integer range 0 to 14;
			  invasores : out std_logic_vector (0 to 19);
			  cuenta : in  STD_LOGIC_VECTOR (25-1 downto 0);
			  choque : out std_logic;
			  Y_bala : in integer range 0 to 14;
			  X_bala : in integer range 0 to 20;
			  ganado : out std_logic;
			  perdido : out std_logic);
		
end component;

component temporizador is
	generic ( ancho : integer := 25);
	Port ( clk : in  STD_LOGIC;
          reset : in  STD_LOGIC;
          clear : in  STD_LOGIC;
          enable : in  STD_LOGIC;
          cuenta : out  STD_LOGIC_VECTOR ((ancho-1) downto 0)); 
end component;

component disparo is
Port ( Clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       disparo_aux : in  STD_LOGIC;
       col_nave : in  integer range 0 to 19;
       cuenta : in  STD_LOGIC_VECTOR (23-1 downto 0);
       choque : in  STD_LOGIC;
       X_bala : out integer range 0 to 20;
		 Y_bala : out integer range 14 downto 0);
		 
end component;

component maquina is
Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           test : in  STD_LOGIC;
           inicio : in  STD_LOGIC;
           ganado  : in  STD_LOGIC;
           perdido : in  STD_LOGIC;
           estado : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

signal RGB_aux : std_logic_vector (2 downto 0);
signal X_aux, Y_aux: std_logic_vector (10 downto 0);
signal fila_invasores: integer range 0 to 14;
signal col_nave: integer range 0 to 19; 
signal invasores1: std_logic_vector (0 to 19);
signal cuenta_aux: std_logic_vector (25-1 downto 0);
signal cuenta_aux1: std_logic_vector (23-1 downto 0);
signal X_bala_aux : integer range 0 to 20;
signal Y_bala_aux : integer range 0 to 14;
signal estado : STD_LOGIC_VECTOR (1 downto 0);
signal choque1 : STD_LOGIC;
signal perdido1 : STD_LOGIC;
signal ganado1 : STD_LOGIC;


begin

vga2:vga 
	port map (RGB_aux, clk, reset, R, G, B, X_aux, Y_aux, Hsync, Vsync);

formatoVGA2: formatoVGA 
	PORT MAP (RGB => RGB_aux, 
				X => X_aux, 
				Y => Y_aux, 
				col_nave => col_nave, 
				fila_invasores => fila_invasores, 
				invasores => invasores1,
			   choque=>choque1,
				x_bala => X_bala_aux,
				y_bala => Y_bala_aux,
				test => test,
				estado => estado);

nave2: nave 
	port map (derecha => derecha,
				izquierda => izquierda,
				reset => reset,
				clk => clk,
				inicio => inicio, 
				col_nave => col_nave);
invasores2: invasores 
port map (clk => clk, 
			 reset => reset,
			 inicializacion => inicio,
			 fila_invasores => fila_invasores,
			 invasores => invasores1,
			 cuenta=>cuenta_aux,
			 choque => choque1,
			 X_bala => X_bala_aux,
			 Y_bala => Y_bala_aux,
			 perdido => perdido1,
			 ganado => ganado1);
			 
temporizador_inv : temporizador 
	generic map(ancho => 25)
	port map (clk => clk, 
				reset => reset, 
				clear => '0', 
				enable => '1',
				cuenta => cuenta_aux
				);

disparo2: disparo
port map ( 	clk => clk,
				reset => reset,
				disparo_aux => disparo_aux,
				col_nave => col_nave,
				cuenta => cuenta_aux1,
				choque => choque1,
				X_bala => X_bala_aux,
				Y_bala => Y_bala_aux
				);
				
tempo_bala : temporizador
	generic map (ancho => 23)
	port map ( 	clk => clk,
					reset => reset, 
					clear => '0',
					enable => '1',
					cuenta => cuenta_aux1
					);
					
maquina1 : maquina 
port map ( clk => clk,
				reset => reset,
				test => test,
				inicio => inicio,
				perdido => perdido1,
				ganado => ganado1,
				estado => estado );
				


end Behavioral;

