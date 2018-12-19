LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DecodingCircuit IS
PORT(Instruction: in std_logic_vector(15 downto 0);
     OneOp: out std_logic;
     TwoOp: out std_logic;
     Branch: out std_logic;
     NoOp: out std_logic;
     MOV: out std_logic;
     CMP: out std_logic;
     --SrcDirect: out std_logic;
     --SrcAutoInc: out std_logic;
     --SrcAutoDec: out std_Logic;
     --SrcIndexed: out std_logic;
     --DstDirect: out std_logic;
     --DstAutoInc: out std_logic;
     --DstAutoDec: out std_Logic;
     --DstIndexed: out std_logic;
     SrcIndirect: out std_logic;
     DstIndirect: out std_logic
); 
END ENTITY DecodingCircuit;


ARCHITECTURE Decoding OF DecodingCircuit IS
SIGNAL ThreeOnes: std_logic;
SIGNAL ThreeZeros: std_logic;
SIGNAL MyTwoOp: std_logic;
SIGNAL MyBranch: std_logic;
SIGNAL NoOpOrBranch: std_logic;
BEGIN
	ThreeOnes <= Instruction(14) AND Instruction(13) AND Instruction(12);
	ThreeZeros <= NOT(Instruction(11) OR Instruction(10) OR Instruction(9));
	--No op + branch have have 0000 format
	NoOpOrBranch <= NOT Instruction(15) AND ThreeOnes;
	
	--2 op don't have X000X__
	MyTwoOp <= NOT ThreeOnes;
	--MOV = 0000
	MOV <= NOT (Instruction(15) OR Instruction(14) OR Instruction (13) OR Instruction(12));
	--CMP = 1110, no other instruction has 11XX___ among the 2 op
	CMP <= Instruction(15) AND Instruction(14) AND MyTwoOp;
	--Src only exists in two op instructions
	SrcIndirect <= Instruction(11) AND MyTwoOp;
	--Dst doesn't exist in branch and no op
	DstIndirect <= Instruction(5) AND (NOT NoOpOrBranch);
	--One op instructions start with 1111
	OneOp <= Instruction(15) AND ThreeOnes;
	MyBranch <= NoOpOrBranch AND (NOT ThreeZeros);
	NoOp <= NoOpOrBranch AND ThreeZeros;
	--Need to make sure we're in 2 op mode for source decoding
	--SrcDirect <= NOT (Instruction(10) OR Instruction(9)) AND MyTwoOp;
	--SrcAutoInc <= NOT Instruction(10) AND Instruction(9) AND MyTwoOp;
	--SrcAutoDec <= Instruction(10) AND (NOT Instruction(9)) AND MyTwoOp;
	--SrcIndexed <= Instruction(10) AND Instruction(9) AND MyTwoOp;
	--Dst doesn't exist in No Operand or Branch instructions
	--DstDirect <= NOT(Instruction(4) OR Instruction(3)) AND (NOT NoOpOrBranch);
	--DstAutoInc <= NOT Instruction(4) AND Instruction(3) AND (NOT NoOpOrBranch);
	--DstAutoDec <= Instruction(4) AND (NOT Instruction(3)) AND (NOT NoOpOrBranch);
	--DstIndexed <= Instruction(4) AND Instruction(3) AND (NOT NoOpOrBranch);
	
	TwoOp <= MyTwoOp;
	Branch <= MyBranch;
	
END ARCHITECTURE;