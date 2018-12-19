Library IEEE;
use ieee.std_logic_1164.all;

ENTITY tristate is
Generic(wordSize:integer :=32);
port	(input: in std_logic_vector(wordSize-1 downto 0);
	 ctrl: in std_logic;
	 output: out std_logic_vector(wordSize-1 downto 0));
END ENTITY tristate;

ARCHITECTURE tri  of tristate is
BEGIN
	output <= input when ctrl='1'
		else (others=>'Z');
END ARCHITECTURE;