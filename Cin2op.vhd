Library IEEE;
use ieee.std_logic_1164.all;
entity Cin2op is
port   (Instruction: in std_logic_vector(15 downto 0);
	Carry: in std_logic;
	cin2: out std_logic);
end entity Cin2op;

Architecture Dataflow of Cin2op is
SIGNAL InvCarry: std_logic;
Begin
	InvCarry <= NOT Carry;
	cin2 <= Instruction(14) OR (Instruction(15) AND Instruction(13)) OR (Instruction(13) AND InvCarry) OR (Instruction(15) AND Carry);
end Architecture;