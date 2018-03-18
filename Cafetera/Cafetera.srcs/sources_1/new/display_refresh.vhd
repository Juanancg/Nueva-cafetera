library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity display_refresh is
    Port ( clk : in  STD_LOGIC;
           segment_azucar : IN std_logic_vector(6 downto 0);
		   segment_1_letra : IN std_logic_vector(6 downto 0);
		   segment_2_letra : IN std_logic_vector(6 downto 0);
		   segment_3_letra : IN std_logic_vector(6 downto 0);   
		   segment_4_letra : IN std_logic_vector(6 downto 0);
           display_number : out  STD_LOGIC_VECTOR (6 downto 0);
           display_selection : out  STD_LOGIC_VECTOR (4 downto 0));
end display_refresh;

architecture Behavioral of display_refresh is

begin

	muestra_displays:process (clk, segment_azucar, segment_1_letra, segment_2_letra, segment_3_letra, segment_4_letra )
	variable cnt:integer range 0 to 4;
	begin
		if (clk'event and clk='1') then 
			if cnt=4 then
				cnt:=0;
			else
				cnt:=cnt+1;
			end if;
		end if;
		
		case cnt is
				when 0 => display_selection<="01111";
						    display_number<=segment_1_letra;
				
				when 1 => display_selection<="10111";
						    display_number<=segment_2_letra;
				
				when 2 => display_selection<="11011";
						    display_number<=segment_3_letra;
				
				when 3 => display_selection<="11101";
						    display_number<=segment_4_letra;	
						    
				when 4 => display_selection<="11110";
                            display_number<=segment_azucar;    						    			
			end case;

	end process;

end Behavioral;
