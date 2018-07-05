library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_REGISTER is
	port(
		clock: in		std_logic;
		load:	in			std_logic_vector(WORD_SIZE-1 downto 0);
		current: out	std_logic_vector(WORD_SIZE-1 downto 0) := X"00000000"
	);
end MIPS_REGISTER;

architecture behavioral of MIPS_REGISTER is	
signal current_value: std_logic_vector(WORD_SIZE-1 downto 0);
begin
	sync_proc: process(clock, current_value)
	begin
	current <= current_value;
	if(rising_edge(clock)) then
		current_value <= load;
	end if;
	end process sync_proc;
end behavioral;