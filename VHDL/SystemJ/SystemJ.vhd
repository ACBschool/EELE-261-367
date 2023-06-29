entity SystemJ is

	port( A, B, C, D : in bit;
		F : out bit);

end entity;

architecture SystemJ_arch of SystemJ is 

begin

	F <= '1' when (A = '0' and B = '1' and C = '0' and D = '0') else
	     '1' when (A = '0' and B = '1' and C = '0' and D = '1') else
	     '1' when (A = '0' and B = '1' and C = '1' and D = '1') else
	     '1' when (A = '1' and B = '1' and C = '0' and D = '0') else
	     '1' when (A = '1' and B = '1' and C = '0' and D = '1') else
	     '1' when (A = '1' and B = '1' and C = '1' and D = '1') else
	     '0' ;

end architecture;


