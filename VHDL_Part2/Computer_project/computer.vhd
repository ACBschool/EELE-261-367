library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- internal signals are needed whenever subcomponents connect inputs to outputs

entity computer is 
	port(clock          : in   std_logic;
             reset          : in   std_logic;
             port_in_00     : in   std_logic_vector (7 downto 0);
             port_in_01     : in   std_logic_vector (7 downto 0);
             port_in_02     : in   std_logic_vector (7 downto 0);
             port_in_03     : in   std_logic_vector (7 downto 0);
             port_in_04     : in   std_logic_vector (7 downto 0);
             port_in_05     : in   std_logic_vector (7 downto 0);
             port_in_06     : in   std_logic_vector (7 downto 0);               
             port_in_07     : in   std_logic_vector (7 downto 0);
             port_in_08     : in   std_logic_vector (7 downto 0);
             port_in_09     : in   std_logic_vector (7 downto 0);
             port_in_10     : in   std_logic_vector (7 downto 0);
             port_in_11     : in   std_logic_vector (7 downto 0);
             port_in_12     : in   std_logic_vector (7 downto 0);
             port_in_13     : in   std_logic_vector (7 downto 0);
             port_in_14     : in   std_logic_vector (7 downto 0);
             port_in_15     : in   std_logic_vector (7 downto 0);                                                                   
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


architecture computer_arch of computer is 

	component memory
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
	end component;

	component cpu
		port( clock  : in std_logic;
		      reset  : in std_logic;
		      from_memory : in std_logic_vector(7 downto 0);
		      address: out std_logic_vector(7 downto 0);
		      write  : out std_logic;
		      to_memory : out std_logic_vector(7 downto 0));	
	end component;

	--internal signals connecting memory and cpu

	signal address_internal : std_logic_vector(7 downto 0);
	signal write_internal	: std_logic;
	signal cpu_to_memory	: std_logic_vector(7 downto 0);
	signal memory_to_cpu	: std_logic_vector(7 downto 0);


	begin
----------------CPU-Instantiation-----------------------------------------------------
		CPU_inst : cpu 
			port map ( clock       => clock, 
				   reset       => reset, 
				   from_memory => memory_to_cpu,
				   address     => address_internal,
				   write       => write_internal, 
				   to_memory   => cpu_to_memory);
----------------MEMORY-Instantiation--------------------------------------------------
		MEMORY_inst: memory 
			port map ( address     => address_internal,
				   write       => write_internal,
				   clock       => clock,
				   reset       => reset,
				   data_in     => cpu_to_memory,
				   data_out    => memory_to_cpu,
				   port_in_00  => port_in_00,
				   port_in_01  => port_in_01,
				   port_in_02  => port_in_02,
				   port_in_03  => port_in_03,
				   port_in_04  => port_in_04,
				   port_in_05  => port_in_05,
				   port_in_06  => port_in_06,
				   port_in_07  => port_in_07,
				   port_in_08  => port_in_08,
				   port_in_09  => port_in_09,
				   port_in_10  => port_in_10,
				   port_in_11  => port_in_11,
				   port_in_12  => port_in_12,
				   port_in_13  => port_in_13,
				   port_in_14  => port_in_14,
				   port_in_15  => port_in_15,

				   port_out_00 => port_out_00,
				   port_out_01 => port_out_01,
				   port_out_02 => port_out_02,
				   port_out_03 => port_out_03,
				   port_out_04 => port_out_04,
				   port_out_05 => port_out_05,
				   port_out_06 => port_out_06,
				   port_out_07 => port_out_07,
				   port_out_08 => port_out_08,
				   port_out_09 => port_out_09,
				   port_out_10 => port_out_10,
				   port_out_11 => port_out_11,
				   port_out_12 => port_out_12,
				   port_out_13 => port_out_13,
				   port_out_14 => port_out_14,
				   port_out_15 => port_out_15);
--------------------------------------------------------------------------------------
				   



end architecture;





























