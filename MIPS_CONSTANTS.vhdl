library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package MIPS_CONSTANTS is
	constant WORD_SIZE		: natural	:= 32;
	constant BIT_SIGN		: natural	:= WORD_SIZE-1;

	constant ULA_AND		: std_logic_vector(3 downto 0) := "0000";
	constant ULA_OR			: std_logic_vector(3 downto 0) := "0001";
	constant ULA_ADD		: std_logic_vector(3 downto 0) := "0010";
	constant ULA_ADDU		: std_logic_vector(3 downto 0) := "0011";
	constant ULA_SUB		: std_logic_vector(3 downto 0) := "0100";
	constant ULA_SUBU		: std_logic_vector(3 downto 0) := "0101";
	constant ULA_SLT		: std_logic_vector(3 downto 0) := "0110";
	constant ULA_SLTU		: std_logic_vector(3 downto 0) := "0111";
	constant ULA_NOR		: std_logic_vector(3 downto 0) := "1000";
	constant ULA_XOR		: std_logic_vector(3 downto 0) := "1001";
	constant ULA_SLL		: std_logic_vector(3 downto 0) := "1010";
	constant ULA_SRL		: std_logic_vector(3 downto 0) := "1011";
	constant ULA_SRA		: std_logic_vector(3 downto 0) := "1100";
	constant ULA_RTR		: std_logic_vector(3 downto 0) := "1101";
	constant ULA_RTL		: std_logic_vector(3 downto 0) := "1110";
	constant ULA_LUI		: std_logic_vector(3 downto 0) := "1111";
	
	
	constant FUNCT_ADD	: std_logic_vector(5 downto 0) := "100000";
	constant FUNCT_ADDU	: std_logic_vector(5 downto 0) := "100001";
	constant FUNCT_AND	: std_logic_vector(5 downto 0) := "100100";
	constant FUNCT_JR		: std_logic_vector(5 downto 0) := "001000";
	constant FUNCT_NOR	: std_logic_vector(5 downto 0) := "100111";
	constant FUNCT_OR		: std_logic_vector(5 downto 0) := "100101";
	constant FUNCT_XOR	: std_logic_vector(5 downto 0) := "100110";
	constant FUNCT_SLT	: std_logic_vector(5 downto 0) := "101010";
	constant FUNCT_SLTU	: std_logic_vector(5 downto 0) := "101011";
	constant FUNCT_SLL	: std_logic_vector(5 downto 0) := "000000";
	constant FUNCT_SRL	: std_logic_vector(5 downto 0) := "000010";
	constant FUNCT_SRA	: std_logic_vector(5 downto 0) := "000011";
	constant FUNCT_SUB	: std_logic_vector(5 downto 0) := "100010";
	constant FUNCT_SUBU	: std_logic_vector(5 downto 0) := "100011";
	
	
	constant OPCODE_EXT		: std_logic_vector(5 downto 0) := "000000";
	constant OPCODE_ADDI		: std_logic_vector(5 downto 0) := "001000";
	constant OPCODE_ADDIU	: std_logic_vector(5 downto 0) := "001001";
	constant OPCODE_ANDI		: std_logic_vector(5 downto 0) := "001100";
	constant OPCODE_ORI		: std_logic_vector(5 downto 0) := "001101";
	constant OPCODE_XORI		: std_logic_vector(5 downto 0) := "001110";
	constant OPCODE_SLTI		: std_logic_vector(5 downto 0) := "001010";
	constant OPCODE_BEQ		: std_logic_vector(5 downto 0) := "000100";
	constant OPCODE_J			: std_logic_vector(5 downto 0) := "000010";
	constant OPCODE_SW		: std_logic_vector(5 downto 0) := "101011";
	constant OPCODE_LW		: std_logic_vector(5 downto 0) := "100011";
	constant OPCODE_LUI		: std_logic_vector(5 downto 0) := "001111";
	constant OPCODE_BNE		: std_logic_vector(5 downto 0) := "000101";
	constant OPCODE_JAL		: std_logic_vector(5 downto 0) := "000011";
	constant OPCODE_ERET		: std_logic_vector(5 downto 0) := "010000";
	
	
	constant ENABLE				: std_logic := '1';
	constant DISABLE				: std_logic := '0';
	
	constant SEL_RT_REG		: std_logic_vector(1 downto 0) := "00";
	constant SEL_RD_REG		: std_logic_vector(1 downto 0) := "01";
	constant SEL_RA_REG		: std_logic_vector(1 downto 0) := "10";
	
	constant SEL_FROM_ALU			: std_logic_vector(1 downto 0) := "00";
	constant SEL_FROM_MEM			: std_logic_vector(1 downto 0) := "01";
	constant SEL_FROM_PC_FETCH		: std_logic_vector(1 downto 0) := "10";
	
	constant SEL_BREG_ALU_B			: std_logic_vector(1 downto 0) := "00";
	constant SEL_SIG_IMM_ALU_B		: std_logic_vector(1 downto 0) := "01";
	constant SEL_ZERO_IMM_ALU_B	: std_logic_vector(1 downto 0) := "10";
	
	constant SEL_BREG_ALU_A			: std_logic_vector(1 downto 0) := "00";
	constant SEL_SHAMT_ALU_A		: std_logic_vector(1 downto 0) := "01";
	constant SEL_BREG2_ALU_A		: std_logic_vector(1 downto 0) := "10";
	
	constant SEL_PC_FETCH	: std_logic_vector(1 downto 0) := "00";
	constant SEL_PC_LOAD		: std_logic_vector(1 downto 0) := "01";
	constant SEL_PC_EXC		: std_logic_vector(1 downto 0) := "10";
	constant SEL_PC_ERET		: std_logic_vector(1 downto 0) := "11";
	
	

end MIPS_CONSTANTS;