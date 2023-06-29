library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity twos_comp_decoder is 
	port(TWOS_COMP_IN		: in std_logic_vector(3 downto 0);
		  MAG_OUT			: out std_logic_vector(6 downto 0);
		  SIGN_OUT			: out std_logic_vector(6 downto 0));
end entity;



architecture twos_comp_decoder_arch of twos_comp_decoder is 

	signal Sign	: std_logic;

	begin
		
		--isolate sign bit
		Sign <= TWOS_COMP_IN(3);
		
	
		Magnitude_process : process (TWOS_COMP_IN)
	
		begin
			--magnitudes
			case (TWOS_COMP_IN) is
				
				when "1000" => MAG_OUT <= "0000000";		--(-8)
				when "1001" => MAG_OUT <= "1111000";		--(-7)
				when "1010" => MAG_OUT <= "0000010";		--(-6)
				when "1011" => MAG_OUT <= "0010010";		--(-5)
				
				when "1100" => MAG_OUT <= "0011001";		--(-4)
				when "1101" => MAG_OUT <= "0110000";		--(-3)		
				when "1110" => MAG_OUT <= "0100100";		--(-2)
				when "1111" => MAG_OUT <= "1111001";		--(-1)
							
				when "0000" => MAG_OUT <= "1000000";		--0
				when "0001" => MAG_OUT <= "1111001";		--1
				when "0010" => MAG_OUT <= "0100100";		--2
				when "0011" => MAG_OUT <= "0110000";		--3
				
				when "0100" => MAG_OUT <= "0011001";		--4
				when "0101" => MAG_OUT <= "0010010";		--5
				when "0110" => MAG_OUT <= "0000010";		--6
				when "0111" => MAG_OUT <= "1111000";		--7
				
			end case;
		
		end process;
	
		Sign_process : process(Sign) 
			
			begin
			
				case (Sign) is 
				
					when '0' => SIGN_OUT <= "1111111";
					when '1' => SIGN_OUT <= "0111111";
				
				end case;
		
		end process;
	
	
	
	
end architecture;