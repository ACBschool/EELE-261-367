library IEEE;
use IEEE. std_logic_1164.all;

entity clock_div_2ton is
	port(Clock_In 	: in std_logic;
		  Reset		: in std_logic;
		  Sel			: in std_logic_vector(1 downto 0);
		  clock_Out	: out std_logic);
end entity;


architecture clock_div_2ton_arch of clock_div_2ton is

-----------------------------------------------------------------------------------------------------
------------------Component-Subsystems---------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

	component dflipflop 
		port(Reset, Clock, D	: in std_logic;
			  Q, Qn				: out std_logic);
	end component;

-----------------------------------------------------------------------------------------------------
-----------------------------Internal-Signals--------------------------------------------------------
-----------------------------------------------------------------------------------------------------
	signal CNT, CNTn	: std_logic_vector(25 downto 0);	-- internal signals
	

-----------------------------------------------------------------------------------------------------	
----------------------------------Begin-Modeling-----------------------------------------------------	
-----------------------------------------------------------------------------------------------------	
	
	begin
	

-----------------------------------------------------------------------------------------------------	
----------------------------------Ripple-counter-Instantiation---------------------------------------	
-----------------------------------------------------------------------------------------------------	
	
	-- DFF instantiation:    reset,clock,   D,    Q   ,  Qn	: Ripple counter
	
	D0 : dflipflop port map (Reset,Clock_In,CNTn(0),CNT(0),CNTn(0));		--50MHz
--***************************************************************************************************	
	D1 : dflipflop port map (Reset,CNTn(0),CNTn(1),CNT(1),CNTn(1));		--25MHz		**
--***************************************************************************************************	
	D2 : dflipflop port map (Reset,CNTn(1),CNTn(2),CNT(2),CNTn(2));		--12.5MHz
	D3 : dflipflop port map (Reset,CNTn(2),CNTn(3),CNT(3),CNTn(3));		--6.25MHz
	D4 : dflipflop port map (Reset,CNTn(3),CNTn(4),CNT(4),CNTn(4));		--3.125MHz
	D5 : dflipflop port map (Reset,CNTn(4),CNTn(5),CNT(5),CNTn(5));		--1.5625MHz
	D6 : dflipflop port map (Reset,CNTn(5),CNTn(6),CNT(6),CNTn(6));		--781.250kHz
	D7 : dflipflop port map (Reset,CNTn(6),CNTn(7),CNT(7),CNTn(7));		--390.625kHz
	D8 : dflipflop port map (Reset,CNTn(7),CNTn(8),CNT(8),CNTn(8));		--195.3125kHz
	D9 : dflipflop port map (Reset,CNTn(8),CNTn(9),CNT(9),CNTn(9));		--97.65625kHz
	D10: dflipflop port map (Reset,CNTn(9),CNTn(10),CNT(10),CNTn(10));	--48.828125kHz
	D11: dflipflop port map (Reset,CNTn(10),CNTn(11),CNT(11),CNTn(11));	--24.4140625kHz
	D12: dflipflop port map (Reset,CNTn(11),CNTn(12),CNT(12),CNTn(12));	--12.20703125kHz
	D13: dflipflop port map (Reset,CNTn(12),CNTn(13),CNT(13),CNTn(13));	--6.103515625kHz
	D14: dflipflop port map (Reset,CNTn(13),CNTn(14),CNT(14),CNTn(14));	--3.0517578125kHz
	D15: dflipflop port map (Reset,CNTn(14),CNTn(15),CNT(15),CNTn(15));	--1.52587890625kHz
	D16: dflipflop port map (Reset,CNTn(15),CNTn(16),CNT(16),CNTn(16));	--762.939453125Hz
	D17: dflipflop port map (Reset,CNTn(16),CNTn(17),CNT(17),CNTn(17));	--381.469726563Hz
--***************************************************************************************************	
	D18: dflipflop port map (Reset,CNTn(17),CNTn(18),CNT(18),CNTn(18));	--190.734863281Hz		**
--***************************************************************************************************	
	D19: dflipflop port map (Reset,CNTn(18),CNTn(19),CNT(19),CNTn(19));	--95.3674316406Hz
	D20: dflipflop port map (Reset,CNTn(19),CNTn(20),CNT(20),CNTn(20));	--47.6837158203Hz
	D21: dflipflop port map (Reset,CNTn(20),CNTn(21),CNT(21),CNTn(21));	--23.8418579102Hz
	D22: dflipflop port map (Reset,CNTn(21),CNTn(22),CNT(22),CNTn(22));	--11.9209289551Hz
-----------------------------------------------------------------------------------------------------
--***************************************************************************************************
	D23: dflipflop port map (Reset,CNTn(22),CNTn(23),CNT(23),CNTn(23));	--5.96046447754Hz		**
--***************************************************************************************************
-----------------------------------------------------------------------------------------------------
	D24: dflipflop port map (Reset,CNTn(23),CNTn(24),CNT(24),CNTn(24));	--2.98023223877Hz
-----------------------------------------------------------------------------------------------------
--***************************************************************************************************
	D25: dflipflop port map (Reset,CNTn(24),CNTn(25),CNT(25),CNTn(25));	--1.49011611938Hz		**
--***************************************************************************************************	
	
-----------------------------------------------------------------------------------------------------
------------------------4=>1-Multiplexer-Clock-Slection----------------------------------------------
-----------------------------------------------------------------------------------------------------
	
	MUX : process(Sel) 		--choose different clock frequencies
	
	
		begin
			case Sel is
				when "00" => Clock_Out <= CNTn(0);
				when "01" => Clock_Out <= CNTn(17);
				when "10" => Clock_Out <= CNTn(22);
				when "11" => Clock_Out <= CNTn(24);
			end case;
	end process;
-----------------------------------------------------------------------------------------------------
	


end architecture;