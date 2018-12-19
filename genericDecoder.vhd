Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY genericDecoder is
Generic(selectors: integer :=2);
port	(input: in std_logic_vector(selectors-1 downto 0);
	 en: in std_logic;
	 output: out std_logic_vector((2**selectors)-1 downto 0));
END ENTITY genericDecoder;

ARCHITECTURE Decode of genericDecoder is

BEGIN
	PROCESS(en, input)
	BEGIN
		IF en='0' THEN
			output <= (others=>'0');
		ELSE
			output <= (others => '0'); -- default
			output(to_integer(unsigned(input))) <= '1';
		END IF;
	END PROCESS;
END ARCHITECTURE;