library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity codigo_ascii is
	port(
	   
		Cafe_Code: in std_logic_vector(1 downto 0);		--cafe binario
		ascii_0: out std_logic_vector(3 downto 0);
		ascii_1: out std_logic_vector(3 downto 0);
		ascii_2: out std_logic_vector(3 downto 0);
		ascii_3: out std_logic_vector(3 downto 0)
		);
end codigo_ascii;

architecture behavioral of codigo_ascii is
    begin
        WITH Cafe_Code SELECT
                ascii_0 <= "0111" WHEN "10",--CODIGO DE S
                           "0101" WHEN "11",--CODIGO DE L
                           "1111" WHEN OTHERS;
        WITH Cafe_Code SELECT
                ascii_1 <= "0110" WHEN "10", --CODIGO DE O
                           "0011" WHEN "11", --CODIGO DE A
                           "1111" WHEN OTHERS; 
        WITH Cafe_Code SELECT
                ascii_2 <= "0101" WHEN "10",--CODIGO DE L
                           "0100" WHEN "11",--CODIGO DE I
                           "1111" WHEN OTHERS; 
        WITH Cafe_Code SELECT
                ascii_3 <= "0110" WHEN "10", --CODIGO DE O
                           "1000" WHEN "11", --CODIGO DE T
                           "1111" WHEN OTHERS;                          
           
    
end behavioral;