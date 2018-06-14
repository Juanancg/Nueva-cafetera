library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity elegir_cafe is
   
    generic(width: positive:=3);

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
signal codigo	: std_logic_vector(1 downto 0);
signal bit_ok : std_logic;
begin
    
	process (clk, reset, OnOff)
	begin
		if OnOff='0' then
			if reset = '1' then
				codigo<= "00";
				bit_ok <= '0';
			elsif rising_edge(clk) then
				if solo = '1' and con_Leche = '0' then 
				    codigo <= "10";
				    bit_ok <='1';
				elsif con_Leche = '1' and solo = '0' then 
					codigo <= "11";
					bit_ok <='1';	
				elsif con_Leche = '1' and solo = '1' then --Mensaje de ERROR
				    codigo<="01";
				    bit_ok<='0';	
				end if;
			end if;
		elsif OnOff = '1' then --Aqui poner un 0 para que no funcione
	      codigo <= "00";
		  bit_ok <= '0';
		end if;
	end process;
	cafe_code <= codigo;
	cafe_ok <= bit_ok;
end Behavioral;
