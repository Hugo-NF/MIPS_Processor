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
		opcode <= "0010"; -- add com zero
		wait for 100 ps;
		assert (output = X"00000000") report "Test 1 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '1') report "Test 1 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 1 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 2" severity NOTE;
		oprA <= X"7FFFFFFF"; oprB <= X"00000001";
		opcode <= "0010"; -- add com overflow
		wait for 100 ps;
		assert (output = X"80000000") report "Test 2 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 2 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '1')	report "Test 2 failed. OVERFLOW WRONG." severity ERROR;
	
		report "Running Test 3" severity NOTE;
		oprA <= X"80000000"; oprB <= X"00000001";
		opcode <= "0100";	-- sub com overflow
		wait for 100 ps;
		assert (output = X"7FFFFFFF") report "Test 3 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 3 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '1')	report "Test 3 failed. OVERFLOW WRONG." severity ERROR;
	
		report "Running Test 4" severity NOTE;
		oprA <= X"000000FF"; oprB <= X"00000001";
		opcode <= "0010";	-- add de positivos
		wait for 100 ps;
		assert (output = X"00000100") report "Test 4 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 4 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 4 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 5" severity NOTE;
		oprA <= X"00AC852F"; oprB <= X"00000CDA";
		opcode <= "0100";	-- sub de positivos
		wait for 100 ps;
		assert (output = X"00AC7855") report "Test 5 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 5 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 5 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 6" severity NOTE;
		oprA <= X"FFFFFFF7"; oprB <= X"00000008";
		opcode <= "0011";	-- add sem sinal
		wait for 100 ps;
		assert (output = X"FFFFFFFF") report "Test 6 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 6 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 6 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 7" severity NOTE;
		oprA <= X"FFFFFFF7"; oprB <= X"00000009";
		opcode <= "0011";	-- add sem sinal com overflow
		wait for 100 ps;
		assert (output = X"00000000") report "Test 7 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '1') report "Test 7 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 7 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 8" severity NOTE;
		oprA <= X"00000001"; oprB <= X"00000001";
		opcode <= "1110";	-- rotate left
		wait for 100 ps;
		assert (output = X"00000002") report "Test 8 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 8 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 8 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 9" severity NOTE;
		oprA <= X"00000004"; oprB <= X"00000001";
		opcode <= "1010"; -- shift left
		wait for 100 ps;
		assert (output = X"00000010") report "Test 9 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 9 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 9 failed. OVERFLOW WRONG." severity ERROR;
	
		report "Running Test 10" severity NOTE;
		oprA <= X"FFFFFFFF"; oprB <= X"00000000";
		opcode <= "0000"; -- and logico
		wait for 100 ps;
		assert (output = X"00000000") report "Test 10 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '1') report "Test 10 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 10 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 11" severity NOTE;
		oprA <= X"0000FFFF"; oprB <= X"FFFF0000";
		opcode <= "0001"; -- or logico
		wait for 100 ps;
		assert (output = X"FFFFFFFF") report "Test 11 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 11 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 11 failed. OVERFLOW WRONG." severity ERROR;	

		report "Running Test 12" severity NOTE;
		oprA <= X"FFFFFFFF"; oprB <= X"FFFFFFFF";
		opcode <= "0010"; -- add com negativo
		wait for 100 ps;
		assert (output = X"FFFFFFFE") report "Test 12 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 12 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 12 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 13" severity NOTE;
		oprA <= X"0000000A"; oprB <= X"0000000B";
		opcode <= "0110"; -- set on less than
		wait for 100 ps;
		assert (output = X"00000001") report "Test 13 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 13 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 13 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 14" severity NOTE;
		oprA <= X"0000000A"; oprB <= X"0000000B";
		opcode <= "0111"; -- set on less than unsigned
		wait for 100 ps;
		assert (output = X"00000001") report "Test 14 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 14 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 14 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 15" severity NOTE;
		oprA <= X"0000FFFF"; oprB <= X"FFFF0000";
		opcode <= "1000"; -- nor
		wait for 100 ps;
		assert (output = X"00000000") report "Test 15 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '1') report "Test 15 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 15 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 16" severity NOTE;
		oprA <= X"FFFFFFFE"; oprB <= X"ABCE7423";
		opcode <= "1001"; -- xor
		wait for 100 ps;
		assert (output = X"54318BDD") report "Test 16 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 16 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 16 failed. OVERFLOW WRONG." severity ERROR;	
		
		report "Running Test 17" severity NOTE;
		oprA <= X"00000007"; oprB <= X"00000001";
		opcode <= "1010"; -- sll de 7 bits
		wait for 100 ps;
		assert (output = X"00000080") report "Test 17 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 17 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 17 failed. OVERFLOW WRONG." severity ERROR;	
		
		report "Running Test 18" severity NOTE;
		oprA <= X"00000001"; oprB <= X"80000000";
		opcode <= "1011"; -- srl de 1 bit
		wait for 100 ps;
		assert (output = X"40000000") report "Test 18 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 18 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 18 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 19" severity NOTE;
		oprA <= X"00000001"; oprB <= X"80000000";
		opcode <= "1100"; -- sra de 1 bit
		wait for 100 ps;
		assert (output = X"C0000000") report "Test 19 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 19 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 19 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 20" severity NOTE;
		oprA <= X"00000001"; oprB <= X"80000002";
		opcode <= "1101"; -- rtr de 1 bit 
		wait for 100 ps;
		assert (output = X"40000001") report "Test 20 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 20 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 20 failed. OVERFLOW WRONG." severity ERROR;
		
		report "Running Test 21" severity NOTE;
		oprA <= X"00000001"; oprB <= X"80000002";
		opcode <= "1110"; -- rtl de 1 bit
		wait for 100 ps;
		assert (output = X"00000005") report "Test 21 failed. OUTPUT WRONG." severity ERROR;
		assert (zero = '0') report "Test 21 failed. ZERO WRONG." severity ERROR;
		assert (ovfl = '0')	report "Test 21 failed. OVERFLOW WRONG." severity ERROR;
	end process test;
end ALU_TB;
