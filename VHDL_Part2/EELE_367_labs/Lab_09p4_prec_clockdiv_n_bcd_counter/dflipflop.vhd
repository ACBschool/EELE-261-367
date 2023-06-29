library IEEE;
use IEEE.std_logic_1164.all;

entity dflipflop is
   port(Reset, Clock, D	: in std_logic;
	Q, Qn		: out std_logic);
end entity;


architecture dflipflop_arch of dflipflop is


   begin

     D_Flip_Flop : process (Reset, Clock)
	begin
	   if( Reset = '0') then 	-- reset condition has highest priority
		Q <= '0'; Qn <= '1';

	   elsif (rising_edge(Clock)) then 	-- update on rising edge of clock
		Q <= D; Qn <= not D;

	   end if;	-- no else clause signifies the store functionality of D-flip-flop
     end process;

end architecture;
