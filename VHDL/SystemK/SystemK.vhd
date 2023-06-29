entity SystemK is
	port( A, B, C, D : in bit;
		F : out bit);

end entity;

architecture SystemK_arch of SystemK is

	signal ABCD : bit_vector(3 downto 0);

begin 

	ABCD <= A & B & C & D;

   with (ABCD) select
	F <= '0' when "0011" | "0111" | "1011" | "1111",
	     '1' when others;

end architecture;
