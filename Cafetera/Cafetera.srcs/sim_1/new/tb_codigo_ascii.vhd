library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_codigo_ascii is
end;

architecture bench of tb_codigo_ascii is

  component codigo_ascii
 
  	port(
  		Cafe_Code: in std_logic_vector(1 downto 0);
  		ascii_0: out std_logic_vector(3 downto 0);
  		ascii_1: out std_logic_vector(3 downto 0);
  		ascii_2: out std_logic_vector(3 downto 0);
  		ascii_3: out std_logic_vector(3 downto 0)
  		);
  end component;

  signal Cafe_Code: std_logic_vector(1 downto 0);
  signal ascii_0: std_logic_vector(3 downto 0);
  signal ascii_1: std_logic_vector(3 downto 0);
  signal ascii_2: std_logic_vector(3 downto 0);
  signal ascii_3: std_logic_vector(3 downto 0) ;

begin

  uut: codigo_ascii port map ( Cafe_Code => Cafe_Code,
                               ascii_0   => ascii_0,
                               ascii_1   => ascii_1,
                               ascii_2   => ascii_2,
                               ascii_3   => ascii_3 );

  stimulus: process
  begin
  
    -- Put initialisation code here
    cafe_code <= "10";
    wait for 20 ns;
    cafe_code <= "11";
    wait for 20 ns;
    cafe_code <="00";
    wait for 20 ns;

    -- Put test bench stimulus code here

    wait;
  end process;


end;