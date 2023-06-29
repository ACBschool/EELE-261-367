library IEEE;
use IEEE.std_logic_1164.all;

entity FSM_TB is
end entity;


architecture FSM_TB_arch of FSM_TB is


--DUT
component FSM 
 port (Clock, Reset	: in std_logic;
       Press		: in std_logic;
       Open_CW, Close_CCW: out std_logic);
end component;


signal Clock_TB ,Reset_TB : std_logic;
signal Press_TB : std_logic;
signal Open_CW_TB, Close_CCW_TB : std_logic;


 begin



   --component instantiation
   DUT : FSM port map (Clock_TB, Reset_TB, Press_TB, Open_CW_TB, Close_CCW_TB);




   CLOCK_PROC : process

	begin
		Clock_TB <= '0'; wait for 10 ns;
		Clock_TB <= '1'; wait for 10 ns;
   end process;
  
   RESET_PROC : process
	
	begin
		Reset_TB <= '0'; wait for 5 ns;
		Reset_TB <= '1'; wait;
   end process;


   PRESS_PROC : process
	
	begin
		Press_TB <= '0'; wait for 25 ns;
		Press_TB <= '1'; wait for 5 ns;
		Press_TB <= '0'; wait for 15 ns;
		Press_TB <= '1'; wait for 5 ns;
		Press_TB <= '0'; wait;

   end process;


end architecture;




