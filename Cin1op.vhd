Library IEEE;
use ieee.std_logic_1164.all;
entity Cin1op is
port   (Instruction: in std_logic_vector(15 downto 0);
	Carry: in std_logic;
	cin1: out std_logic);
end entity Cin1op;

Architecture Dataflow of Cin1op is
Begin
	cin1 <= (Instruction(11) AND Carry) OR Instruction(10);
end Architecture;
