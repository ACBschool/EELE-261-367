library IEEE;
use IEEE.std_logic_1164.all;


entity SystemJ is

   port(ABCD	: in std_logic_vector(3 downto 0);
	F	: out std_logic);

end entity;

architecture SystemJ_arch of SystemJ is

   begin

	System_process : process (ABCD)
		begin
		
		case (ABCD) is 
			when "0100" => F <= '1';
			when "0101" => F <= '1';
			when "0111" => F <= '1';
			when "1100" => F <= '1';
			when "1101" => F <= '1';
			when "1111" => F <= '1';
			when others => F <= '0';
		end case;
	
	end process;

end architecture;


