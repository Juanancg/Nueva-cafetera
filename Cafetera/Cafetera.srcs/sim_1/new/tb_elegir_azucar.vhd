library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_elegir_azucar is
generic(
  		width: positive:= 3
  		);
end;

architecture bench of tb_elegir_azucar is

  component elegir_azucar
  	generic(
  		width: positive:= 3
  		);
  	port(
  		reset	: in std_logic;		
  		clk		: in std_logic;
  		OnOff: in std_logic;
  		S_Azucar: in std_logic;
  		P_Azucar: in std_logic;
  		M_Azucar: in std_logic;
  		Azucar_Ok: out std_logic;
  		Azucar_Code: out std_logic_vector(width-1 downto 0)
  		);
  end component;
  
  signal reset: std_logic;
  signal clk: std_logic;
  signal OnOff: std_logic;
  signal S_Azucar: std_logic;
  signal P_Azucar: std_logic;
  signal M_Azucar: std_logic;
  signal Azucar_Ok: std_logic;
  signal Azucar_Code: std_logic_vector(width-1 downto 0) ;

  constant clock_period: time := 5 ns;
  signal stop_the_clock: boolean;

--	TYPE vtest is record
--		code : std_logic_vector(width-1 DOWNTO 0);
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
  uut: elegir_azucar generic map ( width       =>  3)
                        port map ( reset       => reset,
                                   clk         => clk,
                                   OnOff       => OnOff,
                                   S_Azucar    => S_Azucar,
                                   P_Azucar    => P_Azucar,
                                   M_Azucar    => M_Azucar,
                                   Azucar_Ok   => Azucar_Ok,
                                   Azucar_Code => Azucar_Code );

  stimulus: process
  begin
  
    -- Put initialisation code here
    -- EDIT Adapt initialization as needed
    OnOff <= '0';
    S_Azucar <= '0';
    P_Azucar <= '0';
    M_Azucar <= '0';

    -- Reset generation
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 20 ns;  
      
    OnOff <= '1';
    wait for 5 ns;
    
    FOR I IN 0 TO 1 LOOP
        S_Azucar<='1';
            wait for 5 ns;
            --ASSERT CAR_LED = test(1).code
            -- REPORT "Salida incorrecta."
            --SEVERITY FAILURE;  
        S_Azucar<='0';   
        wait for 5 ns  ;
             
        P_Azucar<='1';
            wait for 5 ns;
            --ASSERT CAR_LED = test(2).code
            -- REPORT "Salida incorrecta."
            --SEVERITY FAILURE;  
        P_Azucar<='0';   
        wait for 5 ns ;
        
        M_Azucar<='1';
            wait for 5 ns;
            --ASSERT CAR_LED = test(3).code
            -- REPORT "Salida incorrecta."
            --SEVERITY FAILURE;  
        M_Azucar<='0';   
        wait for 5 ns ;
        
        wait for 5 ns;
        
    End loop;
    
    reset <= '1';
    wait for 20 ns;
    
    OnOff <= '0';
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