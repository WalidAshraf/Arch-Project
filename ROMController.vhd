Library IEEE;
use ieee.std_logic_1164.all;
entity ROMController is
GENERIC(RAMAddressBits: integer :=16;
	registers: integer :=8;
	RegWordSize: integer :=16;
	ROMAddressBits: integer := 6;
	ROMWordSize: integer := 27;
	RAMWordSize: integer := 16);
port	(Instruction: in std_logic_vector(RAMWordSize - 1 downto 0));
end entity ROMController;

Architecture Dataflow of ROMController is
--SIGNAL Instruction: std_logic_vector(RAMWordSize - 1 downto 0);
SIGNAL OneOp, TwoOp, Branch, NoOp, MOV, CMP, cin,PCoutA,RsrcoutA,RdstoutA,MARinA,MARinC,
	IRoutA,MDRoutA,MDRinB,TEMPoutB,RdstoutB,PCoutB,AplusB,
	Aminus1,A,Aplus1,ALU,RD,WR,ENDsig,WMFC,RsrcinC,RdstinC,
	MDRinC,TEMPinC,PCinC,IRinC,RsrcoutB,TEMPoutA,CinRom,CarryFlag,ZeroFlag,enA,enB,enC,rstController,clk,we,mem_clk:STD_LOGIC;
SIGNAL busA,busB,busC: STD_LOGIC_VECTOR(RegWordSize -1 DOWNTO 0);
SIGNAL ControlWord: std_logic_vector(ROMWordSize - 1 downto 0);  --7asab grouping Walid
SIGNAL MicroPC: std_logic_vector(ROMAddressBits - 1 downto 0) := "011110";	--3'aleban 6 bits
SIGNAL NextMicroPC: std_logic_vector(ROMAddressBits - 1 downto 0) := "011110";
SIGNAL TEMP: std_logic_vector(ROMAddressBits - 1 downto 0) := (others => '0');
SIGNAL Clock: std_logic := '0';
SIGNAL rst: std_logic := '1';
SIGNAL cinController: STD_LOGIC;
SIGNAL InstructionType: std_logic_vector(1 downto 0);
SIGNAL SrcIndirect, DstIndirect: std_logic;
SIGNAL Result: std_logic;
SIGNAL Fmap: std_logic_vector (3 downto 0);
SIGNAL FmapALU: std_logic_vector (3 downto 0);
SIGNAL BranchType,Src,Dst: std_logic_vector (2 downto 0);
SIGNAL AddressBits: std_logic_vector (5 downto 0);
SIGNAL modeSRC, modeDST: std_logic_vector (1 downto 0);
SIGNAL b8: std_logic;
SIGNAL FMappedDecoded: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL CleanControlWord: std_logic_vector (17 downto 0);
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL falling_edge(Clock);
		--if it's a branch instruction, do bit ORING, store value into NextMicroPC
		MicroPC <= NextMicroPC;
	END PROCESS;
	rst <= '0' after 10 ns;
	Clock <= not Clock after 50 ns;
	modeSRC <= Instruction(10 downto 9);
	modeDST <= Instruction(4 downto 3);
	AddressBits <= ControlWord(8 downto 3);
	BranchType <= ControlWord(2 downto 0);
	b8 <= Instruction(8);
	CleanControlWord <= ControlWord(26 downto 9);
	--Ctrl: ENTITY work.Controller GENERIC MAP(RAMAddressBits, registers, RAMWordSize);
	NewAdd: ENTITY work.NewRomAddress PORT MAP(AddressBits, BranchType, modeSRC, --Performs bit ORING if needed
						      modeDST, InstructionType, SrcIndirect, DstIndirect,
						      TwoOp, OneOp, Branch, NoOp, CMP, MOV,
						      Result, b8, NextMicroPC);

	ROM: ENTITY work.ROM GENERIC MAP(ROMAddressBits, ROMWordSize) PORT MAP(MicroPC, ControlWord);  --Fetch from ROM
	DC: ENTITY work.DecodingCircuit PORT MAP(Instruction, OneOp, TwoOp,  --Gets Instruction type as well as MOV and CMP
						 Branch, NoOp, MOV, CMP, SrcIndirect, DstIndirect);
	C: ENTITY work.CinGen PORT MAP(Instruction, CarryFlag, OneOp, TwoOp, cin);	--Osama's IR dependent ALU cin
	BranchCond: ENTITY work.BranchCondition PORT MAP(Instruction, CarryFlag, ZeroFlag, Result);	--Checks if branching condition is met
	ROMDecoder: ENTITY work.RomDecoder PORT MAP(CleanControlWord,PCoutA,RsrcoutA,RdstoutA,MARinA,MARinC, --Decode ROM control word
						IRoutA,MDRoutA,MDRinB,TEMPoutB,RdstoutB,PCoutB,AplusB,
						Aminus1,A,Aplus1,ALU,RD,WR,ENDsig,WMFC,RsrcinC,RdstinC,
						MDRinC,TEMPinC,PCinC,IRinC,RsrcoutB,TEMPoutA,CinRom);
	FmapEntity: ENTITY work.FMapping PORT MAP(AplusB, Aminus1, A, Aplus1, Fmap);	--Walid's ALU function mapper
	ALUmap: ENTITY work.FmapperALU PORT MAP(Instruction, TwoOp, OneOp, FmapALU);	--Osama's IR dependent ALU function mapper

	Controller: ENTITY work.Controller GENERIC MAP(16,8,16) PORT MAP(MARinA,'0', MARinC, MDRinC, MDRinB, MDRoutA,enA,enB,
	enC,rst,clk, we, mem_clk, TEMPoutB, TEMPinC,TEMPoutA, IRinC,
	IRoutA,FMappedDecoded(0),FMappedDecoded(1),FMappedDecoded(2),FMappedDecoded(3),cinController,ALU,CarryFlag,ZeroFlag,busA,busC,busB,Src,Dst);-- WATCHOUT RST.CLK,WE,MEM_CLK NOT INIT

	SrcDstDec: ENTITY work.SrcDstDecoder PORT MAP(Instruction,RsrcoutA,RsrcoutB,RsrcinC,RdstoutA,RdstoutB,RdstinC,OneOp,TwoOp,Src,Dst,enA,enB,enC);

	cinController <= CinRom when ALU = '0'
	ELSE cin;

	FMappedDecoded <= Fmap WHEN ALU ='0'
	ELSE FmapALU;

	InstructionType <= "00" WHEN TwoOp = '1'
			   ELSE "01" WHEN OneOp = '1'
			   ELSE "10" WHEN Branch = '1'
			   ELSE "11" WHEN NoOp = '1';
	--Increment PC when END is detected only
	--INCREMENTOR: ENTITY work.NBitAdder GENERIC MAP(16) PORT MAP(PC, END, 0, PC);
END Architecture;
