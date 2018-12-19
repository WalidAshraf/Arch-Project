Library IEEE;
use ieee.std_logic_1164.all;
entity Mux2 is
port   (A,B: in std_logic_vector(15 downto 0);
	S: in std_logic;
	F: out std_logic_vector(15 downto 0));
end entity Mux2;

Architecture Dataflow of Mux2 is
Begin
	F <= A when S='0'
	else B;
end Architecture;