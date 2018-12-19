LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
ENTITY RegFile is
Generic(registers: integer :=8;
	wordSize: integer :=16);
port	(my_busA: out std_logic_vector(wordSize-1 downto 0);
	 my_busB: out std_logic_vector(wordSize-1 downto 0);
	 my_busC: in std_logic_vector(wordSize-1 downto 0);
	 dst_en, src_enA, src_enB, rst, clk: in std_logic;
	 src, dst: in std_logic_vector(integer(ceil(log2(real(registers))))-1 downto 0));
END ENTITY RegFile;

ARCHITECTURE Reg of RegFile is

COMPONENT MyRegister is
Generic(wordSize:integer :=16);
port	(D: in std_logic_vector(wordSize-1 downto 0);
	 en, clk, rst: in std_Logic;
	 Q: out std_logic_vector(wordSize-1 downto 0));
END COMPONENT;	

COMPONENT Decoder2_4 is
Generic(selectors: integer :=2);
port	(input: in std_logic_vector(selectors-1 downto 0);
	 en: in std_logic;
	 output: out std_logic_vector((2**selectors)-1 downto 0));
END COMPONENT;

COMPONENT tristate is
Generic(wordSize:integer :=16);
port	(input: in std_logic_vector(wordSize-1 downto 0);
	 ctrl: in std_logic;
	 output: out std_logic_vector(wordSize-1 downto 0));
END COMPONENT;

SUBTYPE word is std_logic_vector(wordSize - 1 downto 0);
TYPE regFileType is array(0 to registers-1) of word;

SIGNAL regDs: regFileType; 
SIGNAL regQs: regFileType; 
SIGNAL dec_src: std_logic_vector(registers - 1 downto 0);
SIGNAL dec_dst: std_logic_vector(registers - 1 downto 0);
SIGNAL src_en: std_logic;
SIGNAL tempA: std_logic_vector(registers - 1 downto 0);
SIGNAL tempB: std_logic_vector(registers - 1 downto 0);
BEGIN
	src_en <= src_enA OR src_enB;
	MyDecSrc: Decoder2_4 GENERIC MAP(integer(ceil(log2(real(registers))))) PORT MAP(src, src_en, dec_src);
	MyDecDst: Decoder2_4 GENERIC MAP(integer(ceil(log2(real(registers))))) PORT MAP(dst, dst_en, dec_dst);
	loop1: for i in 0 to registers - 1 GENERATE
		tempA(i) <= dec_src(i) AND src_enA;
		tempB(i) <= dec_src(i) AND src_enB;
		REG: MyRegister Generic Map(wordSize) Port Map (my_busC, dec_dst(i), clk, rst, regQs(i));
		TRI_A: tristate Generic Map(wordSize) Port Map(regQs(i), tempA(i), my_busA);
		TRI_B: tristate Generic Map(wordSize) Port Map(regQs(i), tempB(i), my_busB);
	END GENERATE;


END ARCHITECTURE;
	 