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
		 S_LDB_IMM_4, S_LDB_IMM_5, S_LDB_IMM_6,
		 S_LDB_DIR_4, S_LDB_DIR_5, S_LDB_DIR_6, S_LDB_DIR_7, S_LDB_DIR_8,
		 S_STB_DIR_4, S_STB_DIR_5, S_STB_DIR_6, S_STB_DIR_7,
		 S_ADD_AB_4,
		 S_SUB_AB_4,
		 S_AND_AB_4,
		 S_OR_AB_4,
		 S_INCA_4,
		 S_INCB_4,
		 S_DECA_4,
		 S_DECB_4,	
		 S_BRA_4, S_BRA_5, S_BRA_6,
		 S_BEQ_4, S_BEQ_5, S_BEQ_6, S_BEQ_7,
		 S_BCS_4, S_BCS_5, S_BCS_6, S_BCS_7,
		 S_BVS_4, S_BVS_5, S_BVS_6, S_BVS_7,
		 S_BMI_4, S_BMI_5, S_BMI_6, S_BMI_7 );

	signal current_state, next_state : state_type;



	begin

	STATE_MEMORY : process(clock, reset) 
		begin
			if(reset = '0') then
				current_state <= S_FETCH_0;
			elsif(rising_edge(clock)) then
				current_state <= next_state;
			end if;
	end process;
