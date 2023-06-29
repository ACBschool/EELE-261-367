library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sub_add_4bit_TB is
end entity;

architecture Sub_add_4bit_TB_arch of Sub_add_4bit_TB is 

	component Sub_add_4bit 
		port(A, B	: in std_logic_vector(3 downto 0);
		     Sum_Diff	: out std_logic_vector(3 downto 0);
		     C_B_out 	: out std_logic;
		     Control	: in std_logic;
		     Vout	: out std_logic);
	end component;

	signal A_TB, B_TB, Sum_Diff_TB : std_logic_vector(3 downto 0);
	signal C_B_out_TB	: std_logic;
	signal Control_Tb	: std_logic := '1';
	signal Vout_TB		: std_logic;

	begin

		DUT : Sub_add_4bit port map (A_TB, B_TB, Sum_Diff_TB, C_B_out_TB, Control_TB, Vout_TB);

		STIM : process
			begin
				for i in 0 to 15 loop
					Control_TB <= not Control_TB; 
					for j in 0 to 15 loop
						A_TB <= std_logic_vector(to_unsigned(i,4));
						B_TB <= std_logic_vector(to_unsigned(j,4));
						wait for 30 ns;
					end loop;
				end loop;
		end process;
end architecture;
