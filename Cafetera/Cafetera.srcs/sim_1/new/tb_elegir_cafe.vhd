----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2018 21:05:37
-- Design Name: 
-- Module Name: elegir_cafe_tb - Behavioral
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

entity tb_elegir_cafe is
end;

architecture bench of tb_elegir_cafe is

  component elegir_cafe
      generic(width: positive:=2);
      Port ( 
             solo : in STD_LOGIC;
             con_leche : in STD_LOGIC;
             reset : in STD_LOGIC;
             clk : in STD_LOGIC;
             OnOff : in STD_LOGIC;
             cafe_ok : out STD_LOGIC;
             cafe_code : out STD_LOGIC_VECTOR (1 downto 0));
  end component;

  signal solo: STD_LOGIC;
  signal con_leche: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal OnOff: STD_LOGIC;
  signal cafe_ok: STD_LOGIC;
  signal cafe_code: STD_LOGIC_VECTOR (1 downto 0);

  constant clock_period: time := 5 ns;
  signal stop_the_clock: boolean;

--    TYPE vtest is record
	--	code : std_logic_vector(width-1 DOWNTO 0);
--	END RECORD;
	
--	TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;	
--	CONSTANT test: vtest_vector := (
--			(code => "000"),
--			(code => "001"),
--			(code => "010"),
--			(code => "100"),
--			);

begin

  -- Insert values for generic parameters !!
  uut: elegir_cafe generic map ( width     =>  2)
                      port map ( solo      => solo,
                                 con_leche => con_leche,
                                 reset     => reset,
                                 clk       => clk,
                                 OnOff     => OnOff,
                                 cafe_ok   => cafe_ok,
                                 cafe_code => cafe_code );

  stimulus: process
  begin
  
    -- Put initialisation code here

    OnOff <= '0';
    solo <= '0';
    con_leche <= '0';
    
    
    -- Reset generation
    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    wait for 10 ns;
    
    OnOff <= '1';
    wait for 10 ns;

    for i in 0 to 1 loop
        solo <= '1';
        wait for 10 ns;
        solo <= '0';
        
        reset <= '1';
        wait for 5 ns;
        reset <='0'; 
        
        con_leche <= '1';
        wait for 10 ns;
        con_leche <= '0';
    end loop;
    
    OnOff <= '0';
    wait for 10 ns;
    
    -- Put test bench stimulus code here

    stop_the_clock <= false;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
