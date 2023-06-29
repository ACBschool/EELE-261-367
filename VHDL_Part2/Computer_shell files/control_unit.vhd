library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity control_unit is
	port ( clock	 : in std_logic;
	       reset	 : in std_logic;
	       IR	 : in std_logic_vector(7 downto 0);
	       CCR_Result: in std_logic_vector(3 downto 0);
	       IR_Load   : out std_logic;
	       MAR_Load  : out std_logic;
	       PC_Load	 : out std_logic;
	       PC_Inc	 : out std_logic;
	       A_Load	 : out std_logic;
	       B_load	 : out std_logic;
	       ALU_Sel	 : out std_logic_vector(2 downto 0);
	       CCR_Load	 : out std_logic;
	       Bus2_Sel	 : out std_logic_vector(1 downto 0);
	       Bus1_Sel	 : out std_logic_vector(1 downto 0);
	       write	 : out std_logic);
end entity;  


architecture control_unit_arch of control_unit is

------------------------Instruction-Constants-------------------------------------------
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
-----------------------------------------------------------------------------------------


	type state_type is
		(S_FETCH_0, S_FETCH_1,S_FETCH_2,
		 S_DECODE_3,
		 S_LDA_IMM_4, S_LDA_IMM_5, S_LDA_IMM_6,
		 S_LDA_DIR_4, S_LDA_DIR_5, S_LDA_DIR_6, S_LDA_DIR_7, S_LDA_DIR_8,
		 S_STA_DIR_4, S_STA_DIR_5, S_STA_DIR_6, S_STA_DIR_7,
		 --S_ADD_AB_4,
		 S_BRA_4, S_BRA_5, S_BRA_6--,
		 --S_BEQ_4, S_BEQ_5, S_BEQ_6, S_BEQ_7
							);

	signal current_state, next_state : state_type;



	begin


end architecture;






