library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_clk_divider is
end;

architecture bench of tb_clk_divider is

  component clk_divider
      Generic (frec: integer:=10000000);
      Port ( clk : in  STD_LOGIC;
             reset : in  STD_LOGIC;
             clk_out : out  STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal clk_out: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: clk_divider generic map ( frec    => 10000000 )
                      port map ( clk     => clk,
                                 reset   => reset,
                                 clk_out => clk_out );

  stimulus: process
  begin
  
    -- Put initialisation code here

    reset <= '1';
    wait for 5 ns;
    reset <= '0';
    wait for 5 ns;

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