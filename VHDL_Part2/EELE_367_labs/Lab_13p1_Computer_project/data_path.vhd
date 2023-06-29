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
	signal ALU_Result : std_logic_vector(7 downto 0);
	signal NZVC : std_logic_vector(3 downto 0);
	signal PC,A,B,MAR : std_logic_vector(7 downto 0);
	signal PC_uns : unsigned(7 downto 0);



	begin
		
----------------ALU-Instantiation-----------------------------------------------------
		ALU_inst : alu
			port map ( BUS1 => Bus1,
				   B => B,
				   ALU_Sel => ALU_Sel,
				   ALU_Result => ALU_Result,
				   NZVC	=> NZVC );
--------------------------------------------------------------------------------------				

		MUX_BUS1 : process ( Bus1_Sel, PC,A,B)
			begin
				case(Bus1_Sel) is
					when "00" => Bus1 <= PC;
					when "01" => Bus1 <= A;
					when "10" => Bus1 <= B;
					when others => Bus1 <= x"00";
				end case;
		end process;
--------------------------------------------------------------------------------------	
		
		MUX_BUS2 : process ( Bus2_Sel, ALU_Result, Bus1, from_memory)
			begin
				case(Bus2_Sel) is
					when "00" => Bus2 <= ALU_Result;
					when "01" => Bus2 <= Bus1;
					when "10" => Bus2 <= from_memory;
					when others => Bus2 <= x"00";
				end case;
		end process;

		address <= MAR;
		to_memory <= Bus1;
--------------------------------------------------------------------------------------	

		INSTRUCTION_REGISTER : process (clock, reset)
			begin
				if(reset = '0') then
					IR <= x"00";
				elsif(rising_edge(clock)) then
					if(IR_Load = '1') then 
						IR <= Bus2;
					end if;
				end if;
		end process;
--------------------------------------------------------------------------------------	
		MEMORY_ADDRESS_REGISTER : process (clock, reset)
			begin
				if(reset = '0') then
					MAR <= x"00";
				elsif(rising_edge(clock)) then
					if(MAR_Load = '1') then
						MAR <= Bus2;
					end if;
				end if;
		end process;
--------------------------------------------------------------------------------------	
		PROGRAM_COUNTER : process(clock, reset)
			begin
				if(reset = '0') then 
					PC_uns <= x"00";
				elsif(rising_edge(clock)) then
					if(PC_Load = '1') then
						PC_uns <= unsigned(Bus2);
					elsif(PC_Inc = '1') then
						PC_uns <= PC_uns + 1;
					end if;
				end if;
		end process;
		
		PC <= std_logic_vector(PC_uns);
--------------------------------------------------------------------------------------	
		A_RESISTER : process(clock, reset)
			begin
				if(reset = '0') then
					A <= x"00";
				elsif(rising_edge(clock)) then
					if( A_Load = '1') then
						A <= Bus2;
					end if;
				end if;
		end process;

--------------------------------------------------------------------------------------	     

		B_RESISTER : process(clock, reset)
			begin
				if(reset = '0') then
					B <= x"00";
				elsif(rising_edge(clock)) then
					if( B_Load = '1') then
						B <= Bus2;
					end if;
				end if;
		end process;
--------------------------------------------------------------------------------------	

		CONDITION_CODE_REGISTER : process(clock,reset)
			begin
				if(reset = '0') then
					CCR_Result <= x"0";
				elsif(rising_edge(clock)) then
					if(CCR_Load = '1') then
						CCR_Result <= NZVC;
					end if;
				end if;
		end process;
--------------------------------------------------------------------------------------	
		


				













end architecture;