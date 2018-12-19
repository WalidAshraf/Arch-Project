Library IEEE;
use ieee.std_logic_1164.all;

entity FlagRegister is
port   (
ALU_A, ALU_B, ALU_OUT : in std_logic_vector(15 downto 0);
Sel_Bits : in std_logic_vector(3 downto 0);

ALU_BIT : in std_logic;

carry, clK, rst : in std_logic;
C, Z, N, P, O : out std_logic
  
);
end entity FlagRegister;

Architecture DataFlow of FlagRegister is

COMPONENT MyRegister is
Generic(wordSize:integer :=16);
port	(D: in std_logic_vector(wordSize-1 downto 0);
	 en, clk, rst: in std_Logic;
	 Q: out std_logic_vector(wordSize-1 downto 0));
END COMPONENT;

	SIGNAL flagsIN : std_logic_vector ( 4 downto 0 );
	SIGNAL flagsOut : std_logic_vector ( 4 downto 0 );

BEGIN

	

	--FLAG_REG: MyRegister Generic Map(5) Port Map (flagsIN, '1', clk, rst, flagsOut);

	C <= carry when ALU_BIT = '1' AND clK = '0'
		ELSE '0' WHEN rst ='1';
	Z <= '1' when ALU_OUT = x"0000" AND clK = '0'
		ELSE '0' when ALU_BIT = '1' AND clK = '0'
		ELSE '0' WHEN rst ='1';
	N <= '1' when ALU_OUT(15) = '1' AND clK = '0'
		ELSE '0' when ALU_BIT = '1' AND clK = '0'
		ELSE '0' WHEN rst ='1';
	P <= NOT ALU_OUT(0) when ALU_BIT = '1' AND clK = '0'
		ELSE '0' WHEN rst ='1';
	O <= '1' 	when ALU_A(15) = '0' AND ALU_B(15) = '0' AND ALU_OUT(15) = '1' AND Sel_Bits = "0001" AND clK = '0'
		ELSE '1' when ALU_A(15) = '1' AND ALU_B(15) = '1' AND ALU_OUT(15) = '0' AND Sel_Bits = "0001" AND clK = '0'
		ELSE '1' when ALU_A(15) = '0' AND ALU_B(15) = '1' AND ALU_OUT(15) = '1' AND Sel_Bits = "0010" AND clK = '0'
		ELSE '1' when ALU_A(15) = '1' AND ALU_B(15) = '0' AND ALU_OUT(15) = '0' AND Sel_Bits = "0010" AND clK = '0'
		ELSE '0' when ALU_BIT = '1' AND clK = '0'
		ELSE '0' WHEN rst ='1';

	


end Architecture;
