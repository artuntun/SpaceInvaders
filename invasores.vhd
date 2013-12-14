----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:30:31 12/03/2012 
-- Design Name: 
-- Module Name:    invasores - Behavioral 
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

-- Esta entidad se encarga del control del movimiento de los invasores y de su interrelación con la bala
entity invasores is

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
		
end invasores;
architecture Behavioral of invasores is

-- Todas las señales son para poder trabajar dentro del proceso 

signal Y : std_logic_vector (4 downto 0);
signal fila_invasores_aux: integer range 0 to 14;
constant numbit: integer := 20;
signal habilitacion : STD_LOGIC;
signal cuenta_fin: STD_LOGIC_VECTOR (25-1 downto 0) :=(others => '1');
signal invasores_aux: std_logic_vector (0 to 19);


begin
Y <= conv_std_logic_vector ( fila_invasores_aux, 5);

habilitacion <= '1' when cuenta = cuenta_fin else '0';



process (clk, reset)

variable choque_aux : std_logic;

begin

	if reset = '1' then --aqui situamos los invasores en su posición inicial 
		fila_invasores_aux <= 0;
		invasores_aux <= "11111111110000000000";
		choque_aux := '0';
	elsif clk'event and clk = '1' then
		
		if inicializacion = '1' then
			fila_invasores_aux <= 0;
			invasores_aux <= "11111111110000000000";
			choque_aux := '0';
			ganado<= '0';
							perdido <= '0'; 
		else 
			-- Comprobamos que haya llegado al fin de la cuenta, que no haya llegado al final de la 
			--pantalla por la derecha y que la fila es impar para mover los invasores
			if habilitacion = '1' and invasores_aux(19) = '0' and Y(0) ='0' then
				invasores_aux <= '0' & invasores_aux(0 to (numbit - 2)); --aquí se desplazarán los invasores
					ganado<= '0';
							perdido <= '0'; 																		-- horizontalmente hacia la derecha
			end if;
					-- bajamos una fila si no han llegado a la fila de la nave
			if fila_invasores_aux < 14 and habilitacion = '1' and Y(0) ='0' then
				if invasores_aux(19) = '1' then
							fila_invasores_aux  <= fila_invasores_aux +1;  --aquí se desplazarán los invasores
							ganado<= '0';
							perdido <= '0'; 											-- verticalmente
				end if;
			elsif fila_invasores_aux >= 14 then --aquí los invasores llegarían al final de la pantalla y perderías
						invasores_aux <= (others => '0');
						perdido <= '1';
			elsif invasores_aux = "00000000000000000000" and fila_invasores_aux < 14 then
						ganado <= '1'; --aquí hemos matado a todos los invasores por tanto hemos ganado
						
			end if;
					
			-- Comprobamos que haya llegado al fin de la cuenta, que no haya llegado al final de la 
			--pantalla por la izquierda y que la fila es par para mover los invasores
			
			if habilitacion = '1' and invasores_aux(0) = '0' and Y(0) = '1' then
				invasores_aux <= invasores_aux(1 to (numbit - 1)) & '0';--aquí se desplazarán los invasores
				ganado <= '0';
				perdido <= '0';														-- horizontalmente hacia la izquierda
			end if;
				--bajamos una fila si no ha llegado a la fila de la nave
			if invasores_aux(0) = '1' and habilitacion = '1' and  Y(0) = '1' then
				
				if fila_invasores_aux < 14 then --aquí se desplazarán los invasores
																							-- verticalmente
						fila_invasores_aux  <= fila_invasores_aux  + 1;	
						ganado<= '0';
						perdido <= '0';
				end if;
			elsif fila_invasores_aux >= 14 then		--aquí los invasores llegarían al final de la pantalla y perderías
						invasores_aux <= (others => '0');
						perdido <= '1';
			elsif invasores_aux = "00000000000000000000" and fila_invasores_aux < 14 then
						ganado <= '1';--aquí hemos matado a todos los invasores por tanto hemos ganado
								
			end if;
		
		end if;
		
		-- En esta condición vamos a ver cuando se produce un choque y ese caso eliminar el invasor correspondiente
		--si la bala llega a la misma altura (fila) que los invasores
		if y_bala = fila_invasores_aux then
		--y si en la columna de la bala (posicion horizontal) hay un invasor
			if invasores_aux(x_bala)='1' then
				choque_aux := '1';
			end if;
		end if;		
		choque <= choque_aux;				
		if choque_aux = '1' then
		--quitamos al invasor correspondiente
			CASE x_bala is
					when 0 => invasores_aux(0) <= '0';
					when 1 => invasores_aux(1) <= '0';
					when 2 => invasores_aux(2) <= '0';
					when 3 => invasores_aux(3) <= '0';
					when 4 => invasores_aux(4) <= '0';
					when 5 => invasores_aux(5) <= '0';
					when 6 => invasores_aux(6) <= '0';
					when 7 => invasores_aux(7) <= '0';
					when 8 => invasores_aux(8) <= '0';
					when 9 => invasores_aux(9) <= '0';
					when 10 => invasores_aux(10) <= '0';
					when 11 => invasores_aux(11) <= '0';
					when 12 => invasores_aux(12) <= '0';
					when 13 => invasores_aux(13) <= '0';
					when 14 => invasores_aux(14) <= '0';
					when 15 => invasores_aux(15) <= '0';
					when 16 => invasores_aux(16) <= '0';
					when 17 => invasores_aux(17) <= '0';
					when 18 => invasores_aux(18) <= '0';
					when 19 => invasores_aux(19) <= '0';
					when others => invasores_aux <= (others => '1');
			END CASE;			
			choque_aux := '0';
		end if;
	end if;
	
	choque <= choque_aux;
	
end process;

invasores <= invasores_aux;
fila_invasores <= fila_invasores_aux;


end Behavioral;

