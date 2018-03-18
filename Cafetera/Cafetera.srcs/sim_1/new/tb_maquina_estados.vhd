----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2018 14:07:36
-- Design Name: 
-- Module Name: maquina_estados_tb - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_maquina_estados is
end;

architecture bench of tb_maquina_estados is

  component maquina_estados
      Port ( OnOff : in STD_LOGIC;
             clk : in STD_LOGIC;
             clk_out: in STD_LOGIC;
             reset : in STD_LOGIC;
             cafe_ok : in STD_LOGIC;
             azucar_ok : in STD_LOGIC;
             cafe_code : in STD_LOGIC_VECTOR (1 downto 0);
             Azucar_Code: in STD_LOGIC_VECTOR(2 downto 0);
             led_on : out STD_LOGIC;
             bomba_cafe : out STD_LOGIC;
             bomba_azucar : out STD_LOGIC;
             bomba_leche : out STD_LOGIC;
             cafe_terminado : out STD_LOGIC);
  end component;

  signal OnOff: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal clk_out: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal cafe_ok: STD_LOGIC;
  signal azucar_ok: STD_LOGIC;
  signal cafe_code: STD_LOGIC_VECTOR (1 downto 0);
  signal Azucar_Code: STD_LOGIC_VECTOR(2 downto 0);
  signal led_on: STD_LOGIC;
  signal bomba_cafe: STD_LOGIC;
  signal bomba_azucar: STD_LOGIC;
  signal bomba_leche: STD_LOGIC;
  signal cafe_terminado: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: maquina_estados port map ( OnOff          => OnOff,
                                  clk            => clk,
                                  clk_out        => clk_out,
                                  reset          => reset,
                                  cafe_ok        => cafe_ok,
                                  azucar_ok      => azucar_ok,
                                  cafe_code      => cafe_code,
                                  Azucar_Code    => Azucar_Code,
                                  led_on         => led_on,
                                  bomba_cafe     => bomba_cafe,
                                  bomba_azucar   => bomba_azucar,
                                  bomba_leche    => bomba_leche,
                                  cafe_terminado => cafe_terminado );

  stimulus: process
  begin
  
    -- Put initialisation code here
    OnOff <= '0';
    reset <= '0';
    cafe_ok <= '0';
    azucar_ok <= '0';
    cafe_code <= "00";
    Azucar_Code <= "000";
    


    OnOff <= '1';
    wait for 10 ns;
    OnOff <= '0';
    wait for 20 ns;
    
    OnOff <= '1';

    wait for 40 ns;

    wait for 20 ns;
    cafe_code <= "11";
    cafe_ok <= '1';
    Azucar_Code <= "100";
    azucar_ok <= '1';
    wait for 160 ns;
    reset<='1';
    cafe_ok <= '0';
    azucar_ok <= '0';
    wait for 80 ns;
    reset <= '0';
    wait for 40 ns;
        cafe_code <= "10";
cafe_ok <= '1';
Azucar_Code <= "001";
azucar_ok <= '1';
wait for 70 ns;


    -- Put test bench stimulus code here
   stop_the_clock <= false;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      clk_out <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;