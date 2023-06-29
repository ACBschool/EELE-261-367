library IEEE;
use IEEE.std_logic_1164.all;


entity UpDown_TB is
end entity;


architecture UpDown_TB_arch of UpDown_TB is


   -- add DUT as component to test bench
component UpDown 
	port(Clock, Reset, Up	: in std_logic;
	     CNT		: out std_logic_vector(1 downto 0));
end component;

   -- declare test bench signals for instantiation
signal Reset_TB, Clock_TB, Up_TB	: std_logic;
signal CNT_TB				: std_logic_vector(1 downto 0);
--------------Architecture-begin---------------------------------------------
	begin

   	-- component instantiation
		DUT : UpDown port map (Clock_TB , Reset_TB , UP_TB , CNT_TB);


-- Process declarations for test signals----------------------------------
	-- Reset process
		RESET_PROC : process -- how does the reset trigger or how is it used in the simulation?
	
	 		begin
				Reset_TB <= '0'; wait for 0.7 ns;	-- reset pulls the output low for 5 ns;
				Reset_TB <= '1'; wait;		-- afterwards have the reset high indefinitely to let D-flip-flop operate for the rest of the simulation
		end process;

	-- Clock process
		CLOCK_PROC : process	-- don't want sensitivity list. Want signal to act indefinitely
			begin
	    			Clock_TB <= '0'; wait for 0.5 ns;
	    			Clock_TB <= '1'; wait for 0.5 ns;

		end process;
	
	-- Test Data process: Explore all possible inputs.
		DATA_PROC : process 	-- don't need sensitivity list. Want to see how DUT responds to possible inputs.
	 		begin
				Up_TB <= '1'; wait for 6 ns;
				Up_TB <= '0'; wait;

		end process;



end architecture;
