entity top is 
	port (SW 	: in bit_vector(3 downto 0);
			LEDR	: out bit_vector(3 downto 0);
			Prime	: out bit);
end entity;

architecture top_arch of top is

	begin
	
		LEDR <= SW;
		
		with (SW) select
			Prime <= '0' when "0000",
						'0' when "0001",
						'1' when "0010",
						'1' when "0011",
						
						'0' when "0100",
						'1' when "0101",
						'0' when "0110",
						'1' when "0111",
						
						'0' when "1000",
						'0' when "1001",
						'0' when "1010",
						'1' when "1011",
						
						'0' when "1100",
						'1' when "1101",
						'0' when "1110",
						'0' when "1111";
	
	
end architecture;