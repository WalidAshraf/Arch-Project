Library IEEE;
use ieee.std_logic_1164.all;
entity NBitAdder is
Generic(n:integer :=8);
port   (a,b: in std_logic_vector(n-1 downto 0);
	cin: in std_logic;
	s: out std_logic_vector(n-1 downto 0);
	cout: out std_logic);
end entity NBitAdder;

Architecture my_nbitadder of NBitAdder is
COMPONENT my_adder is
	port(a, b, cin: in std_logic;
	     s, cout: out std_logic);
end component;
SIGNAL temp: std_logic_vector(n-1 downto 0);
Begin
	f0: my_adder port map(a(0), b(0), cin, s(0), temp(0));
	loop1: for i in 1 to n-1 generate
		Add: my_adder port map(a(i), b(i), temp(i-1), s(i), temp(i));
	end generate;
	cout <= temp(n-1);
end my_nbitadder;