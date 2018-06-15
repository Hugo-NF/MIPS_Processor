library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_SIGN_EXTEND is
	port(
		imm16	: in  std_logic_vector(15 downto 0);
		sig32 : out std_logic_vector(31 downto 0)
	);
end MIPS_SIGN_EXTEND;

architecture behavioral of MIPS_SIGN_EXTEND is
begin
	sig32 <= std_logic_vector(resize(signed(imm16), sig32'length));
end behavioral;