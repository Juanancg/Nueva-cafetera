----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2018 19:19:08
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    port  ( clk: in std_logic;
            reset: in std_logic;
            OnOff: in std_logic;
            solo: in std_logic;
            con_leche: in std_logic;
            s_azucar: in std_logic;
            p_azucar: in std_logic;
            m_azucar: in std_logic;
            var: out STD_LOGIC_VECTOR (2 downto 0):="111";
            display_number : out  STD_LOGIC_VECTOR (6 downto 0);
            display_selection : out  STD_LOGIC_VECTOR (4 downto 0);            
            led_on: out std_logic;
            bomba_cafe: out std_logic;
            bomba_leche: out std_logic;
            bomba_azucar: out std_logic;
            cafe_terminado: out std_logic);
end TOP;

architecture Behavioral of TOP is

	COMPONENT clk_divider
    GENERIC (frec: integer:=5); --50000000
    PORT(
         clk : IN std_logic;
         reset : IN std_logic;          
         clk_out : OUT std_logic
    );
    END COMPONENT;
    
    COMPONENT elegir_azucar
    generic(
        width: positive:= 3
        );
    PORT(
        reset    : in std_logic;        
        clk        : in std_logic;        -- Clock in
        OnOff: in std_logic;        --Encendido/apagado
        S_Azucar: in std_logic;
        P_Azucar: in std_logic;
        M_Azucar: in std_logic;
        Azucar_Ok: out std_logic;        
        Azucar_Code: out std_logic_vector(width  downto 0)        
        );
    END COMPONENT;
    
    COMPONENT elegir_cafe       
    generic(width: positive:=2);
    PORT ( 
       solo : in STD_LOGIC;
       con_leche : in STD_LOGIC;
       reset : in STD_LOGIC;
       clk : in STD_LOGIC;
       OnOff : in STD_LOGIC;
       cafe_ok : out STD_LOGIC;
       cafe_code : out STD_LOGIC_VECTOR (1 downto 0));
    END COMPONENT;
    
    COMPONENT codigo_ascii
    PORT(
       Cafe_Code: in std_logic_vector(1 downto 0);       
       ascii_0: out std_logic_vector(3 downto 0);
       ascii_1: out std_logic_vector(3 downto 0);
       ascii_2: out std_logic_vector(3 downto 0);
       ascii_3: out std_logic_vector(3 downto 0)
       );
    END COMPONENT;
    
	COMPONENT decoder
    PORT(
        code : IN std_logic_vector(3 downto 0);          
        led : OUT std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    
    COMPONENT display_refresh 
    PORT ( 
        clk : in  STD_LOGIC;
        segment_azucar : IN std_logic_vector(6 downto 0);
        segment_1_letra : IN std_logic_vector(6 downto 0);
        segment_2_letra : IN std_logic_vector(6 downto 0);
        segment_3_letra : IN std_logic_vector(6 downto 0);   
        segment_4_letra : IN std_logic_vector(6 downto 0);
        display_number : out  STD_LOGIC_VECTOR (6 downto 0);
        display_selection : out  STD_LOGIC_VECTOR (4 downto 0));
    END COMPONENT;      
    
    COMPONENT maquina_estados
    PORT ( OnOff : in STD_LOGIC;
           clk : in STD_LOGIC;
           --clk_out: in STD_LOGIC;
           reset : in STD_LOGIC;
           cafe_ok : in STD_LOGIC;
           azucar_ok : in STD_LOGIC;
           cafe_code : in STD_LOGIC_VECTOR (1 downto 0);
           Azucar_Code: in STD_LOGIC_VECTOR(3 downto 0);
           led_on : out STD_LOGIC;
           bomba_cafe : out STD_LOGIC;
           bomba_azucar : out STD_LOGIC;
           bomba_leche : out STD_LOGIC;
           cafe_terminado : out STD_LOGIC);
    END COMPONENT;
    
    signal clk_out: STD_LOGIC;
    signal clk_displays: STD_LOGIC;
    signal azucar_code: STD_LOGIC_VECTOR(3 downto 0);
    signal azucar_ok: STD_LOGIC;
    signal cafe_code : STD_LOGIC_VECTOR (1 downto 0);
    signal cafe_ok : STD_LOGIC;
    signal ascii_0:  std_logic_vector(3 downto 0);
    signal ascii_1:  std_logic_vector(3 downto 0);
    signal ascii_2:  std_logic_vector(3 downto 0);
    signal ascii_3:  std_logic_vector(3 downto 0);
    signal segment_azucar : std_logic_vector(6 downto 0);
    signal segment_1_letra :  std_logic_vector(6 downto 0);
    signal segment_2_letra :  std_logic_vector(6 downto 0);
    signal segment_3_letra :  std_logic_vector(6 downto 0);   
    signal segment_4_letra :  std_logic_vector(6 downto 0);
begin
    
    clkdivider: clk_divider
        generic map(
            frec => 5)--50000000
        port map(
            clk => clk,
            reset => reset,
            clk_out => clk_out);
            
    clkdivider_display: clk_divider
        generic map(
            frec => 100000)--100000
        port map(
            clk => clk,
            reset => reset,
            clk_out => clk_displays);
                        
    elegirazucar: elegir_azucar
        generic map(
            width => 3)   
        port map(
            reset => reset,    
            clk  => clk,        -- Clock in
            OnOff => OnOff,  --Encendido/apagado
            S_Azucar => S_azucar,
            P_Azucar => p_azucar,
            M_Azucar => M_azucar,
            Azucar_Ok => azucar_ok,     
            Azucar_Code => Azucar_code);
            
    elegircafe: elegir_cafe
        generic map(
            width => 2)   
        port map(
            reset => reset,    
            clk  => clk,        -- Clock in
            OnOff => OnOff,  --Encendido/apagado
            solo => solo,
            con_leche => con_leche,
            cafe_ok => cafe_ok,   
            cafe_code => cafe_code);     

    codascii: codigo_ascii
        port map(
           Cafe_Code => cafe_code,       
           ascii_0 => ascii_0,
           ascii_1 => ascii_1,
           ascii_2 => ascii_2,
           ascii_3 => ascii_3);

    dec_azucar: decoder
        port map(
           code => azucar_code,
           led => segment_azucar);    

    dec_1letra: decoder
        port map(
           code => ascii_0,
           led => segment_1_letra);            
            
    dec_2letra: decoder
        port map(
            code => ascii_1,
            led => segment_2_letra);   

    dec_3letra: decoder
        port map(
           code => ascii_2,
           led => segment_3_letra);  
           
     dec_4letra: decoder
        port map(
            code => ascii_3,
            led => segment_4_letra); 
              
     disp_refresh: display_refresh
        port map ( 
             clk => clk_displays,
             segment_azucar => segment_azucar,
             segment_1_letra => segment_1_letra,
             segment_2_letra => segment_2_letra,
             segment_3_letra => segment_3_letra,  
             segment_4_letra => segment_4_letra,
             display_number => display_number,
             display_selection => display_selection);
          
    maquinaestados: maquina_estados
        port map(
            OnOff => OnOff,
            clk => clk,
            --clk_out => clk, --Aqui clk_out
            reset => reset,
            cafe_ok => cafe_ok,
            azucar_ok => azucar_ok,
            cafe_code => cafe_code,
            Azucar_Code => azucar_code,
            led_on => led_on,
            bomba_cafe => bomba_cafe,
            bomba_azucar => bomba_azucar,
            bomba_leche => bomba_leche,
            cafe_terminado => cafe_terminado);  
                                                          
end Behavioral;
