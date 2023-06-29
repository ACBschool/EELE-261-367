library IEEE;
use IEEE.std_logic_1164.all;

entity rca_8bit is
	port(A, B	: in std_logic_vector(7 downto 0);
	     Sum	: out std_logic_vector(7 downto 0);
	     Cout	: out std_logic);
end entity;


architecture rca_8bit_arch of rca_8bit is 

	component full_adder 
		port(A,B,Cin	: in std_logic;
	             Sum, Cout 	: out std_logic);
	end component;



	--intermediate carry signals
	signal  C1, C2, C3, C4, C5, C6, C7 : std_logic;





	begin

	-- instantiate each position of ripple adder 
		P0 : full_adder port map (A(0), B(0), '0', Sum(0), C1);
		P1 : full_adder port map (A(1), B(1), C1, Sum(1), C2);
		P2 : full_adder port map (A(2), B(2), C2, Sum(2), C3);
		P3 : full_adder port map (A(3), B(3), C3, Sum(3), C4);
		P4 : full_adder port map (A(4), B(4), C4, Sum(4), C5);
		P5 : full_adder port map (A(5), B(5), C5, Sum(5), C6);
		P6 : full_adder port map (A(6), B(6), C6, Sum(6), C7);
		P7 : full_adder port map (A(7), B(7), C7, Sum(7), Cout);



end architecture;
