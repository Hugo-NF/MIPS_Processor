library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_ADDER is
	generic (WORD_SIZE : natural := 32);
	port (
			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
			output :					out std_logic_vector(WORD_SIZE-1 downto 0)			
	);
end MIPS_ADDER;

architecture behavioral of MIPS_ADDER is
begin	
	output <= std_logic_vector(unsigned(oprA) + unsigned(oprB));
end behavioral;