---------------------------------------------------------------------------------------------------------------------------	
		NEXT_STATE_LOGIC : process(current_state, IR, CCR_Result)
			begin
				if(current_state = S_FETCH_0) then 
					next_state <= S_FETCH_1;
				elsif(current_state = S_FETCH_1) then 
					next_state <= S_FETCH_2;
				elsif(current_state = S_FETCH_2) then
					next_state <= S_DECODE_3;
				elsif(current_state = S_DECODE_3) then
					if(IR = LDA_IMM) then
						next_state <= S_LDA_IMM_4;
					elsif(IR = LDA_DIR) then 
						next_state <= S_LDA_DIR_4;
					elsif(IR = STA_DIR) then 
						next_state <= S_STA_DIR_4;
					elsif(IR = LDB_IMM) then
						next_state <= S_LDB_IMM_4;
					elsif(IR = LDB_DIR) then
						next_state <= S_LDB_DIR_4;
					elsif(IR = STB_DIR) then
						next_state <= S_STB_DIR_4;
					elsif(IR = BRA) then
						next_state <= S_BRA_4;
					elsif(IR = ADD_AB) then 
						next_state <= S_ADD_AB_4;
					elsif(IR = SUB_AB) then
						next_state <= S_SUB_AB_4;
					elsif(IR = AND_AB) then
						next_state <= S_AND_AB_4;
					elsif(IR = OR_AB) then
						next_state <= S_OR_AB_4;
					elsif(IR = INCA) then
						next_state <= S_INCA_4;
					elsif(IR = INCB) then
						next_state <= S_INCB_4;
					elsif(IR = DECA) then
						next_state <= S_DECA_4;
					elsif(IR = DECB) then
						next_state <= S_DECB_4;
					elsif(IR = BEQ and CCR_Result(2) = '1') then -- BEQ and Z = 1; NZVC
						next_state <= S_BEQ_4;
					elsif(IR = BEQ and CCR_Result(2) = '0') then -- BEQ and Z = 0;
						next_state <= S_BEQ_7;
					elsif(IR = BCS and CCR_Result(0) = '1') then -- BCS and C = 1; NZVC
						next_state <= S_BCS_4;
					elsif(IR = BCS and CCR_Result(0) = '0') then -- BCS and C = 0;
						next_state <= S_BCS_7;
					elsif(IR = BVS and CCR_Result(1) = '1') then -- BVS and V = 1; NZVC
						next_state <= S_BVS_4;
					elsif(IR = BVS and CCR_Result(1) = '0') then -- BVS and V = 0;
						next_state <= S_BVS_7;
					elsif(IR = BMI and CCR_Result(3) = '1') then -- BMI and N = 1; NZVC
						next_state <= S_BMI_4;
					elsif(IR = BMI and CCR_Result(3) = '0') then -- BMI and N = 0;
						next_state <= S_BMI_7;
					else
						next_state <= S_FETCH_0;
					end if;
				-- PATH FOR LDA_IMM
				elsif(current_state = S_LDA_IMM_4) then 					
					next_state <= S_LDA_IMM_5;
				elsif(current_state = S_LDA_IMM_5) then
					next_state <= S_LDA_IMM_6;
				elsif(current_state = S_LDA_IMM_6) then
					next_state <= S_FETCH_0;
				-- PATH FOR LDA_DIR	
				elsif(current_state = S_LDA_DIR_4) then
					next_state <= S_LDA_DIR_5;
				elsif(current_state = S_LDA_DIR_5) then
					next_state <= S_LDA_DIR_6;	
				elsif(current_state = S_LDA_DIR_6) then
					next_state <= S_LDA_DIR_7;
				elsif(current_state = S_LDA_DIR_7) then
					next_state <= S_LDA_DIR_8;
				elsif(current_state = S_LDA_DIR_8) then
					next_state <= S_FETCH_0;
				-- PATH FOR STA_DIR
				elsif(current_state = S_STA_DIR_4) then
					next_state <= S_STA_DIR_5;	
				elsif(current_state = S_STA_DIR_5) then
					next_state <= S_STA_DIR_6;
				elsif(current_state = S_STA_DIR_6) then
					next_state <= S_STA_DIR_7;
				elsif(current_state = S_STA_DIR_7) then
					next_state <= S_FETCH_0;	
				-- PATH FOR LDB_IMM
				elsif(current_state = S_LDB_IMM_4) then 					
					next_state <= S_LDB_IMM_5;
				elsif(current_state = S_LDB_IMM_5) then
					next_state <= S_LDB_IMM_6;
				elsif(current_state = S_LDB_IMM_6) then
					next_state <= S_FETCH_0;
				-- PATH FOR LDB_DIR	
				elsif(current_state = S_LDB_DIR_4) then
					next_state <= S_LDB_DIR_5;
				elsif(current_state = S_LDB_DIR_5) then
					next_state <= S_LDB_DIR_6;	
				elsif(current_state = S_LDB_DIR_6) then
					next_state <= S_LDB_DIR_7;
				elsif(current_state = S_LDB_DIR_7) then
					next_state <= S_LDB_DIR_8;
				elsif(current_state = S_LDB_DIR_8) then
					next_state <= S_FETCH_0;
				-- PATH FOR STB_DIR
				elsif(current_state = S_STB_DIR_4) then
					next_state <= S_STB_DIR_5;	
				elsif(current_state = S_STB_DIR_5) then
					next_state <= S_STB_DIR_6;
				elsif(current_state = S_STB_DIR_6) then
					next_state <= S_STB_DIR_7;
				elsif(current_state = S_STB_DIR_7) then
					next_state <= S_FETCH_0;	
				-- PATH FOR ADD_AB
				elsif(current_state = S_ADD_AB_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR SUB_AB
				elsif(current_state = S_SUB_AB_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR AND_AB
				elsif(current_state = S_AND_AB_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR OR_AB
				elsif(current_state = S_OR_AB_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR INCA
				elsif(current_state = S_INCA_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR INCB
				elsif(current_state = S_INCB_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR DECA
				elsif(current_state = S_DECA_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR DECB
				elsif(current_state = S_DECB_4) then
					next_state <= S_FETCH_0;
				-- PATH FOR BRA
				elsif(current_state = S_BRA_4) then 					
					next_state <= S_BRA_5;
				elsif(current_state = S_BRA_5) then
					next_state <= S_BRA_6;
				elsif(current_state = S_BRA_6) then
					next_state <= S_FETCH_0;		
				-- PATH FOR BEQ
				elsif(current_state = S_BEQ_4) then 					
					next_state <= S_BEQ_5;
				elsif(current_state = S_BEQ_5) then
					next_state <= S_BEQ_6;
				elsif(current_state = S_BEQ_6) then
					next_state <= S_FETCH_0;	
				elsif(current_state = S_BEQ_7) then
					next_state <= S_FETCH_0;
				-- PATH FOR BCS
				elsif(current_state = S_BCS_4) then 					
					next_state <= S_BCS_5;
				elsif(current_state = S_BCS_5) then
					next_state <= S_BCS_6;
				elsif(current_state = S_BCS_6) then
					next_state <= S_FETCH_0;	
				elsif(current_state = S_BCS_7) then
					next_state <= S_FETCH_0;
				-- PATH FOR BVS
				elsif(current_state = S_BVS_4) then 					
					next_state <= S_BVS_5;
				elsif(current_state = S_BVS_5) then
					next_state <= S_BVS_6;
				elsif(current_state = S_BVS_6) then
					next_state <= S_FETCH_0;	
				elsif(current_state = S_BVS_7) then
					next_state <= S_FETCH_0;
				-- PATH FOR BMI
				elsif(current_state = S_BMI_4) then 					
					next_state <= S_BMI_5;
				elsif(current_state = S_BMI_5) then
					next_state <= S_BMI_6;
				elsif(current_state = S_BMI_6) then
					next_state <= S_FETCH_0;	
				elsif(current_state = S_BMI_7) then
					next_state <= S_FETCH_0;
				else 
					next_state <= S_FETCH_0;
		

			
				end if;
		end process;

---------------------------------------------------------------------------------------------------------------------------	
		OUTPUT_LOGIC : process(current_state)
			begin
				case(current_state) is
--------------------------------------------FETCH-DECODE-SEQUENCE----------------------------------------------------------
					when S_FETCH_0 => -- Put PC onto MAR to read Opcode
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';
					when S_FETCH_1 => -- increment PC
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';
					when S_FETCH_2 => -- get stuff from memory 
						IR_Load <= '1';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';
					when S_DECODE_3 => -- decode
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-------------------------------------------------IMMEDIATE-LOAD-A----------------------------------------------------------
					when S_LDA_IMM_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDA_IMM_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDA_IMM_6 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
----------------------------------------------DIRECT-LOAD-A----------------------------------------------------------------	
					when S_LDA_DIR_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDA_DIR_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDA_DIR_6 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDA_DIR_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDA_DIR_8 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
------------------------------------------------STA-DIR--------------------------------------------------------------------	
					when S_STA_DIR_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_STA_DIR_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_STA_DIR_6 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_STA_DIR_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '1';	
-------------------------------------------------IMMEDIATE-LOAD-B----------------------------------------------------------
					when S_LDB_IMM_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDB_IMM_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDB_IMM_6 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '1';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
----------------------------------------------DIRECT-LOAD-B----------------------------------------------------------------	
					when S_LDB_DIR_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDB_DIR_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDB_DIR_6 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDB_DIR_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_LDB_DIR_8 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '1';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
------------------------------------------------STA-DIR-b------------------------------------------------------------------	
					when S_STB_DIR_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_STB_DIR_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_STB_DIR_6 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_STB_DIR_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "10"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '1';	
-----------------------------------------------ADD-AB(A = A + B)-----------------------------------------------------------
					when S_ADD_AB_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-----------------------------------------------SUB-AB(A = A + (-B))-----------------------------------------------------------
					when S_SUB_AB_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "001";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-----------------------------------------------AND-AB(A = A and B)-----------------------------------------------------------
					when S_AND_AB_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "010";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-----------------------------------------------OR-AB(A = A or B)-----------------------------------------------------------
					when S_OR_AB_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "011";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-----------------------------------------------INCA(A = A + 1)-----------------------------------------------------------
					when S_INCA_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "100";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-----------------------------------------------INCB(B = B + 1)-----------------------------------------------------------
					when S_INCB_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '1';
						ALU_Sel <= "101";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-----------------------------------------------DECA(A = A - 1)-----------------------------------------------------------
					when S_DECA_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '1';
						B_Load <= '0';
						ALU_Sel <= "110";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
-----------------------------------------------INCB(B = B - 1)-----------------------------------------------------------
					when S_DECB_4 =>
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '1';
						ALU_Sel <= "111";
						CCR_Load <= '1';
						Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
------------------------------------------BRANCH-UNCONDITIONAL-------------------------------------------------------------	
					when S_BRA_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BRA_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BRA_6 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '1';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
------------------------------------------BRANCH-CONDITIONAL-(Z = 1)-------------------------------------------------------------	
					when S_BEQ_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BEQ_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BEQ_6 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '1';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BEQ_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';
------------------------------------------BRANCH-CONDITIONAL-(C = 1)-------------------------------------------------------------	
					when S_BCS_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BCS_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BCS_6 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '1';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BCS_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';
------------------------------------------BRANCH-CONDITIONAL-(V = 1)-------------------------------------------------------------	
					when S_BVS_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BVS_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BVS_6 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '1';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BVS_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';
------------------------------------------BRANCH-CONDITIONAL-(N = 1)-------------------------------------------------------------	
					when S_BMI_4 => 
						IR_Load <= '0';
						MAR_Load <= '1';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BMI_5 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BMI_6 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '1';
						PC_Inc <= '0';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';	
					when S_BMI_7 => 
						IR_Load <= '0';
						MAR_Load <= '0';
						PC_Load <= '0';
						PC_Inc <= '1';
						A_Load <= '0';
						B_Load <= '0';
						ALU_Sel <= "000";
						CCR_Load <= '0';
						Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
						Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
						write <= '0';
---------------------------------------------------------------------------------------------------------------------------	
---------------------------------------------------------------------------------------------------------------------------	
				end case;
		end process;


---------------------------------------------------------------------------------------------------------------------------	
end architecture;






