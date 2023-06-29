library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity top is 

	port(Clock_50	: in std_logic;
		  Reset	: in std_logic;
		  SW 		: in std_logic_vector(3 downto 0);
		  LEDR	: out std_logic_vector(9 downto 0);
		  HEX0	: out std_logic_vector(6 downto 0);
		  HEX1 	: out std_logic_vector(6 downto 0);
		  HEX2	: out std_logic_vector(6 downto 0);
		  HEX3	: out std_logic_vector(6 downto 0);
		  HEX4	: out std_logic_vector(6 downto 0);
		  HEX5 	: out std_logic_vector(6 downto 0);
		  GPIO	: out std_logic_vector(14 downto 0));
end entity;


architecture top_arch of top is


------------------------------------------------------------------------------------------------
-------------------------------Component-Subsystems---------------------------------------------
------------------------------------------------------------------------------------------------

	-- hex decoder component
	component char_decoder
		port(BIN_IN		: in std_logic_vector (3 downto 0);
			  HEX_OUT	: out std_logic_vector ( 6 downto 0));
	end component;
	
	
	--Clock divider component
	component clock_div_prec 
		port(Clock_in 	: in std_logic;
			  Reset		: in std_logic;
		     Sel			: in std_logic_vector(1 downto 0);
		     Clock_out	: out std_logic);
	end component;
	
	
	--Synchronous Memory component
	component rom_64x8_sync  
		port(clock		: in std_logic;			
			  address	: in std_logic_vector(5 downto 0);	
			  data_out 	: out std_logic_vector(7 downto 0));	
	end component;

	
	
------------------------------------------------------------------------------------------------	
---------------------------Internal-signals-----------------------------------------------------
------------------------------------------------------------------------------------------------

	
	
	signal Clock_div 	: std_logic;		--divided clock;
	signal Address		: std_logic_vector(5 downto 0);
	signal ROM_data_out: std_logic_vector(7 downto 0);
	signal CNT			: integer := 0;
	constant Max_count: integer := 63;

	
	
------------------------------------------------------------------------------------------------	
------------------------------------------------------------------------------------------------
-------------------Begin-Modeling---------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


	
	begin

	
------------------------------------------------------------------------------------------------
------------------------------------------General-Assignment-I/O--------------------------------
------------------------------------------------------------------------------------------------


	-- I/O assignment of the output counter values of single process
		GPIO(13 downto 8) <= Address;
		GPIO(7 downto 0) <= ROM_data_out;
		GPIO(14) <= Clock_div;
	
------------------------------------------------------------------------------------------------
------------------------------Clock-divider-subsystem-------------------------------------------
------------------------------------------------------------------------------------------------
	
	
	--Clock divider instantiation
		CLK : clock_div_prec port map (Clock_In => CLock_50, Reset => Reset, Sel => (SW(1) & SW(0)), Clock_out => Clock_div);
	
	--Sel = "00 => 1Hz
	--Sel = "01" => 10Hz
	--Sel = "10" => 100Hz
	--Sel = "11" => 1kHz
------------------------------------------------------------------------------------------------
--------------------------------------HEX-displays-subsystem------------------------------------
------------------------------------------------------------------------------------------------

	-- HEX component instantiation
	
		C0	: char_decoder port map ( BIN_IN => ROM_data_out(3 downto 0) , HEX_OUT => HEX0);
		C1	: char_decoder port map ( BIN_IN => ROM_data_out(7 downto 4) , HEX_OUT => HEX1);
		HEX2 <= "1111111";
		HEX3 <= "1111111";
		C4	: char_decoder port map ( BIN_IN => Address(3 downto 0) , HEX_OUT => HEX4);
		C5	: char_decoder port map ( BIN_IN => "00" & Address(5 downto 4) , HEX_OUT => HEX5);
------------------------------------------------------------------------------------------------
--------------------------------------ROM-subsystem---------------------------------------------
------------------------------------------------------------------------------------------------
		
	-- ROM instantiation
		
		ROM : rom_64x8_sync port map (clock => Clock_div, address => Address, data_out => ROM_data_out); 
		
		
------------------------------------------------------------------------------------------------
--------------------------Address-Counter-------------------------------------------------------
------------------------------------------------------------------------------------------------
		ADDRESS_COUNTER_PROC : process(Clock_div,Reset)
			
			begin
				
				if (Reset = '0') then
					CNT <= 0;
				
				elsif(rising_edge(Clock_div)) then
					
					if(CNT = Max_count) then
						CNT <= 0;
					
					else 
						CNT <= CNT + 1;
					
					end if;
				end if;
		end process;

		Address <= std_logic_vector(to_unsigned(CNT,6));



------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


end architecture;
	




