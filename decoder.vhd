LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.math_real.all;


ENTITY decoder IS
PORT(T : IN std_logic_vector(1  DOWNTO 0); en:IN std_logic; decoded : OUT std_logic_vector(3 DOWNTO 0) );

END decoder;

ARCHITECTURE a_decoder OF decoder IS

BEGIN

decoded <= "0000" when en= '0'
else "0001" when T = "00"
else "0010" when T = "01"
else "0100" when T = "10"
else "1000" when T = "11";


END a_decoder;