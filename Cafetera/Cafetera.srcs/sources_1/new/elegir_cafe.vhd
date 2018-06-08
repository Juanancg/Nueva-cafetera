----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2018 20:51:44
-- Design Name: 
-- Module Name: elegir_cafe - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity elegir_cafe is
   
    generic(width: positive:=2);

    Port ( 
           solo : in STD_LOGIC;
           con_leche : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           OnOff : in STD_LOGIC;
           cafe_ok : out STD_LOGIC;
           cafe_code : out STD_LOGIC_VECTOR (1 downto 0));
end elegir_cafe;

architecture Behavioral of elegir_cafe is
begin
	process (clk, reset, OnOff)
	   variable codigo	: std_logic_vector(width - 1 downto 0);
	begin
		if OnOff='1' then
			if reset = '1' then
				codigo := "00";
				cafe_ok <= '0';
			elsif rising_edge(clk) then
				if solo = '1' and con_Leche = '0' then --Aquí he modificado J
				    codigo := "10";
				    cafe_ok <='1';
				elsif con_Leche = '1' and solo = '0' then --Aquí he modificado J
					codigo := "11";
					cafe_ok <='1';	
				elsif con_Leche = '1' and solo = '1' then
				    codigo:="01";	
				end if;
			end if;
		else 
		  cafe_ok <= '0';
		  codigo := "00";
		end if;
		cafe_code <= codigo;
	end process;
end Behavioral;
