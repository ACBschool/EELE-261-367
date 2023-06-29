library IEEE;
use IEEE.std_logic_1164.all;


entity SystemJ_TB is 
end entity;



architecture SystemJ_TB_arch of SystemJ_TB is

	-- Wait time constant
	constant t_wait : time := 10 ns;

	-- DUT declaration
	component SystemJ
   		port(ABCD	: in std_logic_vector(3 downto 0);
		     F	        : out std_logic); 
	end component;

	--Test bench signal declaration
	signal ABCD_TB	: std_logic_vector(3 downto 0);
	signal F_TB	: std_logic;

	--begin architecture---------------------------------------
	begin
	
		-- DUT instantiation
		DUT : SystemJ port map (ABCD_TB , F_TB);
		--Stimulus Generation
		STIMULUS : process 
			begin
			
			ABCD_TB <= "0000"; wait for t_wait;						 
				assert(F_TB = '1') report "Input Code 0000 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 0000 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "0001"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 0001 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 0001 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "0010"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 0010 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 0010 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "0011"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 0011 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 0011 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "0100"; wait for t_wait;----------------------------------------------------------------------- F = 1
				assert(F_TB = '1') report "Input Code 0100 : Output Value of 0 is incorrect" severity ERROR;
				assert(F_TB = '0') report "Input Code 0100 : Output Value of 1 is correct" severity NOTE;

			ABCD_TB <= "0101"; wait for t_wait;----------------------------------------------------------------------- F = 1
				assert(F_TB = '1') report "Input Code 0101 : Output Value of 0 is incorrect" severity ERROR;
				assert(F_TB = '0') report "Input Code 0101 : Output Value of 1 is correct" severity NOTE;

			ABCD_TB <= "0110"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 0110 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 0110 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "0111"; wait for t_wait;----------------------------------------------------------------------- F = 1
				assert(F_TB = '1') report "Input Code 0111 : Output Value of 0 is incorrect" severity ERROR;
				assert(F_TB = '0') report "Input Code 0111 : Output Value of 1 is correct" severity NOTE;

			ABCD_TB <= "1000"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 1000 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 1000 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "1001"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 1001 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 1001 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "1010"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 1010 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 1010 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "1011"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 1011 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 1011 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "1100"; wait for t_wait;----------------------------------------------------------------------- F = 1
				assert(F_TB = '1') report "Input Code 1100 : Output Value of 0 is incorrect" severity ERROR;
				assert(F_TB = '0') report "Input Code 1100 : Output Value of 1 is correct" severity NOTE;

			ABCD_TB <= "1101"; wait for t_wait;----------------------------------------------------------------------- F = 1
				assert(F_TB = '1') report "Input Code 1101 : Output Value of 0 is incorrect" severity ERROR;
				assert(F_TB = '0') report "Input Code 1101 : Output Value of 1 is correct" severity NOTE;

			ABCD_TB <= "1110"; wait for t_wait;
				assert(F_TB = '1') report "Input Code 1110 : Output Value of 0 is correct" severity NOTE;
				assert(F_TB = '0') report "Input Code 1110 : Output Value of 1 is incorrect" severity ERROR;

			ABCD_TB <= "1111"; wait for t_wait;----------------------------------------------------------------------- F = 1
				assert(F_TB = '1') report "Input Code 1111 : Output Value of 0 is incorrect" severity ERROR;
				assert(F_TB = '0') report "Input Code 1111 : Output Value of 1 is correct" severity NOTE;
		end process;

end architecture;







