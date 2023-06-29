
entity PROJECT is
	port( A, B, C : in bit;
		F : out bit);

end entity;

architecture PROJECT_arch of PROJECT is 

begin 

	F <= A and B and C;

end architecture;

