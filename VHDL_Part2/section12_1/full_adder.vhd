library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
	port(A,B,Cin	: in std_logic;
	     Sum, Cout 	: out std_logic);
end entity;

architecture full_adder_arch of full_adder is

	component half_adder
		port(A,B	: in std_logic;
		     Sum,Cout	: out std_logic);
	end component;

	signal HA1_sum, HA1_Cout, HA2_Cout : std_logic;


	begin
	
		HALF_ADDER_1 : half_adder port map(A ,B, HA1_sum, HA1_Cout);
		HALF_ADDER_2 : half_adder port map(HA1_sum, Cin, Sum, HA2_Cout);

		Cout <= HA2_Cout or HA1_Cout after 1 ns;



end architecture;


