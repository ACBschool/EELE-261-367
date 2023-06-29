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
		  GPIO	: out std_logic_vector(7 downto 0));
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
	component clock_div_2ton 
		port(Clock_In 	: in std_logic;
			  Reset		: in std_logic;
		     Sel			: in std_logic_vector(1 downto 0);
		     clock_Out	: out std_logic);
	end component;
	
------------------------------------------------------------------------------------------------	
---------------------------Internal-signals-----------------------------------------------------
------------------------------------------------------------------------------------------------

	
	
	signal Clock_div 	: std_logic;		--divided clock;
	signal CNT			: std_logic_vector(23 downto 0);
	signal CNT_uns		: unsigned(23 downto 0);
	
	
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
	LEDR <= CNT(9 downto 0);
	GPIO <= CNT(7 downto 0);
	
------------------------------------------------------------------------------------------------
------------------------------Clock-divider-subsystem-------------------------------------------
------------------------------------------------------------------------------------------------
	
	
	--Clock divider instantiation
	CLK : clock_div_2ton port map (Clock_In => CLock_50, Reset => Reset, Sel => (SW(1) & SW(0)), Clock_Out => Clock_div);
	
	--Sel = "00 => 25MHz
	--Sel = "01" => 191Hz
	--Sel = "10" => 6Hz
	--Sel = "11" => 1.5Hz
------------------------------------------------------------------------------------------------
--------------------------------------HEX-displays-subsystem------------------------------------
------------------------------------------------------------------------------------------------

	-- HEX component instantiation
	
	C0	: char_decoder port map ( BIN_IN => CNT(3 downto 0) , HEX_OUT => HEX0);
	C1	: char_decoder port map ( BIN_IN => CNT(7 downto 4) , HEX_OUT => HEX1);
	C2	: char_decoder port map ( BIN_IN => CNT(11 downto 8) , HEX_OUT => HEX2);
	C3	: char_decoder port map ( BIN_IN => CNT(15 downto 12) , HEX_OUT => HEX3);
	C4	: char_decoder port map ( BIN_IN => CNT(19 downto 16) , HEX_OUT => HEX4);
	C5	: char_decoder port map ( BIN_IN => CNT(23 downto 20) , HEX_OUT => HEX5);





------------------------------------------------------------------------------------------------
------------------------------------Single-Process-Counter--------------------------------------
------------------------------------------------------------------------------------------------
	
	COUNTER : process (Clock_div, Reset)
	
		begin
			
			if (Reset = '0') then
				CNT_uns <= x"000000";		-- write 24 0's or 6 0's with x in front: x symbolizes that the proceeding value is HEX
			
			elsif (rising_edge(Clock_div)) then
				CNT_uns <= CNT_uns + 1;			-- update counter on rising edge of divided clock
			
			end if;
	
	
	end process;
	
	
	CNT <= std_logic_vector(CNT_uns);		-- concurrently update standard logic Counter with numeric substitute.
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

end architecture;
	




