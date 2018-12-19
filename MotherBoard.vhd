Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



ENTITY  MotherBoard IS 
PORT ();


END ENTITY MotherBoard;

ARCHITECTURE data_flow OF MotherBoard IS

SIGNAL Instruction,busA,busB,busC: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL CarryFlag,ZeroFlag: STD_LOGIC;
SIGNAL MAR_A, MAR_B, MAR_C, MDR_C, MDR_B, MDR_A_Out, src_enA, src_enB, dst_en, rst, 
	clk, we, mem_clk, temp_B_Out, temp_enC,temp_A_Out, IR_enC, 
	IR_A_Out,ALSU_S0,ALSU_S1,ALSU_S2,ALSU_S3,Cin,Cout,Src,Dst: IN STD_LOGIC;
BEGIN




romController: ENTITY.ROMController GENERIC MAP(16,8,16,6,27,16) PORT MAP(Instruction,CarryFlag,ZeroFlag);
Controller: ENTITY.Controller GENERIC MAP(16,8,16) PORT MAP(MAR_A, MAR_B, MAR_C, MDR_C, MDR_B, MDR_A_Out, src_enA, src_enB, dst_en, rst, 
	clk, we, mem_clk, temp_B_Out, temp_enC,temp_A_Out, IR_enC, 
	IR_A_Out,ALSU_S0,ALSU_S1,ALSU_S2,ALSU_S3,Cin,Cout,busA,busC,busB,Src,Dst);


END data_flow;