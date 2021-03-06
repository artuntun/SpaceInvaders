----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:      19:35:38 08/12/2013 
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
	
    Port ( RGB : out  STD_LOGIC_VECTOR (2 downto 0);
           X : in  STD_LOGIC_VECTOR (10 downto 0);
           Y : in  STD_LOGIC_VECTOR (10 downto 0);
			  col_nave : in integer range 0 to 19; 
			  fila_invasores : in integer range 0 to 14;
			  invasores : in std_logic_vector (0 to 19);
			  x_bala : in integer range 0 to 20;
			  y_bala : in integer range 0 to 14;
			  test : in std_logic;
			  choque : in std_logic;			  			  
			  estado : in STD_LOGIC_VECTOR (1 downto 0));	
			
end formatoVGA;

architecture Behavioral of formatoVGA is

--En primer lugar vamos a dise�ar los iconos del marciano, la bala y la nave, y por otra parte
--las pantallas de ganador y perderdor. 

		
		
Type icono is array (0 to 31,0 to 31) of std_logic_vector (2 downto 0);
Constant Marciano : icono := 
(
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"), 
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"), 
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "111" ,  "111" , "000" , "000" , "000" , "000" , "000" , "000" , "000", "000" , "000" , "000" ,"111" ,"111" ,"000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "111" ,  "111" , "000" , "000" , "000" , "000" , "000" , "000" , "000", "000" , "000" , "000" ,"111" ,"111" ,"000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "000" ,  "000" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" , "000" , "000" , "000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "000" ,  "000" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" , "000" , "000" , "000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "111" ,  "111" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" ,"111" ,"111" , "000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "111" ,  "111" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" ,"111" ,"111" , "000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "111" , "111" , "111" ,  "111" , "000" , "000" , "111" , "111" , "111" , "111" , "111" ,"111" , "000" , "000" ,"111" ,"111" ,"111" , "111" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "111" , "111" , "111" ,  "111" , "000" , "000" , "111" , "111" , "111" , "111" , "111" ,"111" , "000" , "000" ,"111" ,"111" ,"111" , "111" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "111" , "111" , "111" , "111" , "111" ,  "111" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" ,"111" ,"111" ,"111" , "111" , "111" , "111" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "111" , "111" , "111" , "111" , "111" ,  "111" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" ,"111" ,"111" ,"111" , "111" , "111" , "111" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "111" , "111" , "000" , "000" , "111" ,  "111" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" ,"111" ,"111" , "000" , "000" , "111" , "111" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "111" , "111" , "000" , "000" , "111" ,  "111" , "111" , "111" , "111" , "111" , "111" , "111" , "111" ,"111" , "111" , "111" ,"111" ,"111" , "000" , "000" , "111" , "111" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "111" , "111" , "000" , "000" , "111" ,  "111" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" ,"111" ,"111" , "000" , "000" , "111" , "111" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "111" , "111" , "000" , "000" , "111" ,  "111" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" ,"111" ,"111" ,  "000" , "000" , "111" , "111" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "000" ,  "000" , "111" , "111" , "111" , "111" , "000" , "000" , "111" ,"111" , "111" , "111" ,"000" , "000" , "000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000" , "000", "000", "000", "000", "000" , "000" , "000" , "000" , "000" ,  "000" , "111" , "111" , "111" , "111" , "000" , "000" , "111" ,"111" , "111" , "111" ,"000"  , "000" , "000" , "000" , "000" , "000" , "000", "000", "000", "000", "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"), 
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"),
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000"), 
("000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000","000", "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000" , "000")
);

		
		

-- Vamos a a�adir una serie de se�ales que se van a encargar o bien de recorrer la pantalla (punto gordo),
--o bien cada uno de los p�xeles (punto fino) 


CONSTANT fila_nave : integer := 14;
SIGNAL col_x: INTEGER RANGE 0 to 19;
SIGNAL fila_y: integer range 0 to 14;
SIGNAL xDibu: integer range 0 to 31;
SIGNAL yDibu: integer range 0 to 31;


begin

col_x <= CONV_INTEGER(x(10 downto 6));
fila_y <= conv_integer (y(8 downto 5));
xDibu <= conv_integer (x(5 downto 1));
yDibu <= conv_integer (y (4 downto 0));

PROCESS (X, Y, test, invasores, col_nave, fila_invasores,col_X , estado,choque)

begin 

-- En esta primera condici�n dibujamos el tablero de ajedrez usando coordenadas de punto gordo

	if estado = "00" then
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
		end if;
			
			
	
		
-- En esta condici�n el juego est� en marcha y pintaremos la bala, invasores y marcianos
			
	elsif estado = "01" then 
		if col_x < 20 then
			if   fila_y = fila_invasores and invasores (col_X) = '1' then
				
				RGB <= marciano (yDibu, xDibu); -- Dibujo p�xel a p�xel
				--RGB <= "100"; 	
				--Para dibujar el punto gordo
				
			elsif fila_y = y_bala and col_x = x_bala then
		
				RGB <= "111"; 		 
				--Para dibujar el punto gordo
			elsif fila_y = fila_nave and col_x = col_nave then
		
				
				RGB <= "100"; 
--Para dibujar el punto gordo				
			else
		
				RGB <= "000";
			
			end if;
		else 
			RGB <= "000";
		end if;
		
-- Si entraramos en esta condici�n habr�amos ganado por tanto pintaremos la pantalla de verde

	elsif estado = "10" then
		if col_x < 20 and fila_y < 15 then
			--RGB <= winner (fila_y, col_x);
			RGB<="010";
		end if;
		
-- Si entraramos en esta condici�n habr�amos ganado por tanto pintaremos la pantalla de rojo
	
	elsif estado = "11" then
		if col_x < 20 and fila_y < 15 then
			--RGB <= loser (fila_y, col_x);
			RGB<="100";
		end if;
	
	end if;
end process; 


end Behavioral;


