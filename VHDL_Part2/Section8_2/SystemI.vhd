library IEEE;
use IEEE.std_logic_1164.all;

entity SystemI is 
   port (ABCD  : in  std_logic_vector(3 downto 0);	--inputs
         F     : out std_logic);			--outputs ( standard logic)
end entity;

architecture SystemI_arch of SystemI is

   begin

      SystemI_process : process (ABCD)			-- trigger on the bits comprising the input

	 begin
	    if	   (ABCD = "0001") then F <= '1';	-- codes for F is 1
	    elsif  (ABCD = "0011") then F <= '1';
	    elsif  (ABCD = "1001") then F <= '1';
	    elsif  (ABCD = "1011") then F <= '1';
	    else F <= '0';				-- expression handles the rest of the truth table
	    end if;

      end process;



end architecture;

