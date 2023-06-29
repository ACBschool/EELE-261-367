library IEEE;
use IEEE.std_logic_1164.all;


entity rom_4x4_async_TB is
end entity;

architecture rom_4x4_async_TB_arch of rom_4x4_async_TB is

	signal address_TB  : std_logic_vector(1 downto 0);
	signal data_out_TB : std_logic_vector(3 downto 0);
	signal clock_TB	   : std_logic;

	component rom_4x4_async 
		port( address	: in std_logic_vector(1 downto 0);
		      clock	: in std_logic;
		      data_out	: out std_logic_vector(3 downto 0));
	end component;


	begin
		DUT : rom_4x4_async port map (address_TB , clock_TB , data_out_TB);
		
		ADDRESS_STIM : process
			
			begin
				address_TB <= "00"; wait for 25 ns;
				address_TB <= "01"; wait for 25 ns;
				address_TB <= "10"; wait for 25 ns;
				address_TB <= "11"; wait for 25 ns;		
		end process;

		CLOCK_PROC : process
			begin
				clock_TB <= '0'; wait for 12.5 ns;
				clock_TB <= '1'; wait for 12.5 ns;

		end process;

end architecture;
