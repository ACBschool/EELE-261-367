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
	component clock_div_prec 
		port(Clock_in 	: in std_logic;
			  Reset		: in std_logic;
		     Sel			: in std_logic_vector(1 downto 0);
		     Clock_out	: out std_logic);
	end component;
	
------------------------------------------------------------------------------------------------	
---------------------------Internal-signals-----------------------------------------------------
------------------------------------------------------------------------------------------------

	
	
	signal ClockDiv 	: std_logic;		--divided clock;
	signal CNT			: std_logic_vector(23 downto 0);
	signal CNT_uns		: unsigned(23 downto 0);
	signal BCD0			: unsigned(3 downto 0);
	signal BCD1			: unsigned(3 downto 0);
	signal BCD2			: unsigned(3 downto 0);
	signal BCD3			: unsigned(3 downto 0);
	signal BCD4			: unsigned(3 downto 0);
	signal BCD5			: unsigned(3 downto 0);
	
	
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
	LEDR(0) <= ClockDiv;
	GPIO(0) <= ClockDiv;
	
------------------------------------------------------------------------------------------------
------------------------------Clock-divider-subsystem-------------------------------------------
------------------------------------------------------------------------------------------------
	
	
	--Clock divider instantiation
	CLK : clock_div_prec port map (Clock_In => CLock_50, Reset => Reset, Sel => (SW(1) & SW(0)), Clock_out => ClockDiv);
	
	--Sel = "00 => 1Hz
	--Sel = "01" => 10Hz
	--Sel = "10" => 100Hz
	--Sel = "11" => 1kHz
------------------------------------------------------------------------------------------------
--------------------------------------HEX-displays-subsystem------------------------------------
------------------------------------------------------------------------------------------------

	-- HEX component instantiation
	
	C0	: char_decoder port map ( BIN_IN => std_logic_vector(BCD0) , HEX_OUT => HEX0);
	C1	: char_decoder port map ( BIN_IN => std_logic_vector(BCD1) , HEX_OUT => HEX1);
	C2	: char_decoder port map ( BIN_IN => std_logic_vector(BCD2) , HEX_OUT => HEX2);
	C3	: char_decoder port map ( BIN_IN => std_logic_vector(BCD3) , HEX_OUT => HEX3);
	C4	: char_decoder port map ( BIN_IN => std_logic_vector(BCD4) , HEX_OUT => HEX4);
	C5	: char_decoder port map ( BIN_IN => std_logic_vector(BCD5) , HEX_OUT => HEX5);





------------------------------------------------------------------------------------------------
------------------------------------BCD0-Process-Counter--------------------------------------
------------------------------------------------------------------------------------------------
	
	BCD_0 : process (ClockDiv, Reset)
	
		begin
			
			if (Reset = '0') then
				BCD0 <= x"0";		-- write 24 0's or 6 0's with x in front: x symbolizes that the proceeding value is HEX
			
			elsif (rising_edge(ClockDiv)) then
				if(BCD0 = x"9") then
					BCD0 <= x"0";
				else
					BCD0 <= BCD0 + 1;			-- update counter on rising edge of divided clock
				
				end if;
				
			end if;
	
	
	end process;

------------------------------------------------------------------------------------------------
------------------------------------BCD1-Process-Counter--------------------------------------
------------------------------------------------------------------------------------------------
	
	BCD_1 : process (ClockDiv, Reset)
	
		begin
			
			if (Reset = '0') then
				BCD1 <= x"0";		-- write 24 0's or 6 0's with x in front: x symbolizes that the proceeding value is HEX
			
			elsif (rising_edge(ClockDiv)) then
				if(BCD1 = x"9" and BCD0 = x"9") then
					BCD1 <= x"0";
					
				elsif(BCD0 = x"9") then
					
					BCD1 <= BCD1 + 1;			-- update counter on rising edge of divided clock
				
				end if;
				
			end if;
	
	
	end process;
	
	

------------------------------------------------------------------------------------------------
------------------------------------BCD2-Process-Counter--------------------------------------
------------------------------------------------------------------------------------------------
	
	BCD_2 : process (ClockDiv, Reset)
	
		begin
			
			if (Reset = '0') then
				BCD2 <= x"0";		-- write 24 0's or 6 0's with x in front: x symbolizes that the proceeding value is HEX
			
			elsif (rising_edge(ClockDiv)) then
				if(BCD2 = x"9" and BCD1 = x"9" and BCD0 = x"9") then
					BCD2 <= x"0";
					
				elsif(BCD1 = x"9" and BCD0 = x"9") then
					
					BCD2 <= BCD2 + 1;			-- update counter on rising edge of divided clock
				
				end if;
				
			end if;
	
	
	end process;
	
------------------------------------------------------------------------------------------------
------------------------------------BCD3-Process-Counter--------------------------------------
------------------------------------------------------------------------------------------------
	
	BCD_3 : process (ClockDiv, Reset)
	
		begin
			
			if (Reset = '0') then
				BCD3 <= x"0";		-- write 24 0's or 6 0's with x in front: x symbolizes that the proceeding value is HEX
			
			elsif (rising_edge(ClockDiv)) then
				if(BCD3 = x"9" and BCD2 = x"9" and BCD1 = x"9" and BCD0 = x"9") then
					BCD3 <= x"0";
					
				elsif(BCD2 = x"9" and BCD1 = x"9" and BCD0 = x"9") then
					
					BCD3 <= BCD3 + 1;			-- update counter on rising edge of divided clock
				
				end if;
				
			end if;
	
	
	end process;


------------------------------------------------------------------------------------------------
------------------------------------BCD4-Process-Counter--------------------------------------
------------------------------------------------------------------------------------------------
	
	BCD_4 : process (ClockDiv, Reset)
	
		begin
			
			if (Reset = '0') then
				BCD4 <= x"0";		-- write 24 0's or 6 0's with x in front: x symbolizes that the proceeding value is HEX
			
			elsif (rising_edge(ClockDiv)) then
				if(BCD4 = x"9" and BCD3 = x"9" and BCD2 = x"9" and BCD1 = x"9" and BCD0 = x"9") then
					BCD4 <= x"0";
					
				elsif(BCD3 = x"9" and BCD2 = x"9" and BCD1 = x"9" and BCD0 = x"9") then
					
					BCD4 <= BCD4 + 1;			-- update counter on rising edge of divided clock
				
				end if;
				
			end if;
	
	
	end process;


------------------------------------------------------------------------------------------------
------------------------------------BCD5-Process-Counter--------------------------------------
------------------------------------------------------------------------------------------------
	
	BCD_5 : process (ClockDiv, Reset)
	
		begin
			
			if (Reset = '0') then
				BCD5 <= x"0";		-- write 24 0's or 6 0's with x in front: x symbolizes that the proceeding value is HEX
			
			elsif (rising_edge(ClockDiv)) then
				if(BCD5 = x"9" and BCD4 = x"9" and BCD3 = x"9" and BCD2 = x"9" and BCD1 = x"9" and BCD0 = x"9") then
					BCD5 <= x"0";
					
				elsif(BCD4 = x"9" and BCD3 = x"9" and BCD2 = x"9" and BCD1 = x"9" and BCD0 = x"9") then
					
					BCD5 <= BCD5 + 1;			-- update counter on rising edge of divided clock
				
				end if;
				
			end if;
	
	
	end process;

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


end architecture;
	




