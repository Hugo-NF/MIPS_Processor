library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_SHIFTER is
	generic (K: natural := 2);
	port(
		imm26	: in  std_logic_vector(25 downto 0);
		sig28 : out std_logic_vector(27 downto 0)
	);
end MIPS_SHIFTER;

architecture behavioral of MIPS_SHIFTER is
signal temp : std_logic_vector(27 downto 0);
begin
	temp <= std_logic_vector(resize(signed(imm26), sig28'length));
	sig28 <= std_logic_vector(shift_left(unsigned(temp), K));
end behavioral;