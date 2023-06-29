library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Sub_add_4bit is 
	port(A, B : in std_logic_vector(3 downto 0);
	     Sum_Diff   : out std_logic_vector(3 downto 0);
 	     C_B_out : out std_logic;
	     Control : in std_logic;
	     Vout    : out std_logic);
end entity;


architecture Sub_add_4bit_arch of Sub_add_4bit is 

	component full_adder 
		port(A,B,Cin	: in std_logic;
	     	     Sum, Cout 	: out std_logic);
	end component;

	signal C1, C2, C3 : std_logic;
	signal B_inv : std_logic_vector( 3 downto 0);
	signal output: std_logic_vector(3 downto 0);
	signal Two_comp : std_logic_vector(3 downto 0);



	begin

		D0 : full_adder port map (A(0), B_inv(0), Control, output(0), C1);
		D1 : full_adder port map (A(1), B_inv(1), C1, output(1), C2);
		D2 : full_adder port map (A(2), B_inv(2), C2, output(2), C3);
		D3 : full_adder port map (A(3), B_inv(3), C3, output(3), C_B_out);

		Sum_Diff <= output;

		B_inv(0) <= B(0) xor Control after 1 ns;
		B_inv(1) <= B(1) xor Control after 1 ns;
		B_inv(2) <= B(2) xor Control after 1 ns;
		B_inv(3) <= B(3) xor Control after 1 ns;

--		Two_OVERFLOW : process(output(3))
--			begin
--				if((A(3) = B_inv(3)) and (Control = '0') and (A(3) /= output(3))) then
--					Vout <= '1';
--				elsif((A(3) /= B_inv(3)) and (Control = '1') and (B(3) = output(3))) then
--					Vout <= '1';
--				else
--					Vout <= '0';
--				end if;
--
--		end process;	

		Two_comp <= A(3) & B(3) & output(3) & Control;

		with Two_comp select
			Vout <= '1' when "0010" | "1100"| "1001" | "0111",
				'0' when others;
				



		









end architecture;
