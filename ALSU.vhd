Library IEEE;
use ieee.std_logic_1164.all;
entity ALSU is
port   (A,B: in std_logic_vector(15 downto 0);
	S0,S1,S2,S3,Cin: in std_logic;
	Cout: out std_logic;
	F: out std_logic_vector(15 downto 0));
end entity ALSU;

Architecture Arch of ALSU is
COMPONENT Part_A is 
	port   (A,B: in std_logic_vector(15 downto 0);
	S0,S1: in std_logic;
	cin: in std_logic;
	cout: out std_logic;
	F: out std_logic_vector(15 downto 0));
end COMPONENT;

COMPONENT Part_B is
	port   (A,B: in std_logic_vector(15 downto 0);
	S0,S1: in std_logic;
	F: out std_logic_vector(15 downto 0));
end COMPONENT;

COMPONENT Part_C is
	port   (A: in std_logic_vector(15 downto 0);
	Cin,S0,S1: in std_logic;
	Cout: out std_logic;
	F: out std_logic_vector(15 downto 0));
end COMPONENT;

COMPONENT Part_D is
	port   (A: in std_logic_vector(15 downto 0);
	Cin,S0,S1: in std_logic;
	Cout: out std_logic;
	F: out std_logic_vector(15 downto 0));
end COMPONENT;
SIGNAL First: std_logic_vector(15 downto 0);
SIGNAL Second: std_logic_vector(15 downto 0);
SIGNAL Third: std_logic_vector(15 downto 0);
SIGNAL Fourth: std_logic_vector(15 downto 0);
SIGNAL temp1: std_logic;
SIGNAL temp2: std_logic;
SIGNAL temp3: std_logic;
Begin
	PA: Part_A PORT MAP(A, B, S0, S1, Cin, temp1, First);
	PB: Part_B PORT MAP(A, B, S0, S1, Second);
	PC: Part_C PORT MAP(A, Cin, S0, S1, temp2, Third);
	PD: Part_D PORT MAP(A, Cin, S0, S1, temp3, Fourth);
	F <= First when S3='0' AND S2='0'
	else Second when S3='0' AND S2='1'
	else Third when S3='1' AND S2='0'
	else Fourth when S3='1' AND S2='1';
	Cout <= '0' when S3='0' AND S2='1'
	else temp1 when S3='0' AND S2='0'
	else temp2 when S3='1' AND S2='0'
	else temp3 when S3='1' AND S3='1';
	--PROCESS(A, B, S0, S1, S2, S3, Cin)
	--BEGIN
	--	IF(S3 ='0' AND S2='0') THEN
	--		PA: Part_A PORT MAP(A, B, S0, S1, Cin, Cout, F);
	--	ELSIF(S3='0' AND S2='1') THEN
	--		PB: Part_B PORT MAP(A, B, S0, S1, F);
	--	ELSIF(S3='1' AND S2='0') THEN
	--		PC: Part_C PORT MAP(A, Cin, S0, S1, Cout, F);
	--	ELSE
	--		PD: Part_D PORT MAP(A, Cin, S0, S1, Cout, F);
	--	END IF;
	--END PROCESS;
end Architecture;