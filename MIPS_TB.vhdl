library ieee;
use ieee.std_logic_1164.all;

entity MIPS_TB is
end MIPS_TB;

architecture TB of MIPS_TB is
component MIPS is
	port(	clock_fpga: in	std_logic;
			clock:	in std_logic;
			new_pc:		in std_logic_vector(7 downto 0);
			load_pc:	in std_logic;
			debug:	in std_logic_vector(4 downto 0);
			hex0:	out std_logic_vector(0 to 6);
			hex1:	out std_logic_vector(0 to 6);
			hex2:	out std_logic_vector(0 to 6);
			hex3:	out std_logic_vector(0 to 6);
			hex4:	out std_logic_vector(0 to 6);
			hex5:	out std_logic_vector(0 to 6);
			hex6:	out std_logic_vector(0 to 6);
			hex7:	out std_logic_vector(0 to 6)
	);
end component;

signal clock_fpga:	std_logic;
signal clock:		 	std_logic;
signal new_pc:		 	std_logic_vector(7 downto 0);
signal load_pc:	 	std_logic;
signal debug:			std_logic_vector(4 downto 0);
signal hex0:		 	std_logic_vector(0 to 6);
signal hex1:		 	std_logic_vector(0 to 6);
signal hex2:		 	std_logic_vector(0 to 6);
signal hex3:		 	std_logic_vector(0 to 6);
signal hex4:		 	std_logic_vector(0 to 6);
signal hex5:		 	std_logic_vector(0 to 6);
signal hex6:		 	std_logic_vector(0 to 6);
signal hex7:		 	std_logic_vector(0 to 6);

begin
	DUT: MIPS port map(clock_fpga => clock_fpga, clock => clock, new_pc => new_pc, load_pc => load_pc, debug => debug, 
							hex0 => hex0, hex1 => hex1, hex2 => hex2, hex3 => hex3, hex4 => hex4, hex5 => hex5, hex6 => hex6, hex7 => hex7);
	
	fast_clock: process
	begin
		clock_fpga <= '0';
		wait for 20 ns;
		clock_fpga <= '1';
		wait for 20 ns;
	end process fast_clock;
	
	slow_clock: process
	begin
		clock <= '0';
		wait for 40 ns;
		clock <= '1';
		wait for 40 ns;
	end process slow_clock;
	
	test: process
	begin
	wait;
	end process test;

end TB;