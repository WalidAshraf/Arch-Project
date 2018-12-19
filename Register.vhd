Library IEEE;
use ieee.std_logic_1164.all;

ENTITY MyRegister is
Generic(wordSize:integer :=16);
port	(D: in std_logic_vector(wordSize-1 downto 0);
	 en, clk, rst: in std_Logic;
	 Q: out std_logic_vector(wordSize-1 downto 0));
END ENTITY MyRegister;

ARCHITECTURE Reg of MyRegister is
BEGIN
	PROCESS(clk, en, rst)
	BEGIN
		IF rst ='1' THEN
			Q <= (others=>'0');
		ELSIF rising_edge(clk) AND en='1' THEN
			Q <= D;
		END IF;
	END PROCESS;
END ARCHITECTURE;