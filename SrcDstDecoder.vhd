Library IEEE;
use ieee.std_logic_1164.all;


ENTITY srcdstDecoder IS 
PORT (Instruction: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	RsrcoutA,RsrcoutB,RsrcinC,RdstoutA,RdstoutB,RdstinC,OneOp,TwoOp: IN STD_LOGIC;
	Rsrc,Rdst: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	enSrcA,enSrcB,enDst: OUT STD_LOGIC);
END ENTITY srcdstDecoder;


ARCHITECTURE Data_Flow OF srcdstDecoder IS 

BEGIN
Rsrc <= Instruction(8 DOWNTO 6) WHEN  TwoOp = '1' and (RsrcoutA = '1' or RsrcoutB= '1')
ELSE Instruction(2 DOWNTO 0) WHEN RdstoutA = '1' or RdstoutB ='1';

Rdst <= Instruction(8 DOWNTO 6) WHEN TwoOp = '1' and RsrcinC = '1'
ELSE Instruction(2 DOWNTO 0) WHEN RdstinC = '1';




enSrcA <= '1' WHEN RsrcoutA = '1' or RdstoutA = '1'
ELSE '0';

enSrcB <= '1' WHEN RsrcoutB = '1'or RdstoutB = '1'
ELSE '0';

enDst <= '1' WHEN RsrcinC = '1' or RdstinC = '1'
ELSE '0' ;




END ARCHITECTURE;