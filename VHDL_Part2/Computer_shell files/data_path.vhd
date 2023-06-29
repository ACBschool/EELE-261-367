library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity data_path is
	port ( clock	: in std_logic;
	       reset	: in std_logic;
	       Bus1_Sel : in std_logic_vector(1 downto 0);
	       Bus2_Sel : in std_logic_vector(1 downto 0);
	       IR_Load  : in std_logic;
	       MAR_Load : in std_logic;
	       PC_Load  : in std_logic;
	       PC_Inc   : in std_logic;
	       A_Load   : in std_logic;
	       B_load   : in std_logic;
	       ALU_Sel  : in std_logic_vector( 2 downto 0);
	       CCR_Load : in std_logic;
	       from_memory : in std_logic_vector(7 downto 0);
	       to_memory   : out std_logic_vector(7 downto 0);
	       address	   : out std_logic_vector(7 downto 0);
	       IR	   : out std_logic_vector(7 downto 0);
	       CCR_Result  : out std_logic_vector(3 downto 0));
end entity;



architecture data_path_arch of data_path is

	component alu 
		port ( BUS1  : in std_logic_vector(7 downto 0);
		       B     : in std_logic_vector(7 downto 0);
		       ALU_Sel : in std_logic_vector(2 downto 0);
		       ALU_Result : out std_logic_vector(7 downto 0);
		       NZVC 	: out std_logic_vector(3 downto 0));
	end component;

	signal Bus2 : std_logic_vector(7 downto 0);
	signal Bus1 : std_logic_vector(7 downto 0);
	signal ALU_Sel_internal : std_logic_vector(2 downto 0);
	signal ALU_Result_internal : std_logic_vector(7 downto 0);
	signal NZVC_internal : std_logic_vector(3 downto 0);
	signal PC,A,B,MAR : std_logic_vector(7 downto 0);
	signal PC_uns : unsigned(7 downto 0);



	begin
		
----------------ALU-Instantiation-----------------------------------------------------
		ALU_inst : alu
			port map ( BUS1 => Bus1,
				   B => B,
				   ALU_Sel => ALU_Sel_internal,
				   ALU_Result => ALU_Result_internal,
				   NZVC	=> NZVC_internal );
--------------------------------------------------------------------------------------				













end architecture;
