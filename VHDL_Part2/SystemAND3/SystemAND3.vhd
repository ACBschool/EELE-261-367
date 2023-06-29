entity SystemAND3 is 
	port(A, B, C	: in bit;
	     F		: out bit);
end entity;

architecture SystemAND3_arch of SystemAND3 is


	begin
	
		F <= A and B and C;

end architecture;

