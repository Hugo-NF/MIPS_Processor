library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_MUX_321 is
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
end MIPS_MUX_321;

architecture behavioral of MIPS_MUX_321 is
begin
	output <= signal0	 	when sel = "00000" else
				 signal1		when sel = "00001" else
				 signal2		when sel = "00010" else
				 signal3		when sel = "00011" else
				 signal4		when sel = "00100" else
				 signal5		when sel = "00101" else
				 signal6		when sel = "00110" else
				 signal7		when sel = "00111" else
				 signal8		when sel = "01000" else
				 signal9		when sel = "01001" else
				 signal10 	when sel = "01010" else
				 signal11 	when sel = "01011" else
				 signal12 	when sel = "01100" else
				 signal13 	when sel = "01101" else
				 signal14 	when sel = "01110" else
				 signal15 	when sel = "01111" else
				 signal16 	when sel = "10000" else
				 signal17 	when sel = "10001" else
				 signal18 	when sel = "10010" else
				 signal19 	when sel = "10011" else
				 signal20 	when sel = "10100" else
				 signal21 	when sel = "10101" else
				 signal22 	when sel = "10110" else
				 signal23 	when sel = "10111" else
				 signal24 	when sel = "11000" else
				 signal25 	when sel = "11001" else
				 signal26 	when sel = "11010" else
				 signal27 	when sel = "11011" else
				 signal28 	when sel = "11100" else
				 signal29 	when sel = "11101" else
				 signal30 	when sel = "11110" else
				 signal31;              
end behavioral;