library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity rom_128x8_sync is
	port(address : in std_logic_vector(7 downto 0);
	     clock   : in std_logic;
	     data_out: out std_logic_vector(7 downto 0));
end entity;



architecture rom_128x8_sync_arch of rom_128x8_sync is 

	constant LDA_IMM : std_logic_vector(7 downto 0) := x"86";
	constant LDA_DIR : std_logic_vector(7 downto 0) := x"87";
	constant LDB_IMM : std_logic_vector(7 downto 0) := x"88";
	constant LDB_DIR : std_logic_vector(7 downto 0) := x"89";
	constant STA_DIR : std_logic_vector(7 downto 0) := x"96";
	constant STB_DIR : std_logic_vector(7 downto 0) := x"97";
	constant ADD_AB  : std_logic_vector(7 downto 0) := x"42";
	constant SUB_AB  : std_logic_vector(7 downto 0) := x"43";
	constant AND_AB  : std_logic_vector(7 downto 0) := x"44";
	constant OR_AB   : std_logic_vector(7 downto 0) := x"45";
	constant INCA    : std_logic_vector(7 downto 0) := x"46";
	constant INCB    : std_logic_vector(7 downto 0) := x"47";
	constant DECA	 : std_logic_vector(7 downto 0) := x"48";
	constant DECB	 : std_logic_vector(7 downto 0) := x"49";
	constant BRA	 : std_logic_vector(7 downto 0) := x"20";
	constant BMI	 : std_logic_vector(7 downto 0) := x"21";
	constant BPL	 : std_logic_vector(7 downto 0) := x"22";
	constant BEQ	 : std_logic_vector(7 downto 0) := x"23";
	constant BNE	 : std_logic_vector(7 downto 0) := x"24";
	constant BVS	 : std_logic_vector(7 downto 0) := x"25";
	constant BVC	 : std_logic_vector(7 downto 0) := x"26";
	constant BCS	 : std_logic_vector(7 downto 0) := x"27";
	constant BCC	 : std_logic_vector(7 downto 0) := x"28";
	signal EN : std_logic;


	type ROM_type is array(0 to 127) of std_logic_vector(7 downto 0);

	constant ROM : ROM_type := (0	=> LDA_IMM,
				    1  	=> x"AA",
				    2	=> LDA_DIR,
				    3	=> x"F0",	-- address of first input port
				    4	=> STA_DIR,
				    5	=> x"E0",	--address of first output port
				    6	=> BRA,
				    7	=> x"00",
				    others => x"00");



	begin







end architecture;
