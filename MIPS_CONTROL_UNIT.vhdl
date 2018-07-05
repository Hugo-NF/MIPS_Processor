library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_CONTROL_UNIT is
	port(
		opcode: in			std_logic_vector(5 downto 0);
		funct: in 			std_logic_vector(5 downto 0);
		
		exc_ovfl: in		std_logic;
		pc_ctrl:	out		std_logic_vector(1 downto 0);
		
		reg_dst: out		std_logic_vector(1 downto 0);
		jump: out			std_logic;
		jump_reg: out		std_logic;
		
		beq: out				std_logic;
		bne: out				std_logic;
		mem_read_en: out	std_logic;
		mem_read_sel: out	std_logic_vector(1 downto 0);
		alu_opcode: out 	std_logic_vector(3 downto 0);
		alu_srcA: out		std_logic;
		alu_srcB: out		std_logic_vector(1 downto 0);
		mem_write: out		std_logic;
		reg_write: out		std_logic
	);
end MIPS_CONTROL_UNIT;

architecture behavioral of MIPS_CONTROL_UNIT is
begin
	
	control_process: process (opcode, exc_ovfl)
		variable cur_pc_ctrl:			std_logic_vector(1 downto 0);
		
		variable cur_reg_dst: 			std_logic_vector(1 downto 0);
		variable cur_jump: 				std_logic;
		variable cur_jump_reg:			std_logic;
		variable cur_beq:		 			std_logic;
		variable cur_bne:					std_logic;
		variable cur_mem_read_en: 		std_logic;
		variable cur_mem_read_sel: 	std_logic_vector(1 downto 0);
		variable cur_alu_opcode: 		std_logic_vector(3 downto 0);
		variable cur_alu_srcA: 			std_logic;
		variable cur_alu_srcB: 			std_logic_vector(1 downto 0);
		variable cur_mem_write: 		std_logic;
		variable cur_reg_write: 		std_logic;
		
	begin
	
		cur_reg_dst := SEL_RT_REG;
		cur_jump := DISABLE;
		cur_jump_reg := DISABLE;
		cur_beq := DISABLE;
		cur_bne := DISABLE;
		
		cur_mem_read_en := DISABLE;
		cur_mem_read_sel := SEL_FROM_ALU;
		
		cur_alu_srcA := SEL_BREG_ALU_A;
		cur_alu_srcB := SEL_BREG_ALU_B;
		
		cur_mem_write := DISABLE;
		cur_reg_write := DISABLE;
		cur_pc_ctrl := SEL_PC_FETCH;
		
		case opcode is
			when OPCODE_EXT =>
				cur_reg_dst := SEL_RD_REG;
				cur_reg_write := ENABLE;
				
				case funct is
					when FUNCT_ADD =>
						cur_alu_opcode := ULA_ADD;
						if(exc_ovfl = '1') then
							cur_pc_ctrl := SEL_PC_EXC;
						end if;
						
					when FUNCT_ADDU =>
						cur_alu_opcode := ULA_ADDU;
						
					when FUNCT_AND =>
						cur_alu_opcode := ULA_AND;
						
					when FUNCT_NOR =>
						cur_alu_opcode := ULA_NOR;
						
					when FUNCT_OR =>
						cur_alu_opcode := ULA_OR;
						
					when FUNCT_SLT =>
						cur_alu_opcode := ULA_SLT;
						
					when FUNCT_SLTU =>
						cur_alu_opcode := ULA_SLTU;
						
					when FUNCT_XOR =>
						cur_alu_opcode := ULA_XOR;
						
					when FUNCT_SLL =>
						cur_alu_srcA := SEL_ZERO_IMM_ALU_A;
						cur_alu_opcode := ULA_SLL;
						
					when FUNCT_SRL =>
						cur_alu_srcA := SEL_ZERO_IMM_ALU_A;
						cur_alu_opcode := ULA_SRL;
						
					when FUNCT_SRA =>
						cur_alu_srcA := SEL_ZERO_IMM_ALU_A;
						cur_alu_opcode := ULA_SRA;
						
					when FUNCT_SUB =>
						cur_alu_opcode := ULA_SUB;
						
						if(exc_ovfl = '1') then
							cur_pc_ctrl := SEL_PC_EXC;
						end if;
						
					when FUNCT_SUBU =>
						cur_alu_opcode := ULA_SUBU;
						
					when FUNCT_JR =>
						cur_jump := ENABLE;
						cur_jump_reg := ENABLE;
					when others =>
				end case;
				
			when OPCODE_ADDI =>
				cur_alu_opcode := ULA_ADD;
				cur_reg_write := ENABLE;
				cur_alu_srcB := SEL_SIG_IMM_ALU_B;
				if (exc_ovfl = '1') then
					cur_pc_ctrl := SEL_PC_EXC;
				end if;
				
			when OPCODE_ADDIU =>
				cur_alu_opcode := ULA_ADDU;
				cur_reg_write := ENABLE;
				cur_alu_srcB := SEL_SIG_IMM_ALU_B;
				
			when OPCODE_ANDI =>
				cur_alu_opcode := ULA_AND;
				cur_reg_write := ENABLE;
				cur_alu_srcB := SEL_ZERO_IMM_ALU_B;
				
			when OPCODE_SLTI =>
				cur_alu_opcode := ULA_SLT;
				cur_reg_write := ENABLE;
				cur_alu_srcB := SEL_SIG_IMM_ALU_B;
				
			when OPCODE_ORI =>
				cur_alu_opcode := ULA_OR;
				cur_reg_write := ENABLE;
				cur_alu_srcB := SEL_ZERO_IMM_ALU_B;
			
			when OPCODE_XORI =>
				cur_alu_opcode := ULA_XOR;
				cur_reg_write := ENABLE;
				cur_alu_srcB := SEL_ZERO_IMM_ALU_B;
			
			when OPCODE_BEQ =>
				cur_beq := ENABLE;
				cur_alu_opcode := ULA_SUBU;
				
			when OPCODE_BNE =>
				cur_bne := ENABLE;
				cur_alu_opcode := ULA_SUBU;
				
			when OPCODE_J =>
				cur_jump := ENABLE;
				
			when OPCODE_SW =>
				cur_alu_opcode := ULA_ADD;
				cur_alu_srcB := SEL_SIG_IMM_ALU_B;
				cur_mem_write := ENABLE;
				
				
			when OPCODE_LW =>
				cur_alu_opcode := ULA_ADD;
				cur_reg_write := ENABLE;
				cur_alu_srcB := SEL_SIG_IMM_ALU_B;
				cur_mem_read_en := ENABLE;
				cur_mem_read_sel := SEL_FROM_MEM;
			
			when OPCODE_LUI =>
				cur_alu_opcode := ULA_LUI;
				cur_alu_srcB := SEL_ZERO_IMM_ALU_B;
				cur_reg_write := ENABLE;
				
			when OPCODE_ERET =>
				cur_pc_ctrl := SEL_PC_ERET;
				
			when OPCODE_JAL =>
				cur_jump := ENABLE;
				cur_reg_dst := SEL_RA_REG;
				cur_reg_write := ENABLE;
				cur_mem_read_sel := SEL_FROM_PC_FETCH;
			when others =>
		end case;
		
		pc_ctrl 		<= cur_pc_ctrl;
		reg_dst		<= cur_reg_dst;
		jump			<= cur_jump; 
		jump_reg		<= cur_jump_reg;	
		beq			<= cur_beq;
		bne			<= cur_bne;
		mem_read_en	<= cur_mem_read_en;	
		mem_read_sel<= cur_mem_read_sel;
		alu_opcode	<= cur_alu_opcode;	
		alu_srcA		<= cur_alu_srcA;			
		alu_srcB		<= cur_alu_srcB;			
		mem_write	<= cur_mem_write;	
		reg_write	<= cur_reg_write;	
		
	end process control_process;
end behavioral;