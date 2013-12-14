----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     19:33:58 08/12/2013  
-- Design Name: 
-- Module Name:    nave - Behavioral 
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


-- Esta entidad se encarga del comportamiento de la nave

entity nave is
    Port ( derecha : in  STD_LOGIC;
           izquierda : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;      
			  col_nave : out integer range 0 to 19;
			  inicio: in  STD_LOGIC
			  );
end nave;

architecture Behavioral of nave is

-- Estas señales van a ser útiles para posteriormente diseñar el conformador de pulsos y trabajar
-- con la señales durante el proceso

SIGNAL q1: STD_LOGIC;
SIGNAL q2, q3, q4: STD_LOGIC;
SIGNAL derecha_conf, izquierda_conf : std_logic;
SIGNAL col_nave_aux : integer range 0 to 19;

begin
PROCESS (clk, reset, col_nave_aux)
begin

-- En este proceso nos encargaremos del movimiento de la nave

if reset = '1' then

	col_nave_aux <= 10; --posición inicial 

elsif clk'event and clk = '1' then

	if inicio = '1' then
	
		col_nave_aux <= 10;
		
	elsif derecha_conf = '1' and col_nave_aux <=18 then
	
		col_nave_aux <= col_nave_aux + 1; -- Desplazmiento hacia la derecha
		
	elsif izquierda_conf = '1' and col_nave_aux >=1 then 
	
		col_nave_aux <= col_nave_aux - 1; -- Desplazamiento hacia la izquierda
		
	end if;
end if;
		col_nave <= col_nave_aux; 
end process;
	
-- En este proceso diseñaremos un conformador de pulsos que se encargará de que la nave solo se 
-- desplace una posición cada vez que pulsemos el botón
	
process(clk, reset)

Begin
	--ver esquema con biestables pagina 21 guion de practicas
	if reset = '1' then
		q1 <= '0';
		q2 <= '0';
	elsif clk'event and clk ='1' then
		q1 <= derecha;
		q2 <= q1;
	end if;
end process;
--se origina un pulso que dura solo un periodo de reloj cada vez que se pulsa y se suelta el boton derecho
derecha_conf <= (not q1) and q2;
		
process(clk, reset)

Begin
	
	if reset = '1' then
		q3 <= '0';
		q4 <= '0';
	elsif clk'event and clk ='1' then
		q3 <= izquierda;
		q4 <= q3;
	end if;
end process;
--se origina un pulso que dura solo un periodo de reloj cada vez que se pulsa y se suelta el boton izquierdo
izquierda_conf <= (not q3) and q4;
		
		
end Behavioral;

