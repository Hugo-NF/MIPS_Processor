library ieee;
use ieee.std_logic_1164.all;

entity MIPS_CONTROL_UNIT is
	port(
		opcode: in			std_logic_vector(5 downto 0);
		funct: in 			std_logic_vector(5 downto 0);
		
		reg_dst: out		std_logic;
		jump: out			std_logic;
		branch: out			std_logic;
		mem_read: out		std_logic;
		alu_opcode: out 	std_logic;
		alu_srcA: out		std_logic;
		alu_srcB: out		std_logic_vector(1 downto 0);
		mem_write: out		std_logic;
		reg_write: out		std_logic
	);
end MIPS_CONTROL_UNIT;

architecture behavioral of MIPS_CONTROL_UNIT is
begin
	-- avaliar todas as saídas
	reg_dst <= '1' when opcode = X"00" and funct = X"00" else
				  '0';
				  
				  
	--Instruções para implementar
	--ADD
	--ADDI
	--ADDIU
	--ADDU
	--AND
	--ANDI
	--BEQ
	--BNE
	--J
	--JAL
	--JR
	--LUI
	--LW
	--NOR
	--OR
	--ORI
	--XOR
	--SLT
	--SLTI
	--SLTU
	--SLL
	--SRL
	--SRA
	--SUB
	--SUBU
	--SW
			
	--Tratamento de exceção: 
	--Overflow		
	--EPC <= next_inst;
	--J 0x4180 ISR ;
	--ERET <= restore; Manual contém formato
	
end behavioral;