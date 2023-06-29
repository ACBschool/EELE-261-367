library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity cpu is
	port( clock  : in std_logic;
	      reset  : in std_logic;
	      from_memory : in std_logic_vector(7 downto 0);
	      address: out std_logic_vector(7 downto 0);
	      write  : out std_logic;
	      to_memory : out std_logic_vector(7 downto 0));	
end entity;


architecture cpu_arch of cpu is 

	component control_unit 
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
	end component;    
		
	component data_path
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
	end component;

	signal IR_Load_internal : std_logic;
	signal MAR_load_internal : std_logic;
	signal PC_load_internal : std_logic;
	signal PC_Inc_internal  : std_logic;
	signal A_Load_internal : std_logic;
	signal B_load_internal : std_logic;
	signal ALU_Sel_internal : std_logic_vector(2 downto 0);
	signal CCR_Load_internal : std_logic;
	signal Bus2_Sel_internal : std_logic_vector(1 downto 0);
	signal Bus1_Sel_internal : std_logic_vector(1 downto 0);
	signal IR_internal	: std_logic_vector(7 downto 0);
	signal CCR_Result_internal : std_logic_vector(3 downto 0);


	begin
 
----------------CONTROL-UNIT-Instantiation--------------------------------------------
		CTRL_UNT_Inst : control_unit
			port map ( clock      => clock,
				   reset      => reset,
				   IR 	      => IR_internal,
				   CCR_Result => CCR_Result_internal,
				   IR_Load    => IR_Load_internal,
				   MAR_Load   => MAR_Load_internal,
				   PC_Load    => PC_Load_internal,
				   PC_Inc     => PC_Inc_internal,
				   A_Load     => A_Load_internal,
				   B_Load     => B_Load_internal,
				   ALU_Sel    => ALU_Sel_internal,
				   CCR_Load   => CCR_Load_internal,
				   Bus2_Sel   => Bus2_Sel_internal,
				   Bus1_Sel   => Bus1_Sel_internal,
 				   write => write );
----------------DATA-PATH-Instantiation-----------------------------------------------
		DATA_PATH_inst : data_path
			port map ( clock => clock,
				   reset => reset,
				   Bus1_Sel => Bus1_Sel_internal,
			           Bus2_Sel => Bus2_Sel_internal,
				   IR_Load => IR_Load_internal,
				   MAR_Load => MAR_Load_internal,
	 			   PC_Load => PC_Load_internal,
				   PC_Inc => PC_Inc_internal,
				   A_Load => A_Load_internal,
				   B_Load => B_Load_internal,
				   ALU_Sel => ALU_Sel_internal,
				   CCR_Load => CCR_Load_internal,
				   from_memory => from_memory,
				   to_memory => to_memory,
				   address => address,
				   IR => IR_internal,
				   CCR_Result => CCR_Result_internal );
--------------------------------------------------------------------------------------			




end architecture;