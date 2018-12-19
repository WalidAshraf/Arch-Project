LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity NewRomAddress is port 
(
address : in std_logic_vector(5 downto 0);
branchType, modeSRC, modeDST, instructionType : in std_logic_vector(1 downto 0);
srcIndirect, dstIndirect, twoOp, oneOp, branch, noOp, cmp, mov, result, b8 : in std_logic;

newAddress : out std_logic_vector(5 downto 0)
);

End Entity NewRomAddress;

Architecture dataFlow of NewRomAddress is

Signal newAddressBranchType1 : std_logic_vector(5 downto 0);
Signal newAddressBranchType2: std_logic_vector(5 downto 0);
Signal newAddressBranchType3: std_logic_vector(5 downto 0);
Signal newAddressBranchType4: std_logic_vector(5 downto 0);
Signal all_mode : std_logic_vector(1 downto 0);
Signal all_indirect : std_logic;

begin

	all_mode <= modeSRC when twoOp = '1'
		ELSE modeDST when oneOp = '1'
		ELSE "00";

	all_indirect <= (twoOp AND srcIndirect) OR ( oneOp AND dstIndirect ) OR ( branch AND result ) OR ( noOp AND b8 );

	newAddressBranchType1(5) <= '0';
	newAddressBranchType1(4 downto 3) <= address(4 downto 3) OR instructionType(1 downto 0);
	newAddressBranchType1(2 downto 1) <= address(2 downto 1) OR all_mode(1 downto 0);
	newAddressBranchType1(0) <= address(0) OR (all_indirect);

	newAddressBranchType2(5 downto 1) <= address(5 downto 1);
	newAddressBranchType2(0) <= address(0) OR srcIndirect;
	

	newAddressBranchType3(5) <= address(5);
	newAddressBranchType3(4) <= address(4) OR (MOV);
	newAddressBranchType3(3) <= '1';
	newAddressBranchType3(2 downto 1) <= address(2 downto 1) OR modeDST;
	newAddressBranchType3(0) <= address(0) OR dstIndirect;

	newAddressBranchType4(5 downto 3) <= address(5 downto 3);
	newAddressBranchType4(2) <= address(2) OR cmp;
	newAddressBranchType4(1) <= address(1);
	newAddressBranchType4(0) <= address(0) OR dstIndirect;

	newAddress <= newAddressBranchType1 WHEN branchType = "00"
		 ELSE newAddressBranchType2 WHEN branchType = "01"
		 ELSE newAddressBranchType3 WHEN branchType = "10"
		 ELSE newAddressBranchType4;

end dataFlow;
