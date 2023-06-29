library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity alu is
	port ( BUS1  : in std_logic_vector(7 downto 0);
	       B     : in std_logic_vector(7 downto 0);
	       ALU_Sel : in std_logic_vector(2 downto 0);
	       ALU_Result : out std_logic_vector(7 downto 0);
	       NZVC 	: out std_logic_vector(3 downto 0));
end entity;


architecture alu_arch of alu is 

	

	begin



end architecture;
