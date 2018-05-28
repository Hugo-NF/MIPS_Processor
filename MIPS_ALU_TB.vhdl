library ieee;
use ieee.std_logic_1164.all;

entity MIPS_ALU_TB is
end MIPS_ALU_TB;


architecture ALU_TB of MIPS_ALU_TB is

component MIPS_ALU is
generic (WORD_SIZE : natural := 32);
	port (
			opcode :				 	in std_logic_vector(3 downto 0);
			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
			output :					out std_logic_vector(WORD_SIZE-1 downto 0);
			zero, ovfl :			out std_logic			
	);
end component;

constant WORD_SIZE: integer := 32;
signal opcode:		 std_logic_vector(3 downto 0);
signal oprA, oprB: std_logic_vector(WORD_SIZE-1 downto 0);
signal output:		 std_logic_vector(WORD_SIZE-1 downto 0);
signal zero, ovfl: std_logic;
	
begin
	
	DUT: MIPS_ALU port map(opcode => opcode, oprA => oprA, oprB => oprB, output => output, zero => zero, ovfl => ovfl);
	
	test: process
	begin
		report "Initializing tests..." severity NOTE;
		
		report "Running Test 1" severity NOTE;
		oprA <= X"00000001"; oprB <= X"FFFFFFFF";
		opcode <= "0010";
		wait for 100 ps;
		assert (output = X"00000000") report "Test 1 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '1') report "Test 1 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 1 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 2" severity NOTE;
		oprA <= X"7FFFFFFF"; oprB <= X"00000001";
		opcode <= "0010";
		wait for 100 ps;
		assert (output = X"80000000") report "Test 2 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 2 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '1')	report "Test 2 failed. OVERFLOW WRONG." severity ERROR;
	
		report "Running Test 3" severity NOTE;
		oprA <= X"80000000"; oprB <= X"00000001";
		opcode <= "0100";
		wait for 100 ps;
		assert (output = X"7FFFFFFF") report "Test 3 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 3 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '1')	report "Test 3 failed. OVERFLOW WRONG." severity ERROR;
	
		report "Running Test 4" severity NOTE;
		oprA <= X"000000FF"; oprB <= X"00000001";
		opcode <= "0010";
		wait for 100 ps;
		assert (output = X"00000100") report "Test 4 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 4 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 4 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 5" severity NOTE;
		oprA <= X"00AC852F"; oprB <= X"00000CDA";
		opcode <= "0100";
		wait for 100 ps;
		assert (output = X"00AC7855") report "Test 5 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 5 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 5 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 6" severity NOTE;
		oprA <= X"FFFFFFF7"; oprB <= X"00000008";
		opcode <= "0011";
		wait for 100 ps;
		assert (output = X"FFFFFFFF") report "Test 6 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 6 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 6 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 7" severity NOTE;
		oprA <= X"FFFFFFF7"; oprB <= X"00000009";
		opcode <= "0011";
		wait for 100 ps;
		assert (output = X"00000000") report "Test 7 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '1') report "Test 7 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 7 failed. OVERFLOW WRONG." severity ERROR;
		
	end process test;
end ALU_TB;
