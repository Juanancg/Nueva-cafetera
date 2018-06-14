library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity codigo_ascii is
	port(
	    OnOff: in std_logic ;
		Cafe_Code: in std_logic_vector(1 downto 0);		--cafe binario
		ascii_0: out std_logic_vector(3 downto 0);
		ascii_1: out std_logic_vector(3 downto 0);
		ascii_2: out std_logic_vector(3 downto 0);
		ascii_3: out std_logic_vector(3 downto 0)
		);
end codigo_ascii;

architecture behavioral of codigo_ascii is
    begin
--        WITH Cafe_Code SELECT
--                ascii_0 <= "0111" WHEN "10", --CODIGO DE S
--                           "0101" WHEN "11", --CODIGO DE L
--                           "1001" WHEN "01", --CODIGO DE F
--                          -- "1010" WHEN "00", --CODIGO DE APAGADO
--                           "1111" WHEN OTHERS;
                           
       ascii_0<= "0111" WHEN Cafe_Code="10" and OnOff='1' ELSE
                                     "0101" WHEN Cafe_Code="11" and OnOff='1' ELSE
                                     "1001" WHEN Cafe_Code="01" and OnOff='1' ELSE
                                     "1010" WHEN OnOff='0' ELSE  
                                     "1111";
--        WITH Cafe_Code SELECT
--                ascii_1 <= "0110" WHEN "10", --CODIGO DE O
--                           "0011" WHEN "11", --CODIGO DE A
--                           "0011" WHEN "01", --CODIGO DE A
--                          -- "1010" WHEN "00", --CODIGO DE APAGADO
--                           "1111" WHEN OTHERS; 
                           
       ascii_1<= "0110" WHEN Cafe_Code="10" and OnOff='1' ELSE
                         "0011" WHEN Cafe_Code="11" and OnOff='1' ELSE
                         "0011" WHEN Cafe_Code="01" and OnOff='1' ELSE
                         "1010" WHEN OnOff='0' ELSE  
                         "1111";
--        WITH Cafe_Code SELECT
--                ascii_2 <= "0101" WHEN "10", --CODIGO DE L
--                           "0100" WHEN "11", --CODIGO DE I
--                           "0100" WHEN "01", --CODIGO DE I
--                          -- "1010" WHEN "00", --CODIGO DE APAGADO
--                           "1111" WHEN OTHERS;
                           
       ascii_2<= "0101" WHEN Cafe_Code="10" and OnOff='1' ELSE
                         "0100" WHEN Cafe_Code="11" and OnOff='1' ELSE
                         "0100" WHEN Cafe_Code="01" and OnOff='1' ELSE
                         "1010" WHEN OnOff='0' ELSE  
                         "1111";
--        WITH Cafe_Code SELECT
--                ascii_3 <= "0110" WHEN "10", --CODIGO DE O
--                           "1000" WHEN "11", --CODIGO DE T
--                           "0101" WHEN "01", --CODIGO DE L
--                         --  "1010" WHEN "00", --CODIGO DE APAGADO
--                           "1111" WHEN OTHERS;
       ascii_3<= "0110" WHEN Cafe_Code="10" and OnOff='1' ELSE
                              "1000" WHEN Cafe_Code="11" and OnOff='1' ELSE
                              "0101" WHEN Cafe_Code="01" and OnOff='1' ELSE
                              "1010" WHEN OnOff='0' ELSE  
                              "1111";

                                            
           
    
end behavioral;