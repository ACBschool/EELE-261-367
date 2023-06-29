library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity rca_8bit_TB is 
end entity;


architecture rca_8bit_TB_arch of rca_8bit_TB is 

	component rca_8bit 
		port(A, B	: in std_logic_vector(7 downto 0);
	      	     Sum	: out std_logic_vector(7 downto 0);
	             Cout	: out std_logic);
	end component;

	signal A_TB, B_TB : std_logic_vector(7 downto 0);
	signal Sum_TB	  : std_logic_vector(7 downto 0);
	signal Cout_TB	  : std_logic;



	begin


		DUT : rca_8bit port map(A_TB, B_TB, Sum_TB, Cout_TB);

		STIMULUS : process
			begin
				-- loop over all possible A codes 
				for i in 0 to 255 loop
				-- loop over all possible B codes.
					for j in 0 to 255 loop
						-- loop variables are natively integers.
						A_TB <= std_logic_vector(to_unsigned(i,8));
						B_TB <= std_logic_vector(to_unsigned(j,8));
						wait for 50 ns;
					end loop;
				end loop;
		end process;		





end architecture;


