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
	constant BRA	 : std_logic_vector(7 downto 0) := x"20"; -- BRANCH ALWAYS
	constant BMI	 : std_logic_vector(7 downto 0) := x"21"; -- BRANCH IF NEGATIVE
	constant BPL	 : std_logic_vector(7 downto 0) := x"22";
	constant BEQ	 : std_logic_vector(7 downto 0) := x"23"; -- BRANCE IF ZERO
	constant BNE	 : std_logic_vector(7 downto 0) := x"24"; 
	constant BVS	 : std_logic_vector(7 downto 0) := x"25"; -- 2'S COMP OVERFLOW
	constant BVC	 : std_logic_vector(7 downto 0) := x"26"; -- BRANCH IF CARRY
	constant BCS	 : std_logic_vector(7 downto 0) := x"27";
	constant BCC	 : std_logic_vector(7 downto 0) := x"28";
	signal EN : std_logic;


	type ROM_type is array(0 to 127) of std_logic_vector(7 downto 0);

	constant ROM : ROM_type := (
				    0	=> LDA_DIR, -- load from first input port
				    1 => x"F2",
				    2	=> STA_DIR,
				    3	=> x"E1",	-- store the result into the first output port
				    4	=> STA_DIR,
				    5	=> x"E2",	-- store the result into the second output port
			       6	=> LDB_DIR,
				    7	=> x"F0",	-- store the result into the third output port
			       8 => STB_DIR,
				    9	=> x"E3",	-- store the result into the fourth output port
				    10 => STB_DIR,
				    11 => x"E4",
				    12 => BRA,		-- branch back and repeat program
				    13 => x"00",
				    others => x"00");
					 
----------------------------------------------------------------------------------------------------					 
					 
	constant ROM_ADD : ROM_type := ( -- demonstration for adding and LDB_DIR AND STB_DIR
					0 => LDB_DIR,
					1 => x"F0",
					2 => LDA_DIR,
					3 => x"F2",
					4 => STA_DIR,
					5 => x"E1",
					6 => STB_DIR,
					7 => x"E2",
					8 => ADD_AB,
					9 => STA_DIR,
					10 => x"E3",
					11 => BRA,
					12 => x"00",
					others => x"00");
----------------------------------------------------------------------------------------------------	
	constant ROM_AND_OR : ROM_type := (
					0 => LDA_DIR, -- FPGA SWITCHES
					1 => x"F0",
					2 => LDB_DIR, -- external switch
					3 => x"F2",
					4 => STA_DIR,
					5 => x"E1",
					6 => STB_DIR,
					7 => x"E2",
					8 => AND_AB,
					9 => STA_DIR,
					10 => x"E3",
					11 => BEQ,
					12 => x"12",
					13 => SUB_AB,
					14 => STA_DIR,
					15 => x"E3",
					16 => BMI, -- if negative, skip INCA instruction and OR A and B
					17 => x"15",
					18 => INCA, -- IF RESULT IS ZERO INCA
					19 => STA_DIR,
					20 => x"E1",
					21 => OR_AB,
					22 => STA_DIR,
					23 => x"E3",
					24 => BRA,
					25 => x"00",
					others => x"00");
----------------------------------------------------------------------------------------------------
	constant ROM_INC : ROM_type := (
					0 => LDA_DIR, -- FPGA SWITCHES
					1 => x"F0",
					2 => LDB_DIR, -- external switch
					3 => x"F2",
					4 => STA_DIR,
					5 => x"E1",
					6 => STB_DIR,
					7 => x"E2",
					8 => INCA,
					9 => STA_DIR,
					10 => x"E1",
					11 => INCB,
					12 => STB_DIR,
					13 => x"E2",
					14 => DECA,
					15 => STA_DIR,
					16 => x"E1",
					17 => DECB,
					18 => STB_DIR,
					19 => x"E2",
					20 => BRA,
					21 => x"00",
					others => x"00");

----------------------------------------------------------------------------------------------------
	constant ROM_BVS : ROM_type := (
					0 => LDA_DIR, -- FPGA SWITCHES
					1 => x"F0",
					2 => LDB_DIR, -- external switch
					3 => x"F2",
					4 => STA_DIR,
					5 => x"E1",
					6 => STB_DIR,
					7 => x"E2",
					8 => ADD_AB,
					9 => STA_DIR,
					10 => x"E3",
					11 => BVS,
					12 => x"10",
					13 => INCA,
					14 => STA_DIR,
					15 => x"E1",
					16 => LDB_IMM,
					17 => x"F1",
					18 => STB_DIR,
					19 => x"E2",
					20 => SUB_AB,
					21 => STA_DIR,
					22 => x"E3",
					23 => BRA,
					24 => x"00",
					others => x"00");
----------------------------------------------------------------------------------------------------
	constant ROM_BCS : ROM_type := (
					0 => LDA_DIR, -- FPGA SWITCHES
					1 => x"F0",
					2 => LDB_DIR, -- external switch
					3 => x"F2",
					4 => STA_DIR,
					5 => x"E1",
					6 => STB_DIR,
					7 => x"E2",
					8 => ADD_AB,
					9 => STA_DIR,
					10 => x"E3",
					11 => BCS,
					12 => x"10",
					13 => INCA,
					14 => STA_DIR,
					15 => x"E1",
					16 => LDB_IMM,
					17 => x"3A",
					18 => STB_DIR,
					19 => x"E2",
					20 => SUB_AB,
					21 => STA_DIR,
					22 => x"E3",
					23 => BRA,
					24 => x"00",
					others => x"00");
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------					
	



	begin

		ENABLE : process ( address )
			begin
				if((to_integer(unsigned(address)) >= 0) and (to_integer(unsigned(address)) <= 127)) then
				
					EN <= '1';
				else
					EN <= '0';
				end if;
		end process;


		MEMORY : process ( clock )	
			begin
				if(rising_edge(clock)) then
					if(EN = '1') then
						data_out <= ROM_BCS(to_integer(unsigned(address)));
					end if;
				end if;
		end process;






end architecture;