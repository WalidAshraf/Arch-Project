Library IEEE;
use ieee.std_logic_1164.all;
entity FmapperALU is
port   (Instruction: in std_logic_vector(15 downto 0);
	TwoOp, OneOp: in std_logic;
	ALUCode: out std_logic_vector(3 downto 0));
end entity FmapperALU;

Architecture Dataflow of FmapperALU is
SIGNAL OneOpALUCode: std_logic_vector(3 downto 0);
SIGNAL TwoOpALUCode: std_logic_vector(3 downto 0);
Begin
	OneOpALUCode(3 downto 0) <= Instruction(9 downto 6);
	TwoOpALU: ENTITY work.TwoOpMapper PORT MAP(Instruction, TwoOpALUCode);
	ALUCode <= TwoOpALUCode WHEN TwoOp = '1'
		   ELSE OneOpALUCode WHEN OneOp = '1';
end Architecture;