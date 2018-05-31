library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_REGS_TB is
end MIPS_REGS_TB;


architecture REGS_TB of MIPS_REGS_TB is

component MIPS_REGS is
generic (WORD_SIZE : natural := 32);  
	port (   
		clk, wren, rst  : 	in std_logic;   
		radd1, radd2, wadd : in std_logic_vector(4 downto 0);   
		wdata    : 				in std_logic_vector(WORD_SIZE-1 downto 0);   
		r1, r2   : 				out std_logic_vector(WORD_SIZE-1 downto 0)
	); 
end component;

constant WORD_SIZE: integer := 32;
signal clk, wren, rst  : 		std_logic;  
signal radd1, radd2, wadd : 	std_logic_vector(4 downto 0);   
signal wdata    :					std_logic_vector(WORD_SIZE-1 downto 0);   
signal r1, r2   :					std_logic_vector(WORD_SIZE-1 downto 0);
	
begin
	
	DUT: MIPS_REGS port map(clk => clk, wren => wren, rst => rst, radd1 => radd1, radd2 => radd2, wadd => wadd, wdata => wdata, r1 => r1, r2 => r2);
	
	clock: process
	begin
		for i in 0 to 256 loop
			clk <= '0';
			wait for 2 ps;
			clk <= '1';
			wait for 2 ps;
		end loop;
		wait;
	end process clock;
	
	test: process
	begin
		report "Initializing tests..." severity NOTE;
		
		report "Writing all registers" severity NOTE;
		wait for 2 ps;
		
		wren <= '1'; -- Escrevendo nos 32 registradores
		
		for i in 1 to 31 loop
			wdata <= std_logic_vector(to_unsigned(i, WORD_SIZE));
			wadd <= std_logic_vector(to_unsigned(i, 5));
			wait for 4 ps;
		end loop;
		
		wren <= '0';
		
		report "Reading all registers" severity NOTE;
		-- Lendo dos registradores
		for i in 0 to 31 loop
			radd1 <= std_logic_vector(to_unsigned(i, 5));
			radd2 <= std_logic_vector(to_unsigned(i, 5));
			wait for 4 ps;
		
			assert r1 = std_logic_vector(to_unsigned(i, WORD_SIZE))
			report "Register r1 wrong. Expected: "&integer'image(i)&"." severity ERROR;
			assert r2 = std_logic_vector(to_unsigned(i, WORD_SIZE))
			report "Register r2 wrong. Expected: "&integer'image(i)&"." severity ERROR;
		end loop;
		
		report "Writing $zero register" severity NOTE;
		-- Tentando alterar o $zero
		wdata <= X"FFFFFFFF";
		wadd <= "00000";
		wren <= '1';
		wait for 4 ps;
		wren <= '0';
		
		report "Reading $zero register" severity NOTE;
		-- Lendo o $zero
		radd1 <= "00000";
		wait for 4 ps;
		assert r1 = X"00000000" report "Register $zero was changed" severity ERROR;
	
		report "Reseting BREG" severity NOTE;
		-- Usando o reset
		rst <= '1';
		wait for 2 ps;
		rst <= '0';
		wait for 2 ps;
		
		report "Reading and asserting 0" severity NOTE;
		-- Lendo os registradores
		for i in 0 to 31 loop
			radd1 <= std_logic_vector(to_unsigned(i, 5));
			radd2 <= std_logic_vector(to_unsigned(i, 5));
			wait for 4 ps;
			assert r1 = X"00000000" report "Reg "&integer'image(i)&" is not zero" severity ERROR; 
			assert r2 = X"00000000" report "Reg "&integer'image(i)&" is not zero" severity ERROR;
		end loop;
	
		-- Alterar e ler no mesmo ciclo
		radd1 <= std_logic_vector(to_unsigned(1, 5));
		wadd <= std_logic_vector(to_unsigned(1, 5));
		wdata <= X"ABCDEF01";
		wren <= '1';
		wait for 2 ps;
		wren <= '0';
		wait for 2 ps;
		assert (r1 = X"ABCDEF01") report "Written value has not changed register in this cycle" severity ERROR;
		wait;
	end process test;
end REGS_TB;