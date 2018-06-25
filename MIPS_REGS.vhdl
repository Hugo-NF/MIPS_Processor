library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_REGS is   
	port (   
		clk, wren, rst  : 	in std_logic;  
		radd1, radd2, wadd : in std_logic_vector(4 downto 0);   
		wdata    : 				in std_logic_vector(WORD_SIZE-1 downto 0); 
		r1, r2   : 				out std_logic_vector(WORD_SIZE-1 downto 0)
	); 
end MIPS_REGS; 

architecture behavioral of MIPS_REGS is
	
	type regs_array is array(WORD_SIZE-1 downto 0) of std_logic_vector (WORD_SIZE-1 downto 0);
   signal registers: regs_array := (others => X"00000000");
	
	begin
	
	main: process(clk, radd1, radd2) 
	begin
	
		if(rising_edge(clk)) then
			if (wren = '1') then
				if(to_integer(unsigned(wadd)) > 0) then
					registers(to_integer(unsigned(wadd))) <= wdata ;
				end if;
			elsif (rst = '1') then
				registers <= (others => X"00000000");
			end if;		
		end if;
		r1 <= registers(to_integer(unsigned(radd1)));
		r2 <= registers(to_integer(unsigned(radd2)));
	end process main;
end behavioral;
