Library IEEE;
use ieee.std_logic_1164.all;
entity Part_A is
port   (A,B: in std_logic_vector(15 downto 0);
	S0,S1: in std_logic;
	cin: in std_logic;
	cout: out std_logic;
	F: out std_logic_vector(15 downto 0));
end entity Part_A;


Architecture My_Design of Part_A is

COMPONENT NBitAdder is
Generic(n:integer :=8);
	port   (a,b: in std_logic_vector(n-1 downto 0);
	cin: in std_logic;
	cout: out std_logic;
	s: out std_logic_vector(n-1 downto 0));
end component;
Component Mux2 is 
	port   (A,B: in std_logic_vector(15 downto 0);
		S: in std_logic;
		F: out std_logic_vector(15 downto 0));
end component;
Component Mux4 is
	port   (A,B,C,D: in std_logic_vector(15 downto 0);
	S: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(15 downto 0));
end component;
SIGNAL Last: std_logic_vector(15 downto 0);
SIGNAL Second: std_logic_vector(15 downto 0);
SIGNAL Sel2: std_logic_vector(1 downto 0);
SIGNAL Inverse1: std_logic_vector(15 downto 0);
SIGNAL Inverse2: std_logic_vector(15 downto 0);
SIGNAL Ones: std_logic_vector(15 downto 0);
SIGNAL Zeroes: std_logic_vector(15 downto 0);
Begin
	Inverse1 <= NOT A;
	Inverse2 <= NOT B;
	Ones <= (others=>'1');
	Zeroes <= (others=>'0');
	Sel2(1) <= S1;
	Sel2(0) <= S0;
	M2: Mux2 port map(Ones, Inverse1, cin, Last);
	M4: Mux4 port map(Zeroes, B, Inverse2, Last, Sel2, Second);
	NBA: NBitAdder Generic Map(16) port map(A, Second, cin, cout, F);
end Architecture;