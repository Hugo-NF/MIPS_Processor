library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS_CONSTANTS.all;

entity MIPS_ALU is
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
			when ULA_AND =>
				next_output := oprA and oprB;
			when ULA_OR =>
				next_output := oprA or oprB;
			when ULA_ADD =>
				next_output := std_logic_vector(signed(oprA) + signed(oprB));
			when ULA_ADDU =>
				next_output := std_logic_vector(unsigned(oprA) + unsigned(oprB));
			when ULA_SUB =>
				next_output := std_logic_vector(signed(oprA) - signed(oprB));
			when ULA_SUBU =>
				next_output := std_logic_vector(unsigned(oprA) - unsigned(oprB));
			when ULA_SLT =>
				if(signed(oprA) < signed(oprB)) then
					next_output := X"00000001";
				else
					next_output := X"00000000";
				end if;
			when ULA_SLTU =>
				if(unsigned(oprA) < unsigned(oprB)) then
					next_output := X"00000001";
				else
					next_output := X"00000000";
				end if;
			when ULA_NOR =>
				next_output := oprA nor oprB;
			when ULA_XOR =>
				next_output := oprA xor oprB;
			when ULA_SLL =>
				next_output := std_logic_vector(shift_left(unsigned(oprB), to_integer(unsigned(oprA))));
			when ULA_SRL =>
				next_output := std_logic_vector(shift_right(unsigned(oprB), to_integer(unsigned(oprA))));
			when ULA_SRA =>
				next_output := std_logic_vector(shift_right(signed(oprB), to_integer(unsigned(oprA))));
			when ULA_RTR =>
				next_output := std_logic_vector(rotate_right(signed(oprB), to_integer(unsigned(oprA))));
			when ULA_RTL =>
				next_output := std_logic_vector(rotate_left(signed(oprB), to_integer(unsigned(oprA))));
			when ULA_LUI =>
				next_output := oprB(15 downto 0) & X"0000";
			when others =>
				next_output := X"00000000"; 
		end case;
	
		if(opcode = ULA_ADD) then
			ovfl <= ((oprA(BIT_SIGN) and oprB(BIT_SIGN) and (not(next_output(BIT_SIGN)))) or (not(oprA(BIT_SIGN)) and (not(oprB(BIT_SIGN))) and next_output(BIT_SIGN)) );
		elsif (opcode = ULA_SUB) then
			ovfl <= ((oprA(BIT_SIGN) and (not(oprB(BIT_SIGN))) and (not(next_output(BIT_SIGN)))) or (not(oprA(BIT_SIGN)) and oprB(BIT_SIGN) and next_output(BIT_SIGN)) );
		else
			ovfl <= '0';
		end if;
		
		if(next_output = X"00000000") then zero <= '1'; else zero <= '0'; end if;
		output <= next_output;
		
	end process;
end behavioral;