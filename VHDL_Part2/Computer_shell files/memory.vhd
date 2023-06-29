library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is 
	port(address  	: in std_logic_vector(7 downto 0);
	     write    	: in std_logic;
	     clock	: in std_logic;
	     reset	: in std_logic;
	     data_in	: in std_logic_vector(7 downto 0);
	     data_out	: out std_logic_vector(7 downto 0);
	     port_in_00 : in std_logic_vector(7 downto 0);
	     port_in_01	: in std_logic_vector(7 downto 0);
	     port_in_02 : in std_logic_vector(7 downto 0);
	     port_in_03 : in std_logic_vector(7 downto 0);
	     port_in_04 : in std_logic_vector(7 downto 0);
	     port_in_05 : in std_logic_vector(7 downto 0);
	     port_in_06 : in std_logic_vector(7 downto 0);
	     port_in_07 : in std_logic_vector(7 downto 0);
	     port_in_08 : in std_logic_vector(7 downto 0);
	     port_in_09 : in std_logic_vector(7 downto 0);
	     port_in_10 : in std_logic_vector(7 downto 0);
	     port_in_11 : in std_logic_vector(7 downto 0);
	     port_in_12 : in std_logic_vector(7 downto 0);
	     port_in_13 : in std_logic_vector(7 downto 0);
	     port_in_14 : in std_logic_vector(7 downto 0);
	     port_in_15 : in std_logic_vector(7 downto 0);
	     port_out_00    : out  std_logic_vector (7 downto 0);
             port_out_01    : out  std_logic_vector (7 downto 0);
             port_out_02    : out  std_logic_vector (7 downto 0);
             port_out_03    : out  std_logic_vector (7 downto 0);
             port_out_04    : out  std_logic_vector (7 downto 0);
             port_out_05    : out  std_logic_vector (7 downto 0);
             port_out_06    : out  std_logic_vector (7 downto 0);
             port_out_07    : out  std_logic_vector (7 downto 0);
             port_out_08    : out  std_logic_vector (7 downto 0);
             port_out_09    : out  std_logic_vector (7 downto 0);
             port_out_10    : out  std_logic_vector (7 downto 0);
             port_out_11    : out  std_logic_vector (7 downto 0);
             port_out_12    : out  std_logic_vector (7 downto 0);
             port_out_13    : out  std_logic_vector (7 downto 0);
             port_out_14    : out  std_logic_vector (7 downto 0);
             port_out_15    : out  std_logic_vector (7 downto 0));
end entity;



architecture memory_arch of memory is 

	component rom_128x8_sync
		port(address : in std_logic_vector(7 downto 0);
	    	     clock   : in std_logic;
	     	     data_out: out std_logic_vector(7 downto 0));
	end component;

	component rw_96x8_sync 
		port(address : in std_logic_vector(7 downto 0);
	     	     data_in : in std_logic_vector(7 downto 0);
	     	     write   : in std_logic;
	     	     clock   : in std_logic;
	     	     data_out: out std_logic_vector(7 downto 0));
	end component;

	-- internal signals for outputs before data_out MUX
	signal rom_out : std_logic_vector(7 downto 0);
	signal rw_out  : std_logic_vector(7 downto 0);


	begin

----------------ROM-Instantiation-----------------------------------------------------
		ROM_inst : rom_128x8_sync 
			port map ( address  => address,
				   clock    => clock,
				   data_out => rom_out );
----------------RW-Instantiation------------------------------------------------------
		RW_inst  : rw_96x8_sync 
			port map ( address  => address,
				   data_in  => data_in,
				   write    => write,
				   clock    => clock,
				   data_out => rw_out );
----------------Port-definitions------------------------------------------------------


			









end architecture;

















