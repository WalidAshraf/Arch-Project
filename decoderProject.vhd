Library IEEE;
use IEEE.std_logic_1164.all;


ENTITY RomDecoder IS	
PORT(romIn: IN STD_LOGIC_VECTOR	(17 DOWNTO 0);
	PCoutA,RsrcoutA,RdstoutA,MARinA,MARinC,
	IRoutA,MDRoutA,MDRinB,TEMPoutB,RdstoutB,PCoutB,AplusB,
	Aminus1,A,Aplus1,ALU,RD,WR,ENDsig,WMFC,RsrcinC,RdstinC,
	MDRinC,TEMPinC,PCinC,IRinC,RsrcoutB,TEMPoutA,Cin: OUT STD_LOGIC);
END ENTITY RomDecoder;



ARCHITECTURE data_flow OF RomDecoder IS 


COMPONENT genericDecoder is
Generic(selectors: integer :=2);
port	(input: in std_logic_vector(selectors-1 downto 0);
	 en: in std_logic;
	 output: out std_logic_vector((2**selectors)-1 downto 0));
END COMPONENT genericDecoder;

SIGNAL F1,F2,F5,F7: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL F3,F4,F8,F10: STD_LOGIC;	
SIGNAL F6,F9: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL outF1,outF2,outF5,outF7: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL outF3,outF4,outF8,outF10: STD_LOGIC_VECTOR(1 DOWNTO 0);	
SIGNAL outF6,outF9: STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

F1 <= romIn(17 DOWNTO 16);
F2 <= romIn(15 DOWNTO 14);
F3 <= romIn(13);
F4 <= romIn(12);
F5 <= romIn(11 DOWNTO 10);
F6 <= romIn(9 DOWNTO 7);
F7 <= romIn(6 DOWNTO 5);
F8 <= romIn(4);
F9 <= romIn(3 DOWNTO 1);
F10 <= romIn(0);

F1Decoder: genericDecoder GENERIC MAP (2) PORT MAP(F1,'1',outF1);
F2Decoder: genericDecoder GENERIC MAP (2) PORT MAP(F2,'1',outF2);
--F3Decoder: genericDecoder GENERIC MAP (1) PORT MAP(F3,'1',outF3);
--F4Decoder: genericDecoder GENERIC MAP (1) PORT MAP(F4,'1',outF4);
F5Decoder: genericDecoder GENERIC MAP (2) PORT MAP(F5,'1',outF5);
F6Decoder: genericDecoder GENERIC MAP (3) PORT MAP(F6,'1',outF6);
F7Decoder: genericDecoder GENERIC MAP (2) PORT MAP(F7,'1',outF7);
--F8Decoder: genericDecoder GENERIC MAP (1) PORT MAP(F8,'1',outF8);
F9Decoder: genericDecoder GENERIC MAP (3) PORT MAP(F9,'1',outF9);
--F10Decoder: genericDecoder GENERIC MAP (1) PORT MAP(F10,'1',outF10);


PCoutA <= outF1(1);
RsrcoutA <= outF1(2);
RdstoutA <= outF1(3);
MARinA <= outF2(1);
MARinC <= outF2(2);
IRoutA <= outF2(3);
MDRoutA <= F3;
MDRinB <= F4;
TEMPoutB <= outF5(1);
RdstoutB <= outF5(2);
PCoutB <= outF5(3);
AplusB <= outF6(1);
Aminus1 <= outF6(2);
A <= outF6(3);
Aplus1 <= outF6(4);
ALU <= outF6(5);
RD <= outF7(1);
WR <= outF7(2);
ENDsig <= outF7(3);
WMFC <= F8;
RsrcinC <= outF9(1);
RdstinC <= outF9(2);
MDRinC <= outF9(3);
TEMPinC <= outF9(4);
PCinC <= outF9(5);
IRinC <= outF9(6);
RsrcoutB <= outF9(7);
TEMPoutA <= F10;
Cin <= outF6(4);


END ARCHITECTURE;





  
