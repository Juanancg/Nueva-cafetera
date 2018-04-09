----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2018 19:02:30
-- Design Name: 
-- Module Name: maquina_estados - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity maquina_estados is
    Port ( OnOff : in STD_LOGIC;
           clk : in STD_LOGIC;
           clk_out: in STD_LOGIC;
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
end maquina_estados;

architecture Behavioral of maquina_estados is
 type ESTADOS is (MAQUINA_OFF, TIPO_CAFE, SIRVIENDO_CAFE, SIRVIENDO_LECHE, CANTIDAD_AZUCAR, SIRVIENDO_AZUCAR, ESPERA_NUEVOCAFE);
 signal estado_actual: ESTADOS;
 signal estado_siguiente: ESTADOS;

 signal carga: integer range 0 to 15;
 signal cuenta: integer range 0 to 15;
 signal enable: std_logic;
 signal salida:std_logic;
  
 begin
   process(reset,clk) --Asignación de estados
   begin 
     if reset='1' then
	   estado_actual <= TIPO_CAFE;  
     elsif rising_edge(clk) then
	   estado_actual <= estado_siguiente;
     end if;
   end process;

   process(cafe_ok, azucar_ok, estado_actual, OnOff, salida)  --Evolución de los estados
   begin 
   
     estado_siguiente <= estado_actual;
     case estado_actual is

	when MAQUINA_OFF =>
	  if OnOff = '1' then
	    estado_siguiente <= TIPO_CAFE;
          end if;
		
	when TIPO_CAFE =>
	  if cafe_ok = '1' then
	    estado_siguiente <= SIRVIENDO_CAFE;
      end if;
      if OnOff = '0' then 
        estado_siguiente <= MAQUINA_OFF;
      end if;    
      
	when SIRVIENDO_CAFE =>
      if salida = '1' and cafe_code = "11" then       
        estado_siguiente <= SIRVIENDO_LECHE;
      end if;
      if salida = '1' and cafe_code = "10" then
        estado_siguiente <= CANTIDAD_AZUCAR;
      end if;        
      if OnOff = '0' then 
        estado_siguiente <= MAQUINA_OFF;
      end if;  
    
    when SIRVIENDO_LECHE =>
        if salida = '1' then 
            estado_siguiente <= CANTIDAD_AZUCAR;
        end if;
       if OnOff = '0' then 
          estado_siguiente <= MAQUINA_OFF;
       end if;      
               
	when CANTIDAD_AZUCAR =>
	   if(azucar_ok = '1' and azucar_code = "0000") then
	       estado_siguiente <= ESPERA_NUEVOCAFE;
	   elsif(azucar_ok = '1'and (azucar_code = "0001" or azucar_code = "0010")) then
	    estado_siguiente <= SIRVIENDO_AZUCAR;
      end if;
      if OnOff = '0' then 
        estado_siguiente <= MAQUINA_OFF;
      end if;    
      
    when SIRVIENDO_AZUCAR =>
        if(salida = '1') then
            estado_siguiente <= ESPERA_NUEVOCAFE;
        end if;
        if OnOff = '0' then 
            estado_siguiente <= MAQUINA_OFF;
        end if;            
         
	when ESPERA_NUEVOCAFE =>
	  if reset ='1' then
	    estado_siguiente <= TIPO_CAFE;
      end if;
      if OnOff = '0' then 
        estado_siguiente <= MAQUINA_OFF;
      end if;  

	when others =>
	    estado_siguiente <= MAQUINA_OFF;

    end case;
   end process;


   process(estado_actual)   --Asignación de las salidas
   begin
     case estado_actual is
     
	   when MAQUINA_OFF =>
           led_on <= '0';
	       bomba_cafe <= '0';
	       bomba_leche <= '0';
	       bomba_azucar <= '0';
	       cafe_terminado <= '0';
	       
       when TIPO_CAFE =>
           led_on <= '1';
	       bomba_cafe <= '0';
	       bomba_leche <= '0';
	       bomba_azucar <= '0';
	       cafe_terminado <= '0';
	       
       when CANTIDAD_AZUCAR => 
           led_on <= '1';
	       bomba_cafe <= '0';
	       bomba_leche <= '0';
	       bomba_azucar <= '0';
	       cafe_terminado <= '0';
	       
       when SIRVIENDO_CAFE => 
         led_on <= '1';
         carga <= 5;
         bomba_cafe <='1';
         enable <= '1';
         if(salida ='1') then
            bomba_cafe <= '0';
            enable <= '0';
         end if;  
	     cafe_terminado <= '0';
	       
	   when SIRVIENDO_LECHE =>
	       
	       led_on <= '1';
	       cafe_terminado <= '0';
	       bomba_cafe <='0';
           carga <= 3;
           bomba_leche <='1';
           enable <= '1';
           if(salida ='1') then
               bomba_leche <= '0';
               enable <= '0';
           end if; 
           
       when SIRVIENDO_AZUCAR =>
            led_on <= '1';
            bomba_cafe <= '0';
            bomba_leche <= '0';
            cafe_terminado <= '0'; 
            if (azucar_code = "0001") then
                carga <= 2;
                bomba_azucar <='1';
                enable <= '1';
                if(salida ='1') then
                    bomba_azucar <= '0';
                    enable <= '0';
                end if;    
            elsif (azucar_code = "0010") then
                carga <= 4;
                bomba_azucar <='1';
                enable <= '1';
                if(salida ='1') then
                    bomba_azucar <= '0';
                    enable <= '0';
                end if;  
            end if;
                           	       
	   when ESPERA_NUEVOCAFE =>
	       led_on <= '1';
	       bomba_cafe <= '0';
	       bomba_leche <= '0';
	       bomba_azucar <= '0';
	       cafe_terminado <= '1';
       when others => 
           led_on <= '0';
	       bomba_cafe <= '0';
	       bomba_leche <= '0';
	       bomba_azucar <= '0';
	       cafe_terminado <= '0';
       end case;
   end process;
   
   Contador: process(clk_out,reset,enable)
   begin
	  if (reset='1') then
         cuenta<=0;
         salida<='0';
      elsif clk_out'event and clk_out='1' then
         if enable ='1' then
           if cuenta<carga then
                 cuenta<=cuenta+1;
                 salida<='0';
                 if cuenta=(carga-1) then
                     salida<='1';
                 end if;
            else
                 cuenta<=0;
                 salida<='0';
             end if;
         else
            salida <= '0';
         end if;
   end if;
 end process;
   
end Behavioral;
