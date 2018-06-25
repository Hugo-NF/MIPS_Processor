library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_MUX_21 is
generic (SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(SIZE-1 downto 0);
		signalB	: in std_logic_vector(SIZE-1 downto 0);
		sel		: in std_logic;
		output	: out std_logic_vector(SIZE-1 downto 0)
	);
end MIPS_MUX_21;

architecture behavioral of MIPS_MUX_21 is
begin
	output <= signalB when sel = '1' else
				 signalA;
end behavioral;