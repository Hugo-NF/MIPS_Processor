library ieee;
use ieee.std_logic_1164.all;

entity MIPS_INST_ROM_TB is
end MIPS_INST_ROM_TB;


architecture INST_ROM_TB of MIPS_INST_ROM_TB is

component MIPS_INST_ROM IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

constant WORD_SIZE: integer := 32;
signal address:		std_logic_vector(7 downto 0);
signal clock:			std_logic := '1';
signal q:  				std_logic_vector (31 DOWNTO 0);
	
begin
	
	DUT: MIPS_INST_ROM port map(address => address, clock => clock, q => q);
	
	clock_proc: process
	begin
		for i in 0 to 255 loop
			clock <= '0';
			wait for 1 ps;
			clock <= '1';
			wait for 1 ps;
		end loop;
		wait;
	end process clock_proc;
	
	
	mem_test: process
	begin
		report "Initializing tests..." severity NOTE;
		
		report "Running Test 1" severity NOTE;
		address <= X"00";
		wait for 2 ps;
		assert (q = X"20082000") report "Test 1 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 2" severity NOTE;
		address <= X"01";
		wait for 2 ps;
		assert (q = X"8d090000") report "Test 2 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 3" severity NOTE;
		address <= X"02";
		wait for 2 ps;
		assert (q = X"8d0a0004") report "Test 3 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 4" severity NOTE;
		address <= X"03";
		wait for 2 ps;
		assert (q = X"8d0b0008") report "Test 4 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 5" severity NOTE;
		address <= X"04";
		wait for 2 ps;
		assert (q = X"8d0c000c") report "Test 5 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 6" severity NOTE;
		address <= X"05";
		wait for 2 ps;
		assert (q = X"8d0d0010") report "Test 6 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 7" severity NOTE;
		address <= X"06";
		wait for 2 ps;
		assert (q = X"01498020") report "Test 7 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 8" severity NOTE;
		address <= X"07";
		wait for 2 ps;
		assert (q = X"01498822") report "Test 8 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 9" severity NOTE;
		address <= X"08";
		wait for 2 ps;
		assert (q = X"018d9024") report "Test 9 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 10" severity NOTE;
		address <= X"09";
		wait for 2 ps;
		assert (q = X"012b982a") report "Test 10 failed. 'Q' WRONG." severity ERROR;
		
	wait; -- end process	
	end process mem_test;
end INST_ROM_TB;
