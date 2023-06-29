library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity rom_64x8_sync is 
	port(clock		: in std_logic;			-- synchronous memory
		  address	: in std_logic_vector(5 downto 0);	-- address vector for memory locations
		  data_out 	: out std_logic_vector(7 downto 0));	-- when reading, assign to output variable
end entity;


architecture rom_64x8_sync_arch of rom_64x8_sync is

	type ROM_type is array(63 downto 0) of std_logic_vector(7 downto 0);
	
	constant ROM : ROM_type := (0 => x"00", 1 => x"11", 2 => x"22", 3 => x"33", 
										 4 => x"44", 5 => x"55", 6 => x"66", 7 => x"77",
										 8 => x"88", 9 => x"99",10 => x"AA",11 => x"BB",
										 12=> x"CC",13 => x"DD",14 => x"EE",15 => x"FF",
										 16=> x"FF",17 => x"EE",18 => x"DD",19 => x"CC",
										 20=> x"BB",21 => x"AA",22 => x"99",23 => x"88",
										 24=> x"77",25 => x"66",26 => x"55",27 => x"44",
										 28=> x"33",29 => x"22",30 => x"11",31 => x"00",
										 32=> x"00",33 => x"00",34 => x"00",35 => x"00",
										 36=> x"00",37 => x"00",38 => x"00",39 => x"00",
										 40=> x"00",41 => x"00",42 => x"00",43 => x"00",
										 44=> x"00",45 => x"00",46 => x"00",47 => x"00",
										 48=> x"00",49 => x"00",50 => x"00",51 => x"00",
										 52=> x"00",53 => x"00",54 => x"00",55 => x"00",
										 56=> x"00",57 => x"00",58 => x"00",59 => x"00",
										 60=> x"00",61 => x"00",62 => x"00",63 => x"00");



	begin
		MEMORY : process(clock)
		
			begin
				
				if(rising_edge(clock)) then
					
					data_out <= ROM(to_integer(unsigned(address)));
				end if;
		end process;

	
	
end architecture;





