library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity add_n_sub_8bit is 
	port(A, B : in std_logic_vector(7 downto 0);
	     Sum_Diff   : out std_logic_vector(7 downto 0);
 	     Cout_Bout : out std_logic;
	     ADDn_SUB : in std_logic;
	     Vout    : out std_logic);
end entity;


architecture add_n_sub_8bit_arch of add_n_sub_8bit is 

	component full_adder 
		port(A,B,Cin	: in std_logic;
	     	     Sum, Cout 	: out std_logic);
	end component;

	signal C1, C2, C3, C4, C5, C6, C7 : std_logic;
	signal B_inv : std_logic_vector( 7 downto 0);
	signal output: std_logic_vector(7 downto 0);
	signal Two_comp : std_logic_vector(3 downto 0);



	begin

		D0 : full_adder port map (A(0), B_inv(0), ADDn_SUB, output(0), C1);
		D1 : full_adder port map (A(1), B_inv(1), C1, output(1), C2);
		D2 : full_adder port map (A(2), B_inv(2), C2, output(2), C3);
		D3 : full_adder port map (A(3), B_inv(3), C3, output(3), C4);
		D4 : full_adder port map (A(4), B_inv(4), C4, output(4), C5);
		D5 : full_adder port map (A(5), B_inv(5), C5, output(5), C6);
		D6 : full_adder port map (A(6), B_inv(6), C6, output(6), C7);
		D7 : full_adder port map (A(7), B_inv(7), C7, output(7), Cout_Bout);

		Sum_Diff <= output;

		B_inv(0) <= B(0) xor ADDn_SUB after 1 ns;
		B_inv(1) <= B(1) xor ADDn_SUB after 1 ns;
		B_inv(2) <= B(2) xor ADDn_SUB after 1 ns;
		B_inv(3) <= B(3) xor ADDn_SUB after 1 ns;
		B_inv(4) <= B(4) xor ADDn_SUB after 1 ns;
		B_inv(5) <= B(5) xor ADDn_SUB after 1 ns;
		B_inv(6) <= B(6) xor ADDn_SUB after 1 ns;
		B_inv(7) <= B(7) xor ADDn_SUB after 1 ns;


		Two_comp <= A(7) & B(7) & output(7) & ADDn_SUB;

		with Two_comp select
			Vout <= '1' when "0010" | "1100"| "1001" | "0111",
				'0' when others;
				



		









end architecture;
