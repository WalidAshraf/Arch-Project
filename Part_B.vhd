Library IEEE;
use ieee.std_logic_1164.all;
entity Part_B is
port   (A,B: in std_logic_vector(15 downto 0);
	S0,S1: in std_logic;
	F: out std_logic_vector(15 downto 0));
end entity Part_B;

Architecture Statements of Part_B is
Begin
	F <= A and B when S1 = '0' and S0 = '0'
	else A or B when S1 = '0' and S0 = '1'
	else A xor B when S1 = '1' and S0 = '0'
	else not A when S1 = '1' and S0 = '1';
end Architecture;