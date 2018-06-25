library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_ADDER is
	port (
			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
			output :					out std_logic_vector(WORD_SIZE-1 downto 0)			
	);
end MIPS_ADDER;

architecture behavioral of MIPS_ADDER is
begin	
	output <= std_logic_vector(unsigned(oprA) + unsigned(oprB));
end behavioral;

