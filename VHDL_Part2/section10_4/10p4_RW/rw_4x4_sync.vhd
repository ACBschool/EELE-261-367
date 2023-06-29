library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rw_4x4_sync is
	port (clock	: in std_logic;
	      address 	: in std_logic_vector(1 downto 0);
	      data_in	: in std_logic_vector(3 downto 0);
	      WE	: in std_logic;
	      data_out	: out std_logic_vector(3 downto 0));
end entity;


architecture rw_4x4_sync_arch of rw_4x4_sync is 

	-- need signal to read and write from ROM
	type RW_type is array (0 to 3) of std_logic_vector(3 downto 0);

	-- define signal to read and write to memory
	signal RW :RW_type;


	begin
			-- synchronous system
		process (clock)
			begin
				if(rising_edge(clock)) then	
					if (WE = '1') then		-- if (WE) write enable is asserted then we want to write to memory
						RW(to_integer(unsigned(address))) <= data_in;	-- input data is sent to a specific address in memory;
					else
						data_out <= RW(to_integer(unsigned(address)));		-- otherwise we are reading from memory;
					end if;
				end if;
		end process;






end architecture;