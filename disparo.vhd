----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     19:33:58 08/12/2013 
-- Design Name: 
-- Module Name:    disparo - Behavioral 
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

--Esta entidad controla el comportamiento de la bala en el juego.

entity Disparo is

Port ( Clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       disparo_aux : in  STD_LOGIC;
       col_nave : in  integer range 0 to 19;
       cuenta : in  STD_LOGIC_VECTOR (23-1 downto 0);
       choque : in  STD_LOGIC;
       X_bala : out integer range 0 to 20;
		 Y_bala : out integer range 0 to 14
		 );

end Disparo;

architecture Behavioral of Disparo is




--el fin de cuenta es cuando todos los bits tienen valor 1
signal cuenta_fin_bala: STD_LOGIC_VECTOR (23-1 downto 0) :=(others => '1');
signal habilitacion : std_logic;
signal tiro : STD_LOGIC;
signal disparo_conf : std_logic;
signal Y_bala_aux : integer range 0 to 14;
SIGNAL q1, q2: STD_LOGIC;

begin

habilitacion <= '1' when cuenta = cuenta_fin_bala else '0';

process (Clk, reset)

--con tiro solo hay una señal en la pantalla
	

	begin

	if reset = '1' then
		tiro <= '0';
		X_bala <= 20;
		Y_bala_aux <= 13;
		
	elsif clk' event and clk = '1' then  
	
	--si no hay bala y hay disparo, ponemos la bala
		if tiro = '0' and disparo_conf = '1' then --no hay bala, hay disparo
			tiro <= '1';
			X_bala <= col_nave;
			Y_bala_aux <= 13;
		elsif tiro = '1' then --hay bala
			if habilitacion = '1' and choque = '0' and y_bala_aux > 0 then -- no se han chocado y la bala no ha 
																								--llegado al final de la pantalla
				y_bala_aux <= y_bala_aux - 1;
				
--no funciona (no se cumple nunca la habilitacion?)
		elsif habilitacion = '1' and choque = '1' then  -- hay choque
				tiro <= '0';
				y_bala_aux <= 14;
				X_bala <= 20;
		elsif habilitacion ='1' and y_bala_aux = 0 then -- fin de pantalla
				tiro <= '0';
				y_bala_aux <= 14;
				X_bala <= 20;
			end if;
		if tiro = '0' then
			y_bala_aux <= 14;
			x_bala <= 20;
			
		end if;	
		end if; 
					end if;		
	

end process;

process(clk, reset)

Begin
	--ver esquema con biestables pagina 21 guion de practicas
	if reset = '1' then
		q1 <= '0';
		q2 <= '0';
	elsif clk'event and clk ='1' then
		q1 <= disparo_aux;
		q2 <= q1;
	end if;
	
	disparo_conf <= (not q1) and q2;
end process;
	
	y_bala <= y_bala_aux;

end Behavioral;

