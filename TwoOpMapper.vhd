Library IEEE;
use ieee.std_logic_1164.all;
entity TwoOpMapper is
port   (Instruction: in std_logic_vector(15 downto 0);
	ALUCode: out std_logic_vector(3 downto 0));
end entity TwoOpMapper;

Architecture Dataflow of TwoOpMapper is
SIGNAL C3, C2: std_logic;
Begin
	C3 <= '0';
	C2 <= '0' WHEN Instruction(15) = '1' AND Instruction(14) = '1'
		  ELSE Instruction(14);
	ALUCode(3) <= C3;
	ALUCode(2) <= C2;
	ALUCode(1 downto 0) <= Instruction(13 downto 12);
end Architecture;