library IEEE;
use IEEE.std_logic_1164.all;


entity UpDown is
	
	port (Clock , Reset , Up  : in std_logic;
	      CNT		  : out std_logic_vector(1 downto 0));

end entity;


architecture UpDown_arch of UpDown is 

type State_Type is (C0, C1, C2, C3);
signal current_state, next_state : State_Type;

begin
-----------------------------------------------------------
	STATE_MEMORY : process (Clock, Reset)
		begin
			if (Reset = '0') then
				current_state <= C0;
			elsif (rising_edge(Clock)) then
				current_state <= next_state;
			end if;
	end process;

------------------------------------------------------------
	NEXT_STATE_LOGIC : process (current_state, Up) 
		begin
			case (current_state) is
				when C0 => if (Up = '1') then
						next_state <= C1;
					   else
						next_state <= C3;
					   end if;
				when C1 => if (Up = '1') then
						next_state <= C2;
					   else 
						next_state <= C0;
					   end if;
				when C2 => if (Up = '1') then
						next_state <= C3;
					   else 
						next_state <= C1;
					   end if;
				when C3 => if (Up = '1') then
						next_state <= C0;
					   else 
						next_state <= C2;
					   end if;
				when others => next_state <= C0;
			end case;
	end process;
----------------------------------------------------------------------
	OUTPUT_LOGIC : process (current_state)
		begin
			case (current_state) is
				when C0 => CNT <= "00";
				when C1 => CNT <= "01";
				when C2 => CNT <= "10";
				when C3 => CNT <= "11";
				when others => CNT <= "00";
			end case;
	end process;

end architecture;














