library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity char_decoder is
	port(BIN_IN		: in std_logic_vector(3 downto 0);
		  HEX_OUT	: out std_logic_vector(6 downto 0));
end entity;


architecture char_decoder_arch of char_decoder is


	begin
	

	
		-- negative logic. 0's turn segments on.
	Decoder_process : process (BIN_IN)
	
		begin
			
			case (BIN_IN) is
			
				when "0000" => HEX_OUT <= "1000000";		--0
				when "0001" => HEX_OUT <= "1111001";		--1
				when "0010" => HEX_OUT <= "0100100";		--2
				when "0011" => HEX_OUT <= "0110000";		--3
				
				when "0100" => HEX_OUT <= "0011001";		--4
				when "0101" => HEX_OUT <= "0010010";		--5
				when "0110" => HEX_OUT <= "0000010";		--6
				when "0111" => HEX_OUT <= "1111000";		--7
				
				when "1000" => HEX_OUT <= "0000000";		--8
				when "1001" => HEX_OUT <= "0010000";		--9
				when "1010" => HEX_OUT <= "0001000";		--A
				when "1011" => HEX_OUT <= "0000011";		--B
				
				when "1100" => HEX_OUT <= "0100111";		--C
				when "1101" => HEX_OUT <= "0100001";		--D		
				when "1110" => HEX_OUT <= "0000110";		--E
				when "1111" => HEX_OUT <= "0001110";		--F
				
			end case;
		
		end process;
	
	
end architecture;
