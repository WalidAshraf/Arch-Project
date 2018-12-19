Library IEEE;
use ieee.std_logic_1164.all;
entity Mux4 is
port   (A,B,C,D: in std_logic_vector(15 downto 0);
	S: in std_logic_vector(1 downto 0);
	F: out std_logic_vector(15 downto 0));
end entity Mux4;

Architecture Structural of Mux4 is
	component Mux2 is
	port   (A,B: in std_logic_vector(15 downto 0);
		S: in std_logic;
		F: out std_logic_vector(15 downto 0));
	end component;
	Signal X1, X2: std_logic_vector(15 downto 0);	
Begin
	M1:Mux2 port map(A,B,S(0),X1);
	M2:Mux2 port map(C,D,S(0),X2);
	M3:Mux2 port map(X1,X2,S(1),F);
end Architecture;


--Architecture Statements of Mux4 is
--Begin
--	F <= A when S="00"
--	else B when S="01"
--	else C when S="10"
--	else D when S="11";
--end Architecture;