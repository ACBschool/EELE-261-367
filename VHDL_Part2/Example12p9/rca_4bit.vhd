library IEEE;
use IEEE.std_logic_1164.all;

entity rca_4bit is 
	port( A, B	: in std_logic_vector(3 downto 0);
	      Sum	: out std_logic_vector(3 downto 0);
	      Cout	: out std_logic);
end entity;

architecture rca_4bit_arch of rca_4bit is 

	component full_adder
		port(A, B ,Cin	: in std_logic;
		     Sum, Cout	: out std_logic);
	end component;

	signal C1, C2, C3 : std_logic;

	begin

		
		A0 : full_adder port map ( A(0), B(0), '0', Sum(0), C1);
		A1 : full_adder port map ( A(1), B(1), C1, Sum(1), C2);
		A2 : full_adder port map ( A(2), B(2), C2, Sum(2), C3);
		A3 : full_adder port map ( A(3), B(3), C3, Sum(3), Cout);


end architecture;
