library ieee;
use ieee.std_logic_1164.all;

entity MIPS_REGISTER_TB is
end MIPS_REGISTER_TB;

architecture REGISTER_TB of MIPS_REGISTER_TB is

component MIPS_REGISTER is
	port(
		clock: in		std_logic;
		load:	in			std_logic_vector(31 downto 0);
		current: out	std_logic_vector(31 downto 0)
	);
end component;

signal clock:		std_logic;
signal load:		std_logic_vector(31 downto 0);
signal current:	std_logic_vector(31 downto 0);

begin
	DUT: MIPS_REGISTER port map(clock => clock, load => load, current => current);
	
	sync: process
	begin
		for i in 0 to 256 loop
			clock <= '1';
			wait for 1 ps;
			clock <= '0';
			wait for 1 ps;
		end loop;
		wait;
	end process sync;

	test: process
	begin
		report "Initializing tests..." severity NOTE;
	
		load <= X"00000004";
		wait for 2 ps;
		
		assert(current <= X"00000004") report "" severity ERROR;
		wait;
	end process test;
	
end REGISTER_TB;