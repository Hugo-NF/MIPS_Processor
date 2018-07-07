library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_DEBUG is
	port(
		signal0: 		in std_logic_vector(31 downto 0);
		signal1: 		in std_logic_vector(31 downto 0);
		signal2: 		in std_logic_vector(31 downto 0);
		signal3: 		in std_logic_vector(31 downto 0);
		signal4: 		in std_logic_vector(31 downto 0);
		signal5: 		in std_logic_vector(31 downto 0);
		signal6: 		in std_logic_vector(31 downto 0);
		signal7: 		in std_logic_vector(31 downto 0);
		signal8: 		in std_logic_vector(31 downto 0);
		signal9: 		in std_logic_vector(31 downto 0);
		signal10: 		in std_logic_vector(31 downto 0);
		signal11: 		in std_logic_vector(31 downto 0);
		signal12: 		in std_logic_vector(31 downto 0);
		signal13: 		in std_logic_vector(31 downto 0);
		signal14: 		in std_logic_vector(31 downto 0);
		signal15: 		in std_logic_vector(31 downto 0);
		signal16: 		in std_logic_vector(31 downto 0);
		signal17: 		in std_logic_vector(31 downto 0);
		signal18: 		in std_logic_vector(31 downto 0);
		signal19: 		in std_logic_vector(31 downto 0);
		signal20: 		in std_logic_vector(31 downto 0);
		signal21: 		in std_logic_vector(31 downto 0);
		signal22: 		in std_logic_vector(31 downto 0);
		signal23: 		in std_logic_vector(31 downto 0);
		signal24: 		in std_logic_vector(31 downto 0);
		signal25: 		in std_logic_vector(31 downto 0);
		signal26: 		in std_logic_vector(31 downto 0);
		signal27: 		in std_logic_vector(31 downto 0);
		signal28: 		in std_logic_vector(31 downto 0);
		signal29: 		in std_logic_vector(31 downto 0);
		signal30: 		in std_logic_vector(31 downto 0);
		signal31: 		in std_logic_vector(31 downto 0);
		sig_select:		in std_logic_vector(4 downto 0);
		hex0:				out std_logic_vector(0 to 6);
		hex1:				out std_logic_vector(0 to 6);
		hex2:				out std_logic_vector(0 to 6);
		hex3:				out std_logic_vector(0 to 6);
		hex4:				out std_logic_vector(0 to 6);
		hex5:				out std_logic_vector(0 to 6);
		hex6:				out std_logic_vector(0 to 6);
		hex7:				out std_logic_vector(0 to 6)
	);
end MIPS_DEBUG;

architecture behavioral of MIPS_DEBUG is
component MIPS_MUX_321 is
	generic (SIZE : natural := 32);
	port(
		signal0	: in std_logic_vector(SIZE-1 downto 0);
		signal1	: in std_logic_vector(SIZE-1 downto 0);
		signal2	: in std_logic_vector(SIZE-1 downto 0);
		signal3	: in std_logic_vector(SIZE-1 downto 0);
		signal4	: in std_logic_vector(SIZE-1 downto 0);
		signal5	: in std_logic_vector(SIZE-1 downto 0);
		signal6	: in std_logic_vector(SIZE-1 downto 0);
		signal7	: in std_logic_vector(SIZE-1 downto 0);
		signal8	: in std_logic_vector(SIZE-1 downto 0);
		signal9	: in std_logic_vector(SIZE-1 downto 0);
		signal10	: in std_logic_vector(SIZE-1 downto 0);
		signal11	: in std_logic_vector(SIZE-1 downto 0);
		signal12	: in std_logic_vector(SIZE-1 downto 0);
		signal13	: in std_logic_vector(SIZE-1 downto 0);
		signal14	: in std_logic_vector(SIZE-1 downto 0);
		signal15	: in std_logic_vector(SIZE-1 downto 0);
		signal16	: in std_logic_vector(SIZE-1 downto 0);
		signal17	: in std_logic_vector(SIZE-1 downto 0);
		signal18	: in std_logic_vector(SIZE-1 downto 0);
		signal19	: in std_logic_vector(SIZE-1 downto 0);
		signal20	: in std_logic_vector(SIZE-1 downto 0);
		signal21	: in std_logic_vector(SIZE-1 downto 0);
		signal22	: in std_logic_vector(SIZE-1 downto 0);
		signal23	: in std_logic_vector(SIZE-1 downto 0);
		signal24	: in std_logic_vector(SIZE-1 downto 0);
		signal25	: in std_logic_vector(SIZE-1 downto 0);
		signal26	: in std_logic_vector(SIZE-1 downto 0);
		signal27	: in std_logic_vector(SIZE-1 downto 0);
		signal28	: in std_logic_vector(SIZE-1 downto 0);
		signal29	: in std_logic_vector(SIZE-1 downto 0);
		signal30	: in std_logic_vector(SIZE-1 downto 0);
		signal31	: in std_logic_vector(SIZE-1 downto 0);	
		sel		: in std_logic_vector(4 downto 0);
		output	: out std_logic_vector(SIZE-1 downto 0)
	);
end component;

component convbinario7seg is
  port( numbinario : in STD_LOGIC_VECTOR(3 downto 0);
        num7seg : out STD_LOGIC_VECTOR(0 to 6) );
end component;

signal current : std_logic_vector(31 downto 0);
begin
	SEL:	MIPS_MUX_321 generic map(SIZE => 32)
							port map(signal0 => signal0,
										signal1 => signal1,
										signal2 => signal2,
										signal3 => signal3,
										signal4 => signal4,
										signal5 => signal5,
										signal6 => signal6,
										signal7 => signal7,
										signal8 => signal8,
										signal9 => signal9,
										signal10 => signal10,
										signal11 => signal11,
										signal12 => signal12,
										signal13 => signal13,
										signal14 => signal14,
										signal15 => signal15,
										signal16 => signal16,
										signal17 => signal17,
										signal18 => signal18,
										signal19 => signal19,
										signal20 => signal20,
										signal21 => signal21,
										signal22 => signal22,
										signal23 => signal23,
										signal24 => signal24,
										signal25 => signal25,
										signal26 => signal26,
										signal27 => signal27,
										signal28 => signal28,
										signal29 => signal29,
										signal30 => signal30,
										signal31 => signal31,
										sel => sig_select, output => current);
	display0: convbinario7seg port map(numbinario => current(3 downto 0), num7seg => hex0);
	display1: convbinario7seg port map(numbinario => current(7 downto 4), num7seg => hex1);
	display2: convbinario7seg port map(numbinario => current(11 downto 8), num7seg => hex2);
	display3: convbinario7seg port map(numbinario => current(15 downto 12), num7seg => hex3);
	display4: convbinario7seg port map(numbinario => current(19 downto 16), num7seg => hex4);
	display5: convbinario7seg port map(numbinario => current(23 downto 20), num7seg => hex5);
	display6: convbinario7seg port map(numbinario => current(27 downto 24), num7seg => hex6);
	display7: convbinario7seg port map(numbinario => current(31 downto 28), num7seg => hex7);

end behavioral;