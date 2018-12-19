Library IEEE;
use ieee.std_logic_1164.all;
entity OneOpMapper is
port   (Instruction: in std_logic_vector(15 downto 0);
	ALUCode: out std_logic_vector(3 downto 0));
end entity OneOpMapper;

Architecture Dataflow of OneOpMapper is
Begin
	ALUCode(3 downto 0) <= Instruction(9 downto 6);
end Architecture;