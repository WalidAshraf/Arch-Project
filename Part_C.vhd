Library IEEE;
use ieee.std_logic_1164.all;
entity Part_C is
port   (A: in std_logic_vector(15 downto 0);
	Cin,S0,S1: in std_logic;
	Cout: out std_logic;
	F: out std_logic_vector(15 downto 0));
end entity Part_C;

Architecture Shifts of Part_C is
Begin
	F <= '0' & A(15 downto 1) when S1='0' and S0='0'
	else A(0)& A(15 downto 1) when S1='0' and S0='1'
        else Cin & A(15 downto 1) when S1='1' and S0='0'
	else A(15) & A(15 downto 1) when S1='1' and S0='1';
	Cout <= A(0);
end Architecture;