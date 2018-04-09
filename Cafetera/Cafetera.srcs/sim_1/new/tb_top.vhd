library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_TOP is
end;

architecture bench of tb_TOP is

  component TOP
      port  ( clk: in std_logic;
              reset: in std_logic;
              OnOff: in std_logic;
              solo: in std_logic;
              con_leche: in std_logic;
              s_azucar: in std_logic;
              p_azucar: in std_logic;
              m_azucar: in std_logic;
              display_number : out  STD_LOGIC_VECTOR (6 downto 0);
              display_selection : out  STD_LOGIC_VECTOR (4 downto 0);            
              led_on: out std_logic;
              bomba_cafe: out std_logic;
              bomba_leche: out std_logic;
              bomba_azucar: out std_logic;
              cafe_terminado: out std_logic);
  end component;

  signal clk: std_logic;
  signal reset: std_logic;
  signal OnOff: std_logic;
  signal solo: std_logic;
  signal con_leche: std_logic;
  signal s_azucar: std_logic;
  signal p_azucar: std_logic;
  signal m_azucar: std_logic;
  signal display_number: STD_LOGIC_VECTOR (6 downto 0);
  signal display_selection: STD_LOGIC_VECTOR (4 downto 0);
  signal led_on: std_logic;
  signal bomba_cafe: std_logic;
  signal bomba_leche: std_logic;
  signal bomba_azucar: std_logic;
  signal cafe_terminado: std_logic;
constant CLK_PERIOD :time := 10 ns;
begin

  uut: TOP port map ( clk               => clk,
                      reset             => reset,
                      OnOff             => OnOff,
                      solo              => solo,
                      con_leche         => con_leche,
                      s_azucar          => s_azucar,
                      p_azucar          => p_azucar,
                      m_azucar          => m_azucar,
                      display_number    => display_number,
                      display_selection => display_selection,
                      led_on            => led_on,
                      bomba_cafe        => bomba_cafe,
                      bomba_leche       => bomba_leche,
                      bomba_azucar      => bomba_azucar,
                      cafe_terminado    => cafe_terminado );
  clk_process: process
                      begin
                          wait for 0.5 * CLK_PERIOD;
                          CLK <= '0';
                          wait for 0.5 * CLK_PERIOD;
                          CLK <= '1';
                      end process;
  stimulus: process
  begin
    
    reset<='1';
    wait for 10 ns;
    -- Put initialisation code here
    OnOff<='0';
    reset<='0';
    solo<='0';
    con_leche<='0';
    s_azucar<='0';
    p_azucar<='0';
    m_azucar<='0';
    -- Put test bench stimulus code here
    wait for 100 ns;
   -- reset <='0';
    OnOff<='1';
    wait for 350 ns;
    solo <='1';
    wait for 100ns;
    m_azucar <='1';
    wait for 200 ns;
    wait;
  end process;


end;