entity SourceAND3 is
	port(A,B,C	: in bit;
	     F		: out bit);
end entity;

architecture SourceAND3_arch of SourceAND3 is 

begin

F <= A and B and C;

end architecture;

