library ieee;
use ieee.std_logic_1164.all;

entity MIPS_LATCH is
	port(	S: 	in		std_logic;
			R: 	in		std_logic;
			Q: 	inout	std_logic;
			NQ:	inout	std_logic
			);
end MIPS_LATCH;

architecture behavioral of MIPS_LATCH is
begin
	Q <= R nor NQ;
	NQ <= S nor Q;
end behavioral;