Library IEEE;
use ieee.std_logic_1164.all;
entity CinGen is
port   (Instruction: in std_logic_vector(15 downto 0);
	Carry, OneOp, TwoOp: in std_logic;
	cin: out std_logic);
end entity CinGen;

Architecture Dataflow of CinGen is
SIGNAL cin1, cin2: std_logic;
Begin
	C1: ENTITY work.Cin1op PORT MAP(Instruction, Carry, cin1);
	C2: ENTITY work.Cin2op PORT MAP(Instruction, Carry, cin2);
	cin <= (cin1 AND OneOp) OR (cin2 AND TwoOp);
end Architecture;