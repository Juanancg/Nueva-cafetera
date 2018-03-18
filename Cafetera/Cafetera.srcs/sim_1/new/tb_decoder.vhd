library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY tb_decoder IS
END tb_decoder;
 
ARCHITECTURE behavior OF tb_decoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder
    PORT(
         code : IN  std_logic_vector(3 downto 0);
         led : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal code : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal led : std_logic_vector(6 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   TYPE vtest is record
		code : std_logic_vector(3 DOWNTO 0);
		led : std_logic_vector(6 DOWNTO 0);
	END RECORD;

	TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;

	CONSTANT test: vtest_vector := (
				(code => "0000", led => "0000001"),
				(code => "0001", led => "1001111"),
				(code => "0010", led => "0010010"),
				(code => "0011", led => "0001000"),
				(code => "0100", led => "1001111"),
				(code => "0101", led => "1110001"),
				(code => "0110", led => "0000001"),
				(code => "0111", led => "0100100"),
				(code => "1000", led => "0000001"),
				(code => "1001", led => "0000100"),-- a partir de 10 damos codigo error
				(code => "1010", led => "1111110"), 
				(code => "1011", led => "1111110"),
				(code => "1100", led => "1111110"),
				(code => "1101", led => "1111110"),
				(code => "1110", led => "1111110"),
				(code => "1111", led => "1111110")
		);
	 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder PORT MAP (
          code => code,
          led => led
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		FOR i IN 0 TO test'HIGH LOOP
			code <= test(i).code;
			WAIT FOR 20 ns;
			
				
		END LOOP;
		


      wait;
   end process;

END;
