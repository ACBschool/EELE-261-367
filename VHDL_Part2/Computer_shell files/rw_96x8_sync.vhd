library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rw_96x8_sync is 
	port(address : in std_logic_vector(7 downto 0);
	     data_in : in std_logic_vector(7 downto 0);
	     write   : in std_logic;
	     clock   : in std_logic;
	     data_out: out std_logic_vector(7 downto 0));
end entity;



architecture rw_96x8_sync_arch of rw_96x8_sync is 


	type RW_type is array(128 to 223) of std_logic_vector(7 downto 0);

	signal RW : RW_type;

	signal EN : std_logic;



	begin








end architecture;


