library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_DEBUG is
	port(
		signalA: 		in std_logic_vector(31 downto 0);
		signalB: 		in std_logic_vector(31 downto 0);
		signalC: 		in std_logic_vector(31 downto 0);
		signalD: 		in std_logic_vector(31 downto 0);
		signalE: 		in std_logic_vector(31 downto 0);
		signalF: 		in std_logic_vector(31 downto 0);
		signalG: 		in std_logic_vector(31 downto 0);
		signalH: 		in std_logic_vector(31 downto 0);
		sig_select:		in std_logic_vector(2 downto 0);
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
component MIPS_MUX_41 is
	generic (SIZE : natural := 32);
	port(
		signalA	: in std_logic_vector(SIZE-1 downto 0);
		signalB	: in std_logic_vector(SIZE-1 downto 0);
		signalC	: in std_logic_vector(SIZE-1 downto 0);
		signalD	: in std_logic_vector(SIZE-1 downto 0);
		sel		: in std_logic_vector(1 downto 0);
		output	: out std_logic_vector(SIZE-1 downto 0)
	);
end component;

component convbinario7seg is
  port( numbinario : in STD_LOGIC_VECTOR(3 downto 0);
        num7seg : out STD_LOGIC_VECTOR(0 to 6) );
end component;

signal mux1_out: std_logic_vector(31 downto 0);
signal mux2_out: std_logic_vector(31 downto 0);
signal current	: std_logic_vector(31 downto 0);
begin

	current <= mux1_out when sig_select(2) = '0' else mux2_out;
	
	mux1:	MIPS_MUX_41 generic map(SIZE => 32)
							port map(signalA => signalA, signalB => signalB, signalC => signalC, signalD => signalD, sel => sig_select(1 downto 0), output => mux1_out);
	mux2:	MIPS_MUX_41 generic map(SIZE => 32)
							port map(signalA => signalE, signalB => signalF, signalC => signalG, signalD => signalH, sel => sig_select(1 downto 0), output => mux2_out);
	display0: convbinario7seg port map(numbinario => current(3 downto 0), num7seg => hex0);
	display1: convbinario7seg port map(numbinario => current(7 downto 4), num7seg => hex1);
	display2: convbinario7seg port map(numbinario => current(11 downto 8), num7seg => hex2);
	display3: convbinario7seg port map(numbinario => current(15 downto 12), num7seg => hex3);
	display4: convbinario7seg port map(numbinario => current(19 downto 16), num7seg => hex4);
	display5: convbinario7seg port map(numbinario => current(23 downto 20), num7seg => hex5);
	display6: convbinario7seg port map(numbinario => current(27 downto 24), num7seg => hex6);
	display7: convbinario7seg port map(numbinario => current(31 downto 28), num7seg => hex7);

end behavioral;