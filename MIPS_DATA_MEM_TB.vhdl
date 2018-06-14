library ieee;
use ieee.std_logic_1164.all;

entity MIPS_DATA_MEM_TB is
end MIPS_DATA_MEM_TB;


architecture DATA_MEM_TB of MIPS_DATA_MEM_TB is

component MIPS_DATA_RAM IS
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wraddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;

constant WORD_SIZE: integer := 32;
signal clock:			std_logic := '1';
signal data:			std_logic_vector(WORD_SIZE-1 downto 0);
signal rdaddress: 	std_logic_vector (7 DOWNTO 0);
signal rden:			std_logic;
signal wraddress:		std_logic_vector(7 downto 0);
signal wren:			std_logic := '0';
signal q:  				std_logic_vector (31 DOWNTO 0);
	
begin
	
	DUT: MIPS_DATA_RAM port map(clock => clock, data => data, rdaddress => rdaddress, rden => rden, wraddress => wraddress, wren => wren, q => q);
	
	clock_proc: process
	begin
		for i in 0 to 256 loop
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
		rden <= '1';
		rdaddress <= X"00";
		wait for 2 ps;
		assert (q = X"AB13F521") report "Test 1 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 2" severity NOTE;
		rdaddress <= X"01";
		wait for 2 ps;
		assert (q = X"00000033") report "Test 2 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 3" severity NOTE;
		rdaddress <= X"02";
		wait for 2 ps;
		assert (q = X"FFFFFFFF") report "Test 3 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 4" severity NOTE;
		rdaddress <= X"03";
		wait for 2 ps;
		assert (q = X"084C1E30") report "Test 4 failed. 'Q' WRONG." severity ERROR;
		
		report "Running Test 5" severity NOTE;
		wraddress <= X"04";
		data <= X"0003ABC1";
		wren <= '1';
		rdaddress <= X"04";
		wait for 4 ps;
		assert (q = X"0003ABC1") report "Test 5 failed. 'Q' WRONG." severity ERROR;
	wait; -- end process	
	end process mem_test;
end DATA_MEM_TB;