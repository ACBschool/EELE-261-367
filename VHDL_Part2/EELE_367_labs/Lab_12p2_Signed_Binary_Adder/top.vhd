library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is 

	port(SW 		: in std_logic_vector(7 downto 0);
		  LEDR	: out std_logic_vector(9 downto 0);
		  HEX0	: out std_logic_vector(6 downto 0);
		  HEX1 	: out std_logic_vector(6 downto 0);
		  HEX2	: out std_logic_vector(6 downto 0);
		  HEX3	: out std_logic_vector(6 downto 0);
		  HEX4	: out std_logic_vector(6 downto 0);
		  HEX5 	: out std_logic_vector(6 downto 0));

end entity;


architecture top_arch of top is


------------------------------------------------------------------------------------------------
-------------------------------Component-Subsystems---------------------------------------------
------------------------------------------------------------------------------------------------

	-- hex decoder component
	component twos_comp_decoder  
		port(TWOS_COMP_IN		: in std_logic_vector(3 downto 0);
			  MAG_OUT			: out std_logic_vector(6 downto 0);
		     SIGN_OUT			: out std_logic_vector(6 downto 0));
	end component;
	
	


	
	
------------------------------------------------------------------------------------------------	
---------------------------Internal-signals-----------------------------------------------------
------------------------------------------------------------------------------------------------

	signal Sum	 : std_logic_vector(3 downto 0);	-- interim hold sum of adder.
	signal Sum_uns : signed(3 downto 0);
	signal Overflow: std_logic;
	signal Input	: std_logic_vector(2 downto 0);
	
	
------------------------------------------------------------------------------------------------	
------------------------------------------------------------------------------------------------
-------------------Begin-Modeling---------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


	
	begin

	
------------------------------------------------------------------------------------------------
------------------------------------------General-Assignment-I/O--------------------------------
------------------------------------------------------------------------------------------------

		LEDR(7 downto 0) <= SW;
		LEDR(9) <= Overflow;

------------------------------------------------------------------------------------------------
--------------------------------------HEX-displays-subsystem------------------------------------
------------------------------------------------------------------------------------------------

	-- HEX component instantiation
	B0 : twos_comp_decoder port map(SW(3 downto 0), HEX0, HEX1);
	B1 : twos_comp_decoder port map(SW(7 downto 4), HEX2, HEX3);
	B2 : twos_comp_decoder port map(Sum, HEX4, HEX5);




------------------------------------------------------------------------------------------------
-------------------------------Adder-Subsystem--------------------------------------------------
------------------------------------------------------------------------------------------------
		
		-- Carry is ignored in 2's complement addition
		
		Sum_uns <= signed(SW(7 downto 4)) + signed(SW(3 downto 0));

		Sum <= std_logic_vector(Sum_uns(3 downto 0));


------------------------------------------------------------------------------------------------
-------------------------------Overflow-Logic---------------------------------------------------
------------------------------------------------------------------------------------------------
		Input <= SW(3) & SW(7) & Sum(3);
		
		with Input select
			Overflow <= '1' when "001" | "110",
							'0' when others;
		
		
		
		
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


end architecture;
	




