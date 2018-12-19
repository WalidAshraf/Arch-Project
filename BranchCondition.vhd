Library IEEE;
use ieee.std_logic_1164.all;
entity BranchCondition is
port   (Instruction: in std_logic_vector(15 downto 0);
	Carry, Zero: in std_logic;
	Result: out std_logic);
end entity BranchCondition;

Architecture Dataflow of BranchCondition is
SIGNAL bXorC, bXorZ, term1, term2 : std_logic;
Begin
	--11 -> 9
	bXorC <= Instruction(9) XOR Carry;
	bXorZ <= Instruction(9) XOR Zero;
	term1 <= Instruction(10) AND bXorC AND ( NOT Instruction(11) OR (NOT Zero));
	term2 <= Instruction(11) AND (NOT Instruction(10)) AND bXorZ;

	Result <= term1 OR term2;
	
end Architecture;
