library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sub_8bit is 
	port(A, B : in std_logic_vector(7 downto 0);
	     Diff   : out std_logic_vector(7 downto 0);
 	     Borrow : out std_logic);
end entity;


architecture sub_8bit_arch of sub_8bit is 

	component full_adder 
		port(A,B,Cin	: in std_logic;
	     	     Sum, Cout 	: out std_logic);
	end component;

	signal C1, C2, C3, C4, C5, C6, C7 : std_logic;
	signal B_inv : std_logic_vector( 7 downto 0);



	begin

		D0 : full_adder port map (A(0), B_inv(0), '1', Diff(0), C1);
		D1 : full_adder port map (A(1), B_inv(1), C1, Diff(1), C2);
		D2 : full_adder port map (A(2), B_inv(2), C2, Diff(2), C3);
		D3 : full_adder port map (A(3), B_inv(3), C3, Diff(3), C4);
		D4 : full_adder port map (A(4), B_inv(4), C4, Diff(4), C5);
		D5 : full_adder port map (A(5), B_inv(5), C5, Diff(5), C6);
		D6 : full_adder port map (A(6), B_inv(6), C6, Diff(6), C7);
		D7 : full_adder port map (A(7), B_inv(7), C7, Diff(7), Borrow);

		B_inv <= not B after 1 ns;


end architecture;
