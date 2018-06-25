library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.MIPS_CONSTANTS.all;

entity MIPS is
	port(	clock_fpga: in	std_logic;
			clock:	in std_logic;
			new_pc:		in std_logic_vector(7 downto 0);
			load_pc:	in std_logic;
			debug:	in std_logic_vector(2 downto 0);
			hex0:	out std_logic_vector(7 downto 0);
			hex1:	out std_logic_vector(7 downto 0);
			hex2:	out std_logic_vector(7 downto 0);
			hex3:	out std_logic_vector(7 downto 0);
			hex4:	out std_logic_vector(7 downto 0);
			hex5:	out std_logic_vector(7 downto 0);
			hex6:	out std_logic_vector(7 downto 0);
			hex7:	out std_logic_vector(7 downto 0)
	);
end MIPS;

architecture behavioral of MIPS is
 -- Memória de instruções
component MIPS_INST_ROM is
	port(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

-- Memória de dados
component MIPS_DATA_RAM is
	port(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wraddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

-- Unidade Lógico-Aritmética (ULA)
component MIPS_ALU is
	port (
			opcode :				 	in std_logic_vector(3 downto 0);
			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
			output :					out std_logic_vector(WORD_SIZE-1 downto 0);
			zero, ovfl :			out std_logic			
	);
end component;

-- Banco de Registradores (BREG)
component MIPS_REGS is   
	port (   
		clk, wren, rst  : 	in std_logic;  
		radd1, radd2, wadd : in std_logic_vector(4 downto 0);   
		wdata    : 				in std_logic_vector(WORD_SIZE-1 downto 0); 
		r1, r2   : 				out std_logic_vector(WORD_SIZE-1 downto 0)
	); 
end component; 

-- MUX 2 to 1
component MIPS_MUX_21 is
generic (SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(SIZE-1 downto 0);
		signalB	: in std_logic_vector(SIZE-1 downto 0);
		sel		: in std_logic;
		output	: out std_logic_vector(SIZE-1 downto 0)
	);
end component;

-- MUX 4 to 1
component MIPS_MUX_41 is
	generic (SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(SIZE-1 downto 0);
		signalB	: in std_logic_vector(SIZE-1 downto 0);
		signalC	: in std_logic_vector(SIZE-1 downto 0);
		signalD	: in std_logic_vector(SIZE-1 downto 0);
		sel		: in std_logic_vector(1 downto 0);
		output	: out std_logic_vector(SIZE-1 downto 0)
	);
end component;

-- Extensor de sinal
component MIPS_SIGN_EXTEND is
	port(
		imm16	: in  std_logic_vector(15 downto 0);
		sig32 : out std_logic_vector(31 downto 0)
	);
end component;

-- Deslocador
component MIPS_SHIFTER is
	generic (K: natural := 2);
	port(
		imm26	: in  std_logic_vector(25 downto 0);
		sig28 : out std_logic_vector(27 downto 0)
	);
end component;

-- Somador
component MIPS_ADDER is
	port (
			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
			output :					out std_logic_vector(WORD_SIZE-1 downto 0)			
	);
end component;

-- Registrador
component MIPS_REGISTER is
	port(
		clock: in		std_logic;
		load:	in			std_logic_vector(31 downto 0);
		current: out	std_logic_vector(31 downto 0)
	);
end component;

-- Controle
component MIPS_CONTROL_UNIT is
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
end component;

-- Debug unit
component MIPS_DEBUG is
	port(
		signalA: 		in std_logic_vector(31 downto 0);
		signalB: 		in std_logic_vector(31 downto 0);
		signalC: 		in std_logic_vector(31 downto 0);
		signalD: 		in std_logic_vector(31 downto 0);
		signalE: 		in std_logic_vector(31 downto 0);
		signalF: 		in std_logic_vector(31 downto 0);
		signalG: 		in std_logic_vector(31 downto 0);
		signalH: 		in std_logic_vector(31 downto 0);
		sig_select:		in std_logic_vector(2 downto 0);
		hex0:				out std_logic_vector(7 downto 0);
		hex1:				out std_logic_vector(7 downto 0);
		hex2:				out std_logic_vector(7 downto 0);
		hex3:				out std_logic_vector(7 downto 0);
		hex4:				out std_logic_vector(7 downto 0);
		hex5:				out std_logic_vector(7 downto 0);
		hex6:				out std_logic_vector(7 downto 0);
		hex7:				out std_logic_vector(7 downto 0)
	);
end component;

-- Fetch signals
signal pc_src_select		: std_logic_vector(1 downto 0);

signal pc_next				: std_logic_vector(WORD_SIZE-1 downto 0);
signal pc_input			: std_logic_vector(WORD_SIZE-1 downto 0);
signal pc_current			: std_logic_vector(WORD_SIZE-1 downto 0);
signal pc_incremented	: std_logic_vector(WORD_SIZE-1 downto 0);

signal epc_current		: std_logic_vector(WORD_SIZE-1 downto 0);

signal instruction		: std_logic_vector(WORD_SIZE-1 downto 0);

-- Instruction decode/branching/jumping
signal sign_ext_imm		: std_logic_vector(WORD_SIZE-1 downto 0);
signal branch_addr		: std_logic_vector(WORD_SIZE-1 downto 0);
signal branch_src			: std_logic_vector(WORD_SIZE-1 downto 0);
signal jump_imm			: std_logic_vector(27 downto 0);
signal jump_addr			: std_logic_vector(WORD_SIZE-1 downto 0);

-- Registers signals
signal write_src			: std_logic_vector(4 downto 0);
signal write_data			: std_logic_vector(WORD_SIZE-1 downto 0);
signal reg_read1			: std_logic_vector(WORD_SIZE-1 downto 0);
signal reg_read2			: std_logic_vector(WORD_SIZE-1 downto 0);

-- Control Unit signals
signal ctl_alu_opcode	: std_logic_vector(3 downto 0);
signal ctl_pc_control	: std_logic_vector(1 downto 0);
signal ctl_reg_dst		: std_logic_vector(1 downto 0);
signal ctl_reg_wren		: std_logic;
signal ctl_alu_srcA		: std_logic;
signal ctl_alu_srcB		: std_logic_vector(1 downto 0);
signal ctl_mem_write		: std_logic;
signal ctl_mem_read_en	: std_logic;
signal ctl_mem_read_sel	: std_logic_vector(1 downto 0);
signal ctl_jump_reg		: std_logic;
signal ctl_jump			: std_logic;
signal ctl_beq				: std_logic;
signal ctl_bne				: std_logic;

-- ALU signals
signal alu_overflow		: std_logic;
signal alu_zero			: std_logic;
signal alu_src_A			: std_logic_vector(WORD_SIZE-1 downto 0);
signal alu_src_B			: std_logic_vector(WORD_SIZE-1 downto 0);
signal alu_output			: std_logic_vector(WORD_SIZE-1 downto 0);

signal data_output		: std_logic_vector(WORD_SIZE-1 downto 0);	

begin
	CONTROL:	MIPS_CONTROL_UNIT port map(opcode => instruction(31 downto 26), funct => instruction(5 downto 0), exc_ovfl => alu_overflow,
										pc_ctrl => ctl_pc_control, reg_dst => ctl_reg_dst, jump => ctl_jump, jump_reg => ctl_jump_reg, beq => ctl_beq,
										bne => ctl_bne, mem_read_en => ctl_mem_read_en, mem_read_sel => ctl_mem_read_sel, alu_opcode => ctl_alu_opcode,
										alu_srcA => ctl_alu_srcA, alu_srcB => ctl_alu_srcB, mem_write => ctl_mem_write, reg_write => ctl_reg_wren);
	
	PC_LOAD: MIPS_MUX_21 generic map(SIZE => 2)
								port map(signalA => ctl_pc_control, signalB => "01", sel => load_pc, output => pc_src_select);
								
	PC_SRC:	MIPS_MUX_41 generic map(SIZE => 32)
								port map(signalA => pc_next, signalB => "0000000000000000000000" & new_pc & "00", signalC => X"00004380", signalD => epc_current, 
								sel => pc_src_select, output => pc_input);
	
	PC_INCR: MIPS_ADDER port map(oprA => pc_current, oprB => X"00000004", output => pc_incremented);
	BRANCH: MIPS_ADDER port map(oprA => pc_incremented, oprB => std_logic_vector(shift_left(unsigned(sign_ext_imm), 2)), output => branch_addr);
	JUMP_SHT: MIPS_SHIFTER	generic map (K => 2)
									port map(imm26 => instruction(25 downto 0), sig28 => jump_imm);
									
	JUMP_SRC: MIPS_MUX_21	generic map(SIZE => 32)
									port map(signalA => pc_incremented(31 downto 28)& jump_imm, signalB => reg_read1, sel => ctl_jump_reg, output => jump_addr);
	
	BRANCH_SEL: MIPS_MUX_21 generic map(SIZE => 32)
									port map(signalA => pc_incremented, signalB => branch_addr,
									sel =>(((not(ctl_beq)) and ctl_bne and (not(alu_zero))) or (ctl_beq and (not(ctl_bne))and alu_zero)) , output => branch_src);
									
	JUMP_EN: MIPS_MUX_21		generic map(SIZE => 32)
									port map(signalA => branch_src, signalB => jump_addr, sel => ctl_jump, output => pc_next);
	
	PC: 	MIPS_REGISTER port map(clock => clock, load => pc_input, current => pc_current);
	EPC:	MIPS_REGISTER port map(clock => alu_overflow, load => pc_incremented, current => epc_current); 
	
	INSTRUCTION_MEM: MIPS_INST_ROM port map(clock => clock_fpga, address => pc_current(9 downto 2), q => instruction); 
	
	WRITE_REG_SRC: MIPS_MUX_41 generic map(SIZE => 5)
										port map(signalA => instruction(20 downto 16), signalB => instruction(15 downto 11), signalC => "11111", signalD => "00000",
										sel => ctl_reg_dst, output => write_src);
	
	REGS:	MIPS_REGS port map(clk => clock, wren => ctl_reg_wren, rst => '0', radd1 => instruction(25 downto 21), radd2 => instruction(20 downto 16), 
						 wadd => write_src, wdata => write_data, r1 => reg_read1, r2 => reg_read2);
	
	SIGN_EXTEND: MIPS_SIGN_EXTEND port map(imm16 => instruction(15 downto 0), sig32 => sign_ext_imm);
	
	ALU_PORT_A: MIPS_MUX_21 generic map(SIZE => 32)
									port map(signalA => reg_read1, signalB => X"0000"&instruction(15 downto 0), sel => ctl_alu_srcA, output => alu_src_A);
				
	ALU_PORT_B: MIPS_MUX_41 generic map(SIZE => 32)
									port map(signalA => reg_read2, signalB => sign_ext_imm, signalC => X"0000"&instruction(15 downto 0), signalD => X"00000000",
									sel => ctl_alu_srcB, output => alu_src_B);
									
	ALU: MIPS_ALU port map(opcode => ctl_alu_opcode, oprA => alu_src_A, oprB => alu_src_B, zero => alu_zero, ovfl => alu_overflow, output => alu_output);
	
	DATA_MEM: MIPS_DATA_RAM port map(clock => clock_fpga, data => reg_read2, rdaddress => alu_output(7 downto 0), wraddress => alu_output(7 downto 0),
									rden => ctl_mem_read_en, wren => ctl_mem_write, q => data_output);	
	
	WB_SRC: MIPS_MUX_41 generic map(SIZE => 32)
							  port map(signalA => alu_output, signalB => data_output, signalC => pc_incremented, signalD => X"00000000", sel => ctl_mem_read_sel, output => write_data);
							  
	DEBUG_UNIT: MIPS_DEBUG port map(hex0 => hex0, hex1 => hex1, hex2 => hex2, hex3 => hex3, hex4 => hex4, hex5 => hex5, hex6 => hex6, hex7 => hex7,
										signalA => pc_current, signalB => instruction, signalC => reg_read1, signalD => reg_read2, 
										signalE => alu_output, signalF => write_data, signalG => epc_current, signalH => pc_next,
										sig_select => debug);

end behavioral;