library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity decoder is
    Port ( code : in  STD_LOGIC_VECTOR (3 downto 0);
           led : out  STD_LOGIC_VECTOR (6 downto 0));
end decoder;

architecture Behavioral of decoder is

begin
	WITH code SELECT
		led <= "1000000" WHEN "0000",  --0
				"1111001" WHEN "0001", --1
				"0100100" WHEN "0010", --2
				"0001000" WHEN "0011", --A 
				"1111001" WHEN "0100", --I
				"1000111" WHEN "0101", --L
				"1000000" WHEN "0110", --O
				"0010010" WHEN "0111", --S 
				"0000111" WHEN "1000", --T 
				"0001110" WHEN "1001", --F Añadido 08/06/2018
				"1111111" WHEN "1010", --Máquina apagada
				"0111111" WHEN others;

end Behavioral;