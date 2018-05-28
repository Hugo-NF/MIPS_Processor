library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_ALU is
	generic (WORD_SIZE : natural := 32);
	port (
			opcode :				 	in std_logic_vector(3 downto 0);
			oprA, oprB :			in std_logic_vector(WORD_SIZE-1 downto 0);
			output :					out std_logic_vector(WORD_SIZE-1 downto 0);
			zero, ovfl :			out std_logic			
	);
end MIPS_ALU;

architecture behavioral of MIPS_ALU is
begin	
	
	ALU_proc: process(opcode, oprA, oprB)
	variable next_output: std_logic_vector(WORD_SIZE-1 downto 0);
	begin
		case opcode is
			when "0000" =>
				next_output := oprA and oprB;
			when "0001" =>
				next_output := oprA or oprB;
			when "0010" =>
				next_output := std_logic_vector(signed(oprA) + signed(oprB));
			when "0011" =>
				next_output := std_logic_vector(unsigned(oprA) + unsigned(oprB));
			when "0100" =>
				next_output := std_logic_vector(signed(oprA) - signed(oprB));
			when "0101" =>
				next_output := std_logic_vector(unsigned(oprA) - unsigned(oprB));
			when "0110" =>
				if(signed(oprA) - signed(oprB) < 0) then
					next_output := X"00000001";
				else
					next_output := X"00000000";
				end if;
			when "0111" =>
				if(unsigned(oprA) - unsigned(oprB) < 0) then
					next_output := X"00000001";
				else
					next_output := X"00000000";
				end if;
			when "1000" =>
				next_output := oprA nor oprB;
			when "1001" =>
				next_output := oprA xor oprB;
			when "1010" =>
				next_output := std_logic_vector(shift_left(unsigned(oprB), to_integer(unsigned(oprA))));
			when "1011" =>
				next_output := std_logic_vector(shift_right(unsigned(oprB), to_integer(unsigned(oprA))));
			when "1100" =>
				next_output := std_logic_vector(shift_right(signed(oprB), to_integer(unsigned(oprA))));
			when "1101" =>
				next_output := std_logic_vector(rotate_right(signed(oprB), to_integer(unsigned(oprA))));
			when "1110" =>
				next_output := std_logic_vector(rotate_left(signed(oprB), to_integer(unsigned(oprA))));
			when others =>
				next_output := X"00000000"; 
		end case;
	
		if(opcode = "0010") then
			ovfl <= ((oprA(31) and oprB(31) and (not(next_output(31)))) or (not(oprA(31)) and (not(oprB(31))) and next_output(31)) );
		elsif (opcode = "0100") then
			ovfl <= ((oprA(31) and (not(oprB(31))) and (not(next_output(31)))) or (not(oprA(31)) and oprB(31) and next_output(31)) );
		else
			ovfl <= '0';
		end if;
		
		if(next_output = X"00000000") then zero <= '1'; else zero <= '0'; end if;
		output <= next_output;
		
	end process;
end behavioral;