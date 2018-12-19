Library IEEE;
use ieee.std_logic_1164.all;
entity ROMController is
GENERIC(RAMAddressBits: integer :=16;
	registers: integer :=8;
	RegWordSize: integer :=16;
	ROMAddressBits: integer := 6;
	ROMWordSize: integer := 20;
	RAMWordSize: integer := 16);
port	(Instruction: in std_logic_vector(RAMWordSize - 1 downto 0);
	 Carry, Zero: in std_logic);
end entity ROMController;

Architecture Dataflow of ROMController is
--SIGNAL Instruction: std_logic_vector(RAMWordSize - 1 downto 0);
SIGNAL OneOp, TwoOp, Branch, NoOp, MOV, CMP, cin,PCoutA,RsrcoutA,RdstoutA,MARinA,MARinC,
	IRoutA,MDRoutA,MDRinB,TEMPoutB,RdstoutB,PCoutB,AplusB,
	Aminus1,A,Aplus1,ALU,RD,WR,ENDsig,WMFC,RsrcinC,RdstinC,
	MDRinC,TEMPinC,PCinC,IRinC,TEMPoutA,CinRom:STD_LOGIC;
SIGNAL ControlWord: std_logic_vector(ROMWordSize - 1 downto 0);  --7asab grouping Walid
SIGNAL MicroPC: std_logic_vector(ROMAddressBits - 1 downto 0) := (others => '0');	--3'aleban 6 bits
SIGNAL NextMicroPC: std_logic_vector(ROMAddressBits - 1 downto 0) := (others => '0');
SIGNAL Clock: std_logic := '0';
SIGNAL rst: std_logic := '1';
SIGNAL cinController: STD_LOGIC;
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL falling_edge(Clock);
		--if it's a branch instruction, do bit ORING, store value into NextMicroPC
		MicroPC <= NextMicroPC;
		NextMicroPC(1) <= '1';
		NextMicroPC(0) <= '1';
		WAIT UNTIL rising_edge(Clock);
		NextMicroPC <= MicroPC;
	END PROCESS;
	rst <= '0' after 10 ns;
	Clock <= not Clock after 50 ns;
	--Ctrl: ENTITY work.Controller GENERIC MAP(RAMAddressBits, registers, RAMWordSize);
	R: ENTITY work.ROM GENERIC MAP(ROMAddressBits, ROMWordSize) PORT MAP(MicroPC, ControlWord);
	DC: ENTITY work.DecodingCircuit PORT MAP(Instruction, OneOp, TwoOp, Branch, NoOp, MOV, CMP);
	C: ENTITY work.CinGen PORT MAP(Instruction, Carry, OneOp, TwoOp, cin);
	ROMDecoder: ENTITY work.RomDecoder PORT MAP(ControlWord,PCoutA,RsrcoutA,RdstoutA,MARinA,MARinC,
						IRoutA,MDRoutA,MDRinB,TEMPoutB,RdstoutB,PCoutB,AplusB,
						Aminus1,A,Aplus1,ALU,RD,WR,ENDsig,WMFC,RsrcinC,RdstinC,
						MDRinC,TEMPinC,PCinC,IRinC,TEMPoutA,CinRom);
	cinController <= CinRom when ALU = '0'
	ELSE cin;
	--Increment PC when END is detected only
	--INCREMENTOR: ENTITY work.NBitAdder GENERIC MAP(16) PORT MAP(PC, END, 0, PC);
END Architecture;
