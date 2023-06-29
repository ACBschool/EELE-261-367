library IEEE;
use IEEE.std_logic_1164.all;


entity DFF_TB is
end entity;


architecture DFF_TB_arch of DFF_TB is


   -- add DUT as component to test bench
   component DFF 
	port(Reset, Clock, D	: in std_logic;
	     Q, Qn		: out std_logic);
   end component;

   -- declare test bench signals for instantiation
   signal Reset_TB, Clock_TB, D_TB, Q_TB, Qn_TB	: std_logic;
--------------Architecture-begin---------------------------------------------
   begin

   	-- component instantiation
	DUT : DFF port map (Reset_TB , Clock_TB , D_TB , Q_TB , Qn_TB);


-- Process declarations for test signals----------------------------------
	-- Reset process
	RESET_PROC : process -- how does the reset trigger or how is it used in the simulation?
	
	 begin
	   Reset_TB <= '0'; wait for 5 ns;	-- reset pulls the output low for 5 ns;
	   Reset_TB <= '1'; wait for 7 ns;		-- afterwards have the reset high indefinitely to let D-flip-flop operate for the rest of the simulation
	   Reset_TB <= '0'; wait;
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
	  D_TB <= '-'; wait for 5 ns;	-- suggest that we don't care what the data value is while the system is in reset
	  D_TB <= '1'; wait for 1 ns;	-- give possible values for input in the same time scale as clock
	  D_TB <= '0'; wait for 1 ns;	
	  D_TB <= 'Z'; wait for 1 ns;	-- high impedance
	  D_TB <= 'L'; wait for 1 ns;	-- Weak 0
	  D_TB <= 'H'; wait for 1 ns;	-- Weak 1
	  D_TB <= 'X'; wait for 1 ns;	-- Forcing Unknown
	  D_TB <= 'U'; wait for 1 ns;	-- uninitialized
	  D_TB <= '-'; wait;		-- suspend indefinitely until simulation end

	end process;



end architecture;