library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- precision clock divider using a counter approach to induce a specific clock frequency
-- options, 1Hz with T = 1sec, 10Hz with T = 100ms, 100Hz with T = 10ms, and 1kHz with T = 1ms;
--input clock is 50MHz with T = 20ns.
--Counter value for 1Hz is 25 Million counts
--Counter value for 10Hz is 2.5 million counts
--Counter value for 100Hz is 250 thousand counts
--Counter value for 1KHz is 25 thousand counts



entity clock_div_prec is
	port(Clock_in		: in std_logic;
		  Reset			: in std_logic;
		  Sel				: in std_logic_vector(1 downto 0);
		  Clock_out		: out std_logic);
end entity;


architecture clock_div_prec_arch of clock_div_prec is


	signal CNT_int	: integer;		-- allow arithmetic in counter
	signal Max_cnt : integer;		-- hold max counter value
	signal Clock_div : std_logic;


	begin
	

	
		CLOCK_DIV_PROC : process(Clock_in,Reset)
		
			begin
				if (Reset = '0') then
					CNT_int <= 0;
					
				elsif (rising_edge(Clock_in)) then
					if (Max_cnt < CNT_int) then
						CNT_int <= Max_cnt;
				
					elsif (Max_cnt = CNT_int) then
					
						Clock_div <= not Clock_div;
						CNT_int <= 0;
						
					else
					
						CNT_int <= CNT_int + 1;
						
					end if;
					
				end if;
					
		end process;
	

		Clock_out <= Clock_div;
	
		MUX : process(Sel) 		-- Set Maximum counter value
	
	
			begin
				case Sel is
					when "00" => Max_cnt <= 25000000;	--1Hz
					when "01" => Max_cnt <= 2500000;		--10Hz
					when "10" => Max_cnt <= 250000;		--100Hz
					when "11" => Max_cnt <= 25000;		--1kHz
				end case;
		end process;
	
	
end architecture;


