library IEEE;
use IEEE.std_logic_1164.all;


entity rw_4x4_sync_TB is
end entity;

architecture rw_4x4_sync_TB_arch of rw_4x4_sync_TB is

	signal clock_TB	  : std_logic;
	signal address_TB : std_logic_vector(1 downto 0);
	signal data_in_TB : std_logic_vector(3 downto 0);
	signal WE_TB	  : std_logic;
	signal data_out_TB: std_logic_vector(3 downto 0);

	component rw_4x4_sync 
		port (clock	: in std_logic;
		      address 	: in std_logic_vector(1 downto 0);
		      data_in	: in std_logic_vector(3 downto 0);
		      WE	: in std_logic;
		      data_out	: out std_logic_vector(3 downto 0));
	end component;



	begin

	DUT : rw_4x4_sync port map (clock_TB, address_TB, data_in_TB, WE_TB, data_out_TB);

	CLOCK_STIM : process
		begin
			clock_TB <= '0'; wait for 10 ns;
			clock_TB <= '1'; wait for 10 ns;
	end process;

	ADDRESS_STM : process
		begin
			address_TB <= "00"; wait for 20 ns;
			address_TB <= "01"; wait for 20 ns;
			address_TB <= "10"; wait for 20 ns;
			address_TB <= "11"; wait for 20 ns;
	end process;



end architecture; 
 