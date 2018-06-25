library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_MUX_41 is
	generic (SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(SIZE-1 downto 0);
		signalB	: in std_logic_vector(SIZE-1 downto 0);
		signalC	: in std_logic_vector(SIZE-1 downto 0);
		signalD	: in std_logic_vector(SIZE-1 downto 0);
		sel		: in std_logic_vector(1 downto 0);
		output	: out std_logic_vector(SIZE-1 downto 0)
	);
end MIPS_MUX_41;

architecture behavioral of MIPS_MUX_41 is
begin
	output <= signalD when sel = "11" else
				 signalC when sel = "10" else
				 signalB when sel = "01" else
				 signalA;
end behavioral;