library ieee;
use ieee.std_logic_1164.all;

entity MIPS_DATA_MEM_TB is
end MIPS_DATA_MEM_TB;


architecture DATA_MEM_TB of MIPS_DATA_MEM_TB is

component MIPS_INST_MEM is
	port
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC;
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

constant WORD_SIZE: integer := 32;
signal address:		std_logic_vector(7 downto 0);
signal clock:			std_logic := '1';
signal data:			std_logic_vector(WORD_SIZE-1 downto 0);
signal wren:			std_logic := '0';
signal q:  				std_logic_vector (31 DOWNTO 0);
	
begin
	
	DUT: MIPS_INST_MEM port map(address => address, clock => clock, data => data, wren => wren, q => q);
	
	clock_proc: process
	begin
		for i in 0 to 256 loop
			clock <= '0';
			wait for 10 ps;
			clock <= '1';
			wait for 10 ps;
		end loop;
		wait;
	end process clock_proc;
	
	
	mem_test: process
	begin
		report "Initializing tests..." severity NOTE;
		
		report "Running Test 1" severity NOTE;
		address <= X"00";
		wait for 20 ps;
		assert (q = X"00001ED6") report "Test 1 failed. 'Q' WRONG." severity ERROR;
		
	wait; -- end process	
	end process mem_test;
end DATA_MEM_TB;