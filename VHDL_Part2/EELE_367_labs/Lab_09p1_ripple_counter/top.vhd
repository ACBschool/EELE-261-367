library IEEE;
use IEEE.std_logic_1164.all;

entity top is 

	port(Clock	: in std_logic;
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


	-- hex decoder component
	component char_decoder
		port(BIN_IN		: in std_logic_vector (3 downto 0);
			  HEX_OUT	: out std_logic_vector ( 6 downto 0));
	end component;
	
	--d flip flop component
	component dflipflop 
		port(Reset, Clock, D	: in std_logic;
			  Q, Qn		: out std_logic);
	end component;
	
	
	
	
	--used to driver wiring for toggle flop configuration
	signal CNT, CNTn	: std_logic_vector(37 downto 0);	-- internal signals
	
	
	
	
	
	begin
	

	
	-- HEX component instantiation
	
	C0	: char_decoder port map ( BIN_IN => CNT(17 downto 14) , HEX_OUT => HEX0);
	C1	: char_decoder port map ( BIN_IN => CNT(21 downto 18) , HEX_OUT => HEX1);
	C2	: char_decoder port map ( BIN_IN => CNT(25 downto 22) , HEX_OUT => HEX2);
	C3	: char_decoder port map ( BIN_IN => CNT(29 downto 26) , HEX_OUT => HEX3);
	C4	: char_decoder port map ( BIN_IN => CNT(33 downto 30) , HEX_OUT => HEX4);
	C5	: char_decoder port map ( BIN_IN => CNT(37 downto 34) , HEX_OUT => HEX5);


	--display LED's and Logic analyzer setup.
	LEDR <= CNT(37 downto 28);
	GPIO <= CNT(7 downto 0);
	
	-- DFF instantiation:    reset,clock,   D,    Q   ,  Qn	: Ripple counter
	
	D0 : dflipflop port map (Reset,Clock,CNTn(0),CNT(0),CNTn(0));
	D1 : dflipflop port map (Reset,CNTn(0),CNTn(1),CNT(1),CNTn(1));
	D2 : dflipflop port map (Reset,CNTn(1),CNTn(2),CNT(2),CNTn(2));
	D3 : dflipflop port map (Reset,CNTn(2),CNTn(3),CNT(3),CNTn(3));
	D4 : dflipflop port map (Reset,CNTn(3),CNTn(4),CNT(4),CNTn(4));
	D5 : dflipflop port map (Reset,CNTn(4),CNTn(5),CNT(5),CNTn(5));
	D6 : dflipflop port map (Reset,CNTn(5),CNTn(6),CNT(6),CNTn(6));
	D7 : dflipflop port map (Reset,CNTn(6),CNTn(7),CNT(7),CNTn(7));
	D8 : dflipflop port map (Reset,CNTn(7),CNTn(8),CNT(8),CNTn(8));
	D9 : dflipflop port map (Reset,CNTn(8),CNTn(9),CNT(9),CNTn(9));
	D10: dflipflop port map (Reset,CNTn(9),CNTn(10),CNT(10),CNTn(10));
	D11: dflipflop port map (Reset,CNTn(10),CNTn(11),CNT(11),CNTn(11));
	D12: dflipflop port map (Reset,CNTn(11),CNTn(12),CNT(12),CNTn(12));
	D13: dflipflop port map (Reset,CNTn(12),CNTn(13),CNT(13),CNTn(13));
	D14: dflipflop port map (Reset,CNTn(13),CNTn(14),CNT(14),CNTn(14));
	D15: dflipflop port map (Reset,CNTn(14),CNTn(15),CNT(15),CNTn(15));
	D16: dflipflop port map (Reset,CNTn(15),CNTn(16),CNT(16),CNTn(16));
	D17: dflipflop port map (Reset,CNTn(16),CNTn(17),CNT(17),CNTn(17));
	D18: dflipflop port map (Reset,CNTn(17),CNTn(18),CNT(18),CNTn(18));
	D19: dflipflop port map (Reset,CNTn(18),CNTn(19),CNT(19),CNTn(19));
	D20: dflipflop port map (Reset,CNTn(19),CNTn(20),CNT(20),CNTn(20));
	D21: dflipflop port map (Reset,CNTn(20),CNTn(21),CNT(21),CNTn(21));
	D22: dflipflop port map (Reset,CNTn(21),CNTn(22),CNT(22),CNTn(22));
	D23: dflipflop port map (Reset,CNTn(22),CNTn(23),CNT(23),CNTn(23));
	D24: dflipflop port map (Reset,CNTn(23),CNTn(24),CNT(24),CNTn(24));
	D25: dflipflop port map (Reset,CNTn(24),CNTn(25),CNT(25),CNTn(25));
	D26: dflipflop port map (Reset,CNTn(25),CNTn(26),CNT(26),CNTn(26));
	D27: dflipflop port map (Reset,CNTn(26),CNTn(27),CNT(27),CNTn(27));
	D28: dflipflop port map (Reset,CNTn(27),CNTn(28),CNT(28),CNTn(28));
	D29: dflipflop port map (Reset,CNTn(28),CNTn(29),CNT(29),CNTn(29));
	D30: dflipflop port map (Reset,CNTn(29),CNTn(30),CNT(30),CNTn(30));
	D31: dflipflop port map (Reset,CNTn(30),CNTn(31),CNT(31),CNTn(31));
	D32: dflipflop port map (Reset,CNTn(31),CNTn(32),CNT(32),CNTn(32));
	D33: dflipflop port map (Reset,CNTn(32),CNTn(33),CNT(33),CNTn(33));
	D34: dflipflop port map (Reset,CNTn(33),CNTn(34),CNT(34),CNTn(34));
	D35: dflipflop port map (Reset,CNTn(34),CNTn(35),CNT(35),CNTn(35));
	D36: dflipflop port map (Reset,CNTn(35),CNTn(36),CNT(36),CNTn(36));
	D37: dflipflop port map (Reset,CNTn(36),CNTn(37),CNT(37),CNTn(37));
	

	
end architecture;
	




