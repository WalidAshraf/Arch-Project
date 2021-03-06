LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
use ieee.numeric_std.all;
ENTITY Controller IS
GENERIC(addressBits: integer :=16;
	registers: integer :=8;
	wordSize: integer :=16);
PORT(MAR_A, MAR_B, MAR_C, MDR_C, MDR_B, MDR_A_Out, src_enA, src_enB, dst_en, rst, clk, we, mem_clk, temp_B_Out, temp_enC,temp_A_Out, IR_enC, 
	IR_A_Out,ALSU_S0,ALSU_S1,ALSU_S2,ALSU_S3,Cin,FALU: in std_logic;
     CarryFlag,ZeroFlag: OUT STD_LOGIC;
     busA,busB: inout std_logic_vector(wordSize - 1 downto 0);
     busC:INOUT std_logic_vector(wordSize -1 downto 0);
     src, dst: IN std_logic_vector(integer(ceil(log2(real(registers))))-1 downto 0));
END Controller;

ARCHITECTURE MyController OF Controller IS
SIGNAL MARen, MDRen,Carry,Cout,NoOpFlag,ParityFlag,OverFlowFlag: std_logic;
SIGNAL MARbus: std_logic_vector(wordSize - 1 downto 0);
SIGNAL MAR_Q, MDR_Q, temp_Q, dataout, IR_Q: std_logic_vector(wordSize - 1 downto 0);
SIGNAL MDR_D, MAR_D: std_logic_vector(addressBits - 1 downto 0);
SIGNAL Offset: std_logic_vector(wordSize - 1 downto 0);
SIGNAL ALUSel: STD_LOGIC_VECTOR(3 downto 0);
BEGIN
	Offset(wordSize - 1 downto 9) <= (others => '0');
	Offset(8 downto 0) <= IR_Q(8 downto 0);
	GenReg: ENTITY work.RegFile GENERIC MAP(registers,wordSize) 
				    PORT MAP(busA,busB,busC, dst_en, src_enA,src_enB, rst, clk, src, dst);
	ALU: ENTITY work.ALSU PORT MAP(busA,busB,ALSU_S0,ALSU_S1,ALSU_S2,ALSU_S3,Cin,Cout,busC); -- should the ALU out a carryout then the flag register be set with it or should the alu set it internally

	MDR: ENTITY work.MyRegister GENERIC MAP(wordSize)
				    PORT MAP(MDR_D, MDRen, clk, rst, MDR_Q);
	MAR: ENTITY work.MyRegister GENERIC MAP(wordSize)
				    PORT MAP(MARbus, MARen, clk, rst, MAR_Q);
	MDRTri: ENTITY work.tristate GENERIC MAP(wordSize) PORT MAP(MDR_Q, MDR_A_Out, busA);
	MEM: ENTITY work.ram GENERIC MAP(addressBits, wordSize)
			     PORT MAP(mem_clk, we, MAR_Q, MDR_Q, dataout);
	temp: ENTITY work.MyRegister GENERIC MAP(wordSize)
				     PORT MAP(busC, temp_enC, clk, rst, temp_Q);

	FlagRegisterFile: ENTITY work.FlagRegister PORT MAP(busA,busB,busC,ALUSel,FALU,Cout,Clk,rst,CarryFlag,
							ZeroFlag,NoOpFlag,ParityFlag,OverFlowFlag);

	IR: ENTITY work.MyRegister GENERIC MAP(wordSize) PORT MAP(busC, IR_enC, clk, rst, IR_Q);
	IRTri: ENTITY work.tristate GENERIC MAP(wordSize) PORT MAP(Offset, IR_A_Out, busA);
	TempTriA: ENTITY work.tristate GENERIC MAP(wordSize) PORT MAP(temp_Q, temp_A_Out, busA);
	TempTriB: ENTITY work.tristate GENERIC MAP(wordSize) PORT MAP(temp_Q, temp_B_Out, busB);

ALUSel <= ALSU_S3&ALSU_S2&ALSU_S1&ALSU_S0;
MARen <= MAR_A or MAR_B or MAR_C;
MARbus <= busA when MAR_A = '1' else busB when MAR_B = '1' else busC when MAR_C = '1';
MDRen <= MDR_B or MDR_C;
MDR_D <= busB when MDR_B = '1' else busC when MDR_C = '1' else dataout;
END ARCHITECTURE;