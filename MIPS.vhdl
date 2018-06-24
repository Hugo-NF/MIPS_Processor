library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS is
	port(	clock_fpga: in	std_logic;
			clock:	in std_logic;
			pc_0:		in std_logic;
			pc_1:		in std_logic;
			pc_2:		in std_logic;
			pc_3:		in std_logic;
			pc_4:		in std_logic;
			pc_5:		in std_logic;
			pc_6:		in std_logic;
			pc_7:		in std_logic;
			hex_0:	out std_logic_vector(7 downto 0);
			hex_1:	out std_logic_vector(7 downto 0);
			hex_2:	out std_logic_vector(7 downto 0);
			hex_3:	out std_logic_vector(7 downto 0);
			hex_4:	out std_logic_vector(7 downto 0);
			hex_5:	out std_logic_vector(7 downto 0);
			hex_6:	out std_logic_vector(7 downto 0);
			hex_7:	out std_logic_vector(7 downto 0)
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
	generic (WORD_SIZE : natural := 32);
	port (
			opcode :				 	in std_logic_vector(3 downto 0);
			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
			output :					out std_logic_vector(WORD_SIZE-1 downto 0);
			zero, ovfl :			out std_logic			
	);
end component;

-- Banco de Registradores (BREG)
component MIPS_REGS is 
	generic (WORD_SIZE : natural := 32);  
	port (   
		clk, wren, rst  : 	in std_logic;  
		radd1, radd2, wadd : in std_logic_vector(4 downto 0);   
		wdata    : 				in std_logic_vector(WORD_SIZE-1 downto 0); 
		r1, r2   : 				out std_logic_vector(WORD_SIZE-1 downto 0)
	); 
end component; 

-- MUX 2 to 1
component MIPS_MUX_21 is
	generic (WORD_SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(WORD_SIZE-1 downto 0);
		signalB	: in std_logic_vector(WORD_SIZE-1 downto 0);
		sel		: in std_logic;
		output	: out std_logic_vector(WORD_SIZE-1 downto 0)
	);
end component;

-- MUX 4 to 1
component MIPS_MUX_41 is
	generic (WORD_SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(WORD_SIZE-1 downto 0);
		signalB	: in std_logic_vector(WORD_SIZE-1 downto 0);
		signalC	: in std_logic_vector(WORD_SIZE-1 downto 0);
		signalD	: in std_logic_vector(WORD_SIZE-1 downto 0);
		sel		: in std_logic_vector(1 downto 0);
		output	: out std_logic_vector(WORD_SIZE-1 downto 0)
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
	generic (WORD_SIZE : natural := 32);
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
		
		reg_dst: out		std_logic;
		jump: out			std_logic;
		branch: out			std_logic;
		mem_read: out		std_logic;
		alu_opcode: out 	std_logic;
		alu_srcA: out		std_logic;
		alu_srcB: out		std_logic_vector(1 downto 0);
		mem_write: out		std_logic;
		reg_write: out		std_logic
	);
end component;
begin
end behavioral;