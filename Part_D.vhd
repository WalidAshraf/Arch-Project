Library IEEE;
use ieee.std_logic_1164.all;
entity Part_D is
port   (A: in std_logic_vector(15 downto 0);
	Cin,S0,S1: in std_logic;
	Cout: out std_logic;
	F: out std_logic_vector(15 downto 0));
end entity Part_D;

Architecture Shifts of Part_D is
Begin
	F <= A(14 downto 0) & '0' when S1='0' and S0='0'
	else A(14 downto 0) & A(15) when S1='0' and S0='1'
	else A(14 downto 0) & Cin when S1='1' and S0='0'
	else "0000000000000000";
	Cout <= A(15);
end Architecture;