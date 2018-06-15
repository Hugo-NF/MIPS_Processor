library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_MINOR_COMPONENTS_TB is
end MIPS_MINOR_COMPONENTS_TB;

architecture MINOR_COMPONENTS_TB of MIPS_MINOR_COMPONENTS_TB is


--component MIPS_SHIFTER is
--	generic (K: natural := 2);
--	port(
--		imm26	: in  std_logic_vector(25 downto 0);
--		sig28 : out std_logic_vector(27 downto 0)
--	);
--end component;


--component MIPS_ADDER is
--	generic (WORD_SIZE : natural := 32);
--	port (
--			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
--			output :					out std_logic_vector(WORD_SIZE-1 downto 0)			
--	);
--end component;

--component MIPS_SIGN_EXTEND is
--	port(
--		imm16	: in  std_logic_vector(15 downto 0);
--		sig32 : out std_logic_vector(31 downto 0)
--	);
--end component;

component MIPS_MUX_21 is
	generic (WORD_SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(WORD_SIZE-1 downto 0);
		signalB	: in std_logic_vector(WORD_SIZE-1 downto 0);
		sel		: in std_logic;
		output	: out std_logic_vector(WORD_SIZE-1 downto 0)
	);
end component;

--signal imm26:			std_logic_vector(25 downto 0);
--signal sig28:			std_logic_vector(27 downto 0);

--signal oprA, oprB:	std_logic_vector(31 downto 0);
--signal output:			std_logic_vector(31 downto 0);

--signal imm16:	std_logic_vector(15 downto 0);
--signal sig32: 	std_logic_vector(31 downto 0);

signal signalA: 	std_logic_vector(31 downto 0);
signal signalB:	std_logic_vector(31 downto 0);
signal sel:			std_logic;
signal output:		std_logic_vector(31 downto 0);

begin
	--DUT: MIPS_SHIFTER port map(imm26 => imm26, sig28 => sig28);
	--DUT: MIPS_ADDER port map(oprA => oprA, oprB => oprB, output => output);
	--DUT: MIPS_SIGN_EXTEND port map(imm16 => imm16, sig32 => sig32);
	DUT: MIPS_MUX_21 port map(signalA => signalA, signalB => signalB, sel => sel, output => output);
	test: process
	begin
	
	report "Initializing tests..." severity NOTE;
		
	report "Running Test 1" severity NOTE;
	
	--imm26 <= "00000000000000000000000011";
	
	--oprA <= X"00000000"; oprB <= X"00000004";
	
	--imm16 <= X"FFFF";
	
	signalA <= X"00000022"; signalB <= X"00002244";
	sel <= '0';
	wait for 2 ps;
	
	assert (output = X"00000022") report "Test 1 failed. COMPONENT WRONG" severity ERROR;
	
	sel <= '1';
	wait for 2 ps;
	
	assert (output = X"00002244") report "Test 1 failed. COMPONENT WRONG" severity ERROR;
	
	--assert (sig28 = "0000000000000000000000001100") report "Test 1 failed. COMPONENT WRONG." severity ERROR;
	--assert (output = X"00000004") report "Test 1 failed. COMPONENT WRONG" severity ERROR;
	--assert (sig32 = X"FFFFFFFF") report "Test 1 failed. COMPONENT WRONG" severity ERROR;
	
	wait;
	end process test;
end MINOR_COMPONENTS_TB;