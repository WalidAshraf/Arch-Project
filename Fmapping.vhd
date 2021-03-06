LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.math_real.all;
use ieee.numeric_std.all;


ENTITY FMapping IS 
PORT(AplusB,Aminus1,A,Aplus1: IN STD_LOGIC;
	Fmapper: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)); -- to map the hardcoded functions 

END ENTITY FMapping;



ARCHITECTURE Data_Flow OF FMapping IS 
BEGIN

Fmapper <= "0001" WHEN AplusB = '1'
ELSE "0011" WHEN Aminus1 = '1'
ELSE "0000" WHEN Aplus1 = '1'
ELSE "0000" WHEN A = '1';


END ARCHITECTURE Data_Flow;