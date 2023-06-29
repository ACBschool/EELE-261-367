library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rca_4bit_TB is
end entity;

architecture rca_4bit_TB_arch of rca_4bit_TB is 

	component rca_4bit 
		port(A, B	: in std_logic_vector(3 downto 0);
		     Sum	: out std_logic_vector(3 downto 0);
		     Cout 	: out std_logic);
	end component;

	signal A_TB, B_TB, Sum_TB : std_logic_vector(3 downto 0);
	signal Cout_TB	: std_logic;


	begin

		DUT : rca_4bit port map (A_TB, B_TB, Sum_TB, Cout_TB);

		STIM : process
			begin
				for i in 0 to 15 loop
					for j in 0 to 15 loop
						A_TB <= std_logic_vector(to_unsigned(i,4));
						B_TB <= std_logic_vector(to_unsigned(j,4));
						wait for 30 ns;
					end loop;
				end loop;
		end process;
					




















end architecture;
