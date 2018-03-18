library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity elegir_azucar is
	generic(
		width: positive:= 3
		);
	port(
		reset	: in std_logic;		
		clk		: in std_logic;		-- Clock in
		OnOff: in std_logic;		--Encendido/apagado
		S_Azucar: in std_logic;
		P_Azucar: in std_logic;
		M_Azucar: in std_logic;
		Azucar_Ok: out std_logic;		--bit_listo
		Azucar_Code: out std_logic_vector(width  downto 0)		--cantidad de azucar
		);
end elegir_azucar;

architecture behavioral of elegir_azucar is
	signal codigo	: std_logic_vector(width downto 0);
    signal bit_ok : std_logic; 
begin

	process (clk, reset, OnOff)
	begin
		if OnOff='1' then
			if reset = '1' then 
				codigo <= "1111";
				bit_ok<='0';
				
			elsif rising_edge(clk) then
				if S_Azucar = '1' then
					codigo<= "0000";
					bit_ok<='1';
										
				elsif P_Azucar = '1' then
					codigo<= "0001";
					bit_ok<='1';
										
				elsif M_Azucar = '1' then
					codigo<= "0010";
					bit_ok<='1';
										
				end if;
			end if;
			
		elsif OnOff='0' then 
			bit_ok<='0';
			codigo<="1111";
			
		end if;
	end process;
	
	Azucar_Code <= codigo;
    Azucar_Ok <= bit_ok; 
end behavioral;

		
